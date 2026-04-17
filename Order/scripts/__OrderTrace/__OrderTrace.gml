// Feather disable all

function __OrderTrace()
{
    var _string = "";
    for (var i = 0; i < argument_count; i++)
    {
        _string += string(argument[i]);
    }

    show_debug_message($"Order API: {_string}");
}