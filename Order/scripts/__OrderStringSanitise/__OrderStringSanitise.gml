// Feather disable all

function __OrderStringSanitise(str)
{
    // handle \r\n and \r as newlines
    str = string_replace_all(str, "\r\n", "\n");
    str = string_replace_all(str, "\r", "\n");
    
    // replace tabs with fixed spaces
    str = string_replace_all(str, "\t", string_repeat(" ", ORDER_ESCAPE_TAB_SPACES) );

    // strip everything else
    str = string_replace_all(str, "\v", "");
    str = string_replace_all(str, "\f", "");
    str = string_replace_all(str, "\b", "");
    str = string_replace_all(str, "\a", "");

    return str;
}