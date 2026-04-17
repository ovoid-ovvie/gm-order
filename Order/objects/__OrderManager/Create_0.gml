__OrderTrace("__OrderManager created.");

log = [];
history = [];
viewpoint = undefined;
summonConsume = false;
consoleActive = false;
showTrail = true;
prevKeyboardStringLength = 0;
drawDebugActive = false;
drawDebugExtended = false;

autocompleteIndex = -1;
autocompleteSuggestions = [];
autocompleteBase = "";

__Push = function()
{
	static __ProcessEntry = function(str)
	{
		__OrderTrace("Pushing to log...")
		str = __OrderStringSanitise(str);
		var _lines = string_split(str, "\n");
		for (var i = 0; i < array_length(_lines); i++)
		{
			array_push(log, _lines[i]);
		}
		__OrderTrace("Pushed.");
	}
	
	var _prevLen = array_length(log);
	for (var i = 0; i < argument_count; i++)
	{
		if ( is_string(argument[i]) )
		{
			__ProcessEntry(argument[i]);
		}
		else if ( is_array(argument[i]) )
		{
			for (var j = 0; j < array_length(argument[i]); j++)
			{
				if ( is_string(argument[i][j]) )
				{
					__ProcessEntry(argument[i][j]);
				}
				else if ( is_array(argument[i][j]) )
				{
					__Push(argument[i][j]);
				}
			}
		}
	}
	var _len = array_length(log);
	if ( _prevLen != _len && viewpoint != undefined )
	{
		viewpoint += _len - _prevLen;
	}
}

__Clear = function()
{
	log = [];
	history = [];
	viewpoint = undefined;
}

__IndexLast = function()
{
	return ( array_length(log) - 1 );
}