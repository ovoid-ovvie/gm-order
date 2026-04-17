// Feather disable all

function __OrderMergeData(to, from)
{
	var _store = variable_clone(to);
	var _names = variable_struct_get_names(from);
	for (var i = 0; i < array_length(_names); i++)
	{
		if ( !variable_struct_exists(_store, _names[i]) )
		{
			_store[$ _names[i]] = variable_clone(from[$ _names[i]]);
		}
		else
		{
			_store[$ _names[i] + "_"] = variable_clone(from[$ _names[i]]);
		}
	}
	return _store;
}