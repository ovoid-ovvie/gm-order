# Using the Console

[Home](../README.md)

---

## Opening and Closing

Press the summon key (default `F12`) to open or close the console. The input field is cleared each time the console is opened.

## Typing Commands

Type a command name followed by any required arguments, separated by spaces, then press `Enter` to execute.

```
goto my_room
spawn obj_player
timescale 0.5
```

Command names are case-insensitive. Arguments are passed as strings and converted to the appropriate type internally.

## Getting Help

Type `help` to list every available command with a brief description and usage syntax.

```
help
```

Type `help` followed by a topic to filter commands by name.

```
help instance
help audio
help global
```

## Autocomplete

Press `Tab` to build a list of commands that start with what you have typed so far. Suggestions appear above the input field. Keep pressing `Tab` to cycle through them. Press `Shift + Tab` to apply the currently highlighted suggestion, or the first option if the suggestions have not been made visible yet. Press `Escape` to dismiss the suggestions without applying one. Typing anything clears the suggestion list.

## Did You Mean?

If you type an unknown command, Order will suggest the closest matching command if one is found within a reasonable edit distance.

```
> instanc_count
[x] unknown command: instanc_count
? Did you mean 'instance_count'?
```

## Scrolling the Log

| Input | Action |
|---|---|
| `Up arrow` (hold) | Scroll up |
| `Down arrow` (hold) | Scroll down |
| `Left arrow` | Scroll up one step |
| `Right arrow` | Scroll down one step |
| `Mouse wheel up` | Scroll up one step |
| `Mouse wheel down` | Scroll down one step |
| `Ctrl + Q` (hold) | Scroll up |
| `Ctrl + E` (hold) | Scroll down |
| `Alt + Q` | Scroll up one step |
| `Alt + E` | Scroll down one step |
| `Escape` | Jump to the latest log entry |

## Clipboard

| Input | Action |
|---|---|
| `Ctrl + V` | Paste clipboard text into the input field |
| `Ctrl + C` | Cancel the current input and log it with `^C` |
| `Ctrl + Shift + C` | Copy the currently viewed log entry to the clipboard |
| `Ctrl + Shift + V` | Append the currently viewed log entry to the end of the clipboard |

## The Text Cursor

The text cursor pulses on and off at the interval set by `ORDER_PULSE_INTERVAL`. It resets to visible whenever the input changes, so it stays visible while you are actively typing.

## Command Prefixes in the Log

Order uses consistent prefixes in its log output to make it easy to scan:

| Prefix | Meaning |
|---|---|
| `>` | Input echo -- shows what was typed |
| `?` | Requested information -- a query result, status, or help |
| `[OK]` | Success |
| `[x]` | Error or failure |
| `#` | Information -- Notes something |

---

[Next: Built-in Commands](Built-in-Commands.md)
