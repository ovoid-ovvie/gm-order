// Feather disable all

function __OrderValidateDatabase()
{
	__OrderTrace("Validating database...")
	var _names = variable_struct_get_names(global.__order);
	var _invalid = [];
	for (var i = 0; i < array_length(_names); i++)
	{
		var _flag = false;
		__OrderTrace($"[{i}/{array_length(_names) - 1}] Searching global.__order.{_names[i]}...");
		var _ref = global.__order[$ _names[i]];
		if ( !variable_struct_exists(_ref, "func") )
		{
			__OrderTrace("...missing func...");
			if ( !_flag )
			{
				_flag = true;
				array_push(_invalid, _names[i]);
			}
		}
		if ( !variable_struct_exists(_ref, "args") )
		{
			__OrderTrace("...missing args...");
			if ( !_flag )
			{
				_flag = true;
				array_push(_invalid, _names[i]);
			}
		}
		if ( !variable_struct_exists(_ref, "help") )
		{
			__OrderTrace("...missing help...")
			if ( !_flag )
			{
				_flag = true;
				array_push(_invalid, _names[i]);
			}
		}
	}
	__OrderTrace($"Database validation completed. Error count: {array_length(_invalid)}");
	for (var i = 0; i < array_length(_invalid); i++)
	{
		if ( GM_build_type == "run" )
		{
			__OrderError($"Database is incorrectly configured.\nInvalid entries: {_invalid}\nCheck debug output for extra diagnostic information.");
		}
		__OrderTrace($"global.__order.{_invalid[i]} is configured incorrectly. Removing...");
		variable_struct_remove(global.__order, _invalid[i]);
		__OrderTrace($"global.__order.{_invalid[i]} removed.");
	}
}