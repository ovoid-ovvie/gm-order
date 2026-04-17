// Feather disable all

function __OrderError()
{
	var _string = "";
    for (var i = 0; i < argument_count; i++)
    {
        _string += string(argument[i]);
    }

    if ( os_browser == browser_not_a_browser )
    {
        show_error($"\nOrder API v{ORDER_VERSION}:\n{_string}\n ", false);
    }
    else
    {
        show_error($"\nOrder API v{ORDER_VERSION}:\n{_string}\n{debug_get_callstack()}", false);
    }
}