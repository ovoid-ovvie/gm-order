# How It Works

[Home](../README.md)

---

## The Manager Object

Order is built around a single persistent object, `__OrderManager`. It handles drawing the console, processing input, and maintaining the log and history. It is created automatically at game start and should never be manually destroyed or deactivated.

If `__OrderManager` is accidentally deactivated, Order detects this every frame and attempts to reactivate it. Running inside the GameMaker IDE, this triggers a fatal error to make the problem immediately visible. Running outside the IDE as a built executable, this logs a trace message and reactivates silently.

## The Command Database

All commands are stored in a global struct called `global.__order`. Each entry represents one command and has the following fields:

```gml
_my_command : {
    func         : function(...) { ... }, // the function to run
    args         : [ real, string ],      // type converters for required arguments
    optional_args: [ string ],            // type converters for optional arguments
    help         : [                      // lines shown by the help command
        "? my_command <arg>",
        "  ? Description of what it does."
    ],
    output       : [                      // optional fixed output pushed after func runs
        "[OK] Command ran successfully."
    ]
}
```

The built-in commands are defined in `__OrderDatabase`. Custom commands are defined in `OrderCustomData` and merged into the database using `__OrderMergeData`. If a custom command has the same key as a built-in, the custom one is stored with a trailing underscore appended to its name to avoid collision.

## Command Execution

When the player presses Enter, the input string is passed to `__OrderExecute`. It splits the input by spaces, looks up the first word in `global.__order`, validates the argument count, converts each argument using the type converters defined in `args` and `optional_args`, and calls `func` with the resulting values.

If the command is not found, Order uses `__OrderFindClosestCommand` to search for a near match and suggests it with a "Did you mean?" message if one is found within a reasonable edit distance.

If anything else goes wrong -- wrong number of arguments, runtime error -- the issue is caught and a detailed error message is pushed to the log.

## The Log

The console log is an array of strings stored on `__OrderManager`. Each entry is one line. When new entries are added, the viewpoint scrolls to keep the latest entry visible. Long strings are wrapped automatically to fit the display width at draw time.

## Autocomplete

Pressing Tab while typing builds a list of commands whose names start with the current input. Pressing Tab again cycles through them. Pressing Shift+Tab applies the current selection, or the first option if the suggestions have not been made visible yet. The current suggestion is highlighted above the input field. Typing anything clears the suggestion list. Pressing Escape dismisses suggestions without applying one.

## Validation

When the command database is set up at game start, `__OrderValidateDatabase` checks every entry for the required fields `func`, `args`, and `help`. Any entry missing one of these is removed. Running inside the IDE this triggers a fatal error. Running outside the IDE it logs a trace message.

---

[Next: Using the Console](Using-the-Console.md)
