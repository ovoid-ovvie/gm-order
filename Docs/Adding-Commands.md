# Adding Commands

[Home](../README.md)

---

Custom commands are added in [`OrderCustomData`](../Order/scripts/OrderCustomData/OrderCustomData.gml). This is the dedicated place for extending Order with your own commands, whether they are developer tools, player-facing features, or anything in between.

## Basic Structure

Add your commands to the `_custom` struct at the top of the script. The structure is the same as the built-in commands in `__OrderDatabase`.

```gml
var _custom =
{
    _my_command : {
        func : function(arg1, arg2)
        {
            // do something
            __OrderManager.__Push("[OK] Done.");
        },
        args : [
            real,   // converter for arg1
            string  // converter for arg2
        ],
        help : [
            "? my_command <number> <text>",
            "  ? Does something with a number and some text."
        ]
    }
}
```

The entry key must start with an underscore. The command name in the console is the key without the leading underscore, so `_my_command` is typed as `my_command`.

If a custom command has the same key as a built-in command, the custom one is stored with a trailing underscore appended to its name to avoid overwriting the original.

## Arguments

The `args` array contains converter functions applied to each user-provided argument in order. Common converters are:

| Converter | Use for |
|---|---|
| `real` | Numbers and instance IDs |
| `string` | Text |
| `bool` | `true` or `false` |
| `int64` | Large integers |
| `asset_get_index` | Asset names (rooms, objects) |
| `layer_get_id` | Layer names |

## Optional Arguments

Add an `optional_args` array for arguments that may or may not be provided. Order accepts any number of arguments between the required count and the required plus optional count.

```gml
_my_command : {
    func : function(required_arg, optional_arg = undefined)
    {
        optional_arg ??= "default value";
        __OrderManager.__Push("[OK] Done.");
    },
    args : [ string ],
    optional_args : [ string ],
    help : [
        "? my_command <text> <[optional text]>",
        "  ? Does something. Optionally accepts a second string."
    ]
}
```

## Output

If your command always produces the same output on success, you can use the `output` field instead of calling `__Push` inside `func`. Order pushes the output array to the log after `func` runs.

```gml
_my_command : {
    func : my_function,
    args : [],
    help : [
        "? my_command",
        "  ? Runs my function."
    ],
    output : [
        "[OK] my_function ran successfully."
    ]
}
```

## Pushing to the Log

Inside `func`, push output to the console log using `__OrderManager.__Push()`. It accepts strings, arrays of strings, or a mix of both.

```gml
__OrderManager.__Push("[OK] Done.");
__OrderManager.__Push(["Line one", "Line two", "Line three"]);
```

Newline characters in strings are handled automatically -- each line is split into a separate log entry.

## Help Formatting

By convention, the first line of `help` shows the command syntax and the second line gives a brief description, indented with two spaces. Use `<arg>` for required arguments and `<[arg]>` for optional ones.

```gml
help : [
    "? my_command <required> <[optional]>",
    "  ? What the command does."
]
```

## Validation

Order validates the database at game start. Any entry missing `func`, `args`, or `help` is removed. Running inside the IDE this triggers a fatal error. Running outside the IDE it logs a trace message.

## Player-Facing Commands

Custom commands are a natural fit for player-facing features. You can add things like cheat codes, sandbox tools, accessibility options, or any feature that makes sense within a text interface. There is no distinction in the system between a developer command and a player command -- it is entirely up to you which commands you make available and how you communicate them to players.

---

[Next: Configuration](Configuration.md)
