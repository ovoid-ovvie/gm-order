// Feather disable all

function __OrderFindClosestCommand(input)
{
	var _names = variable_struct_get_names(global.__order);
	var _best = "";
	var _bestDist = infinity;
	__OrderTrace("Searching for closest match...")
	
	for (var i = 0; i < array_length(_names); i++)
	{
		var _cmd = string_delete(_names[i], 1, 1);
		var _dist = __OrderStringDist(input, _cmd);
		if ( _dist < _bestDist )
		{
			_bestDist = _dist;
			_best = _cmd;
			__OrderTrace($"...new best: {_cmd}...")
		}
	}
	__OrderTrace($"Search complete.");
	
	if ( _bestDist <= 2 && _bestDist < string_length(input) / 2 )
	{
		__OrderTrace("Best accepted.");
		return _best;
	}
	__OrderTrace("Best rejected.");
	return "";
}