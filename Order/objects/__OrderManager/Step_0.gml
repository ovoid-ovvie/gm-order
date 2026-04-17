if ( consoleActive )
{
    if ( keyboard_check_pressed(vk_enter) )
    {
        __OrderExecute(keyboard_string);
        keyboard_string = "";
    }
    else if ( keyboard_check(vk_control) && keyboard_check(vk_shift) && keyboard_check_pressed(ord("V")) )
    {
        if ( array_length(log) > 0 )
        {
            var _index = viewpoint ?? 0;
            clipboard_set_text(clipboard_get_text() + "\n" + log[_index]);
            __Push($"[OK] Added entry at index {_index} to the end of clipboard.");
        }
    }
    else if ( keyboard_check(vk_control) && keyboard_check_pressed(ord("V")) )
    {
        if ( clipboard_has_text() )
        {
            keyboard_string += clipboard_get_text();
        }
    }
    else if ( keyboard_check(vk_control) && keyboard_check(vk_shift) && keyboard_check_pressed(ord("C")) )
    {
        if ( array_length(log) > 0 )
        {
            var _index = viewpoint ?? 0;
            clipboard_set_text(log[_index]);
			__Push($"[OK] Copied entry at index {_index} to clipboard.");
        }
    }
    else if ( keyboard_check(vk_control) && keyboard_check_pressed(ord("C")) )
    {
		__Push($"> {keyboard_string}^C");
        keyboard_string = "";
    }
    else if
    (
        (keyboard_check(vk_control) && keyboard_check(ord("Q")) && viewpoint != undefined) ||
        (keyboard_check(vk_alt) && keyboard_check_pressed(ord("Q")) && viewpoint != undefined) ||
        (keyboard_check(vk_up) && viewpoint != undefined) ||
        (keyboard_check_pressed(vk_left) && viewpoint != undefined) ||
        (mouse_wheel_up() && viewpoint != undefined)
    )
    {
        viewpoint--;
        if ( viewpoint < 0 )
        {
            viewpoint = 0;
        }
    }
    else if
    (
        (keyboard_check(vk_control) && keyboard_check(ord("E")) && viewpoint != undefined) ||
        (keyboard_check(vk_alt) && keyboard_check_pressed(ord("E")) && viewpoint != undefined) ||
        (keyboard_check(vk_down) && viewpoint != undefined) ||
        (keyboard_check_pressed(vk_right) && viewpoint != undefined) ||
        (mouse_wheel_down() && viewpoint != undefined)
    )
    {
        viewpoint++;
        if ( viewpoint > array_length(log) - 1 )
        {
            viewpoint = array_length(log) - 1;
        }
    } 
	
	if ( keyboard_check_pressed(vk_tab) )
	{
		var _justBuilt = false;
		if ( array_length(autocompleteSuggestions) == 0 )
		{
			_justBuilt = true;
			__OrderTrace("Building autocomplete suggestion list...");
			var _names = __OrderStructGetNamesAlphabetical(global.__order);
			autocompleteSuggestions = [];
			for (var i = 0; i < array_length(_names); i++)
			{
				var _cmd = string_delete(_names[i], 1, 1);
				if ( string_pos(keyboard_string, _cmd) == 1 )
				{
					array_push(autocompleteSuggestions, _cmd);
				}
			}
			autocompleteBase = keyboard_string;
			autocompleteIndex = 0;
			__OrderTrace($"Suggestion list built: {autocompleteSuggestions}");
		}
		
		if ( array_length(autocompleteSuggestions) > 0 )
		{
			if ( keyboard_check(vk_shift) )
			{
				var _index = autocompleteIndex;
				if ( _justBuilt )
				{
					_index = array_length(autocompleteSuggestions) - 1;
				}
				keyboard_string = autocompleteSuggestions[_index];
				__OrderTrace("Autocomplete applied.");
			}
			else
			{
				autocompleteIndex--;
				if ( autocompleteIndex < 0 )
				{
					autocompleteIndex = array_length(autocompleteSuggestions) - 1;
				}
				__OrderTrace("Cycled autocomplete suggestions.");
			}
		}
	}
	
	if ( keyboard_check_pressed(vk_escape) )
	{
		if ( array_length(autocompleteSuggestions) > 0 )
		{
			autocompleteSuggestions = [];
			autocompleteIndex = -1;
			__OrderTrace("Autocomplete suggestions reset by user.");
		}
		else
		{
			viewpoint = __IndexLast();
		}
	}
}