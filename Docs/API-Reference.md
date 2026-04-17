# API Reference

[Home](../README.md)

---

Order's internals are not intended to be called directly. This page documents them for reference.

---

## Scripts

### [OrderCustomData](../Order/scripts/OrderCustomData/OrderCustomData.gml)

The dedicated script for adding custom commands. Defines a `_custom` struct and merges it into `global.__order` using `__OrderMergeData`. Afterwards, calls `__OrderValidateDatabase`. This is the only script you should edit to extend Order. See [Adding Commands](Adding-Commands.md) for full details.

### [__OrderInit](../Order/scripts/__OrderInit/__OrderInit.gml)

Runs at game start. Creates the `__OrderManager` instance if it does not exist and sets up the `order_api` directories in local app data. Uses a time source to check every frame and restore `__OrderManager` if it has been accidentally deactivated. Outside the IDE, accidental deactivation triggers a fatal error. Inside the IDE, it reactivates silently and logs a trace message.

### [__OrderDatabase](../Order/scripts/__OrderDatabase/__OrderDatabase.gml)

Defines `global.__order` and populates it with all built-in commands. Custom commands should be added in `OrderCustomData`, not here.

### [__OrderExecute](../Order/scripts/__OrderExecute/__OrderExecute.gml)

Parses and executes a command string. Splits input by spaces, looks up the command in `global.__order`, validates argument count, converts arguments, calls the command function, pushes any fixed output, and updates the history. If the command is not found, calls `__OrderFindClosestCommand` and suggests a near match if one exists.

### [__OrderFindClosestCommand](../Order/scripts/__OrderFindClosestCommand/__OrderFindClosestCommand.gml)

Finds the closest matching command to an unknown input string using `__OrderStringDist`. Returns the best match if its edit distance is within a reasonable threshold relative to the input length, otherwise returns an empty string.

### [__OrderMergeData](../Order/scripts/__OrderMergeData/__OrderMergeData.gml)

Merges two command structs together. If a key from the source struct already exists in the destination, the incoming entry is stored with a trailing underscore appended to its name to avoid overwriting the original. Returns the merged struct.

### [__OrderValidateDatabase](../Order/scripts/__OrderValidateDatabase/__OrderValidateDatabase.gml)

Validates every entry in `global.__order` for required fields (`func`, `args`, `help`). Removes invalid entries and logs them. Outside the IDE, they are logged as trace messages and removed. Inside the IDE, invalid entries trigger a fatal error.

### [__OrderError](../Order/scripts/__OrderError/__OrderError.gml)

Displays a fatal `show_error` message prefixed with the Order version number. On browser targets, omits the callstack since it is not available. Every error raised by this function is fatal and halts execution.

### [__OrderTrace](../Order/scripts/__OrderTrace/__OrderTrace.gml)

Logs a message to the GML output window prefixed with `Order API:`. Used throughout Order's internals for diagnostic output.

### [__OrderStringSanitise](../Order/scripts/__OrderStringSanitise/__OrderStringSanitise.gml)

Sanitises a string before it is pushed to the log. Normalises line endings, replaces tabs with spaces according to `ORDER_ESCAPE_TAB_SPACES`, and strips other control characters.

### [__OrderStringWrap](../Order/scripts/__OrderStringWrap/__OrderStringWrap.gml)

Wraps a string to fit within a given pixel width, returning an array of lines. Uses binary search to efficiently find the maximum number of characters that fit on each line. Supports different widths for the first and subsequent lines.

### [__OrderStringDist](../Order/scripts/__OrderStringDist/__OrderStringDist.gml)

Calculates the Damerau-Levenshtein edit distance between two strings. Used by `__OrderFindClosestCommand` to find near matches for unknown commands.

### [__OrderStructGetNamesAlphabetical](../Order/scripts/__OrderStructGetNamesAlphabetical/__OrderStructGetNamesAlphabetical.gml)

Returns the keys of a struct sorted alphabetically. Used by the `help` command and autocomplete to display and cycle through commands in a consistent order.

### [__OrderInfo](../Order/scripts/__OrderInfo/__OrderInfo.gml)

Defines the `ORDER_VERSION` macro.

---

## Object -- __OrderManager

The persistent manager object that drives the console. All console state is stored on this instance.

| Variable | Type | Description |
|---|---|---|
| `log` | Array | The console log entries |
| `history` | Array | Previously entered commands |
| `viewpoint` | Real or undefined | The currently viewed log index. `undefined` when the log is empty |
| `consoleActive` | Bool | Whether the console is currently open |
| `showTrail` | Bool | Whether the text cursor is currently visible |
| `summonConsume` | Bool | Prevents the summon key from being processed twice in one frame |
| `drawDebugActive` | Bool | Whether the physics debug overlay is active |
| `drawDebugExtended` | Bool | Whether the physics debug overlay is in extended mode |
| `autocompleteIndex` | Real | Index of the currently highlighted autocomplete suggestion. `-1` when no suggestions are active |
| `autocompleteSuggestions` | Array | List of current autocomplete suggestions |
| `autocompleteBase` | String | The input string at the time autocomplete was triggered |

### Methods

#### __Push(...)
Pushes one or more strings or arrays of strings to the log. Accepts any number of arguments. Strings containing newlines are split into separate entries. Advances the viewpoint to keep the latest entry visible.

#### __Clear()
Clears the log and history and resets the viewpoint.

#### __IndexLast()
Returns the index of the last entry in the log.

### Events

| Event | Description |
|---|---|
| Create | Initialises all state variables and defines the `__Push`, `__Clear`, and `__IndexLast` methods |
| Step | Processes console input -- Enter to execute, Tab for autocomplete, Escape to dismiss or jump to latest, scrolling, clipboard shortcuts |
| Begin Step | Checks for the summon key and toggles the console |
| End Step | Resets the summon consume flag |
| Draw | Draws the physics debug overlay when active |
| Draw GUI | Draws the console overlay including the input field, text cursor, log, and autocomplete suggestions |
| Alarm 0 | Toggles `showTrail` to pulse the text cursor |
| Game Start | Logs a debug message |
| Game End | Logs a debug message |

---

## Global Struct -- global.__order

The command database. Each key is a command name prefixed with an underscore. See [Adding Commands](Adding-Commands.md) for the full entry structure.

---

## Macros

| Macro | Script | Description |
|---|---|---|
| `ORDER_SUMMON_KEY` | [OrderConfig](../Order/scripts/OrderConfig/OrderConfig.gml) | Key to open/close the console |
| `ORDER_TEXT_CURSOR` | [OrderConfig](../Order/scripts/OrderConfig/OrderConfig.gml) | Text cursor string |
| `ORDER_PULSE_INTERVAL` | [OrderConfig](../Order/scripts/OrderConfig/OrderConfig.gml) | Cursor pulse interval in seconds |
| `ORDER_ESCAPE_TAB_SPACES` | [OrderConfig](../Order/scripts/OrderConfig/OrderConfig.gml) | Spaces per tab character |
| `PHY_DEBUG_MINIMAL` | [OrderConfig](../Order/scripts/OrderConfig/OrderConfig.gml) | Physics debug flags for regular mode |
| `PHY_DEBUG_EXTENDED` | [OrderConfig](../Order/scripts/OrderConfig/OrderConfig.gml) | Physics debug flags for extended mode |
| `ORDER_PAUSE_EXCLUDE` | [OrderConfig](../Order/scripts/OrderConfig/OrderConfig.gml) | Objects excluded from the pause command |
| `ORDER_VERSION` | [__OrderInfo](../Order/scripts/__OrderInfo/__OrderInfo.gml) | Current version string |
