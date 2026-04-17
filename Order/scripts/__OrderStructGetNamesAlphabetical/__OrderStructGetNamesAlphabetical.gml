// Feather disable all

function __OrderStructGetNamesAlphabetical(struct)
{
	var _names = variable_struct_get_names(struct);
	array_sort(_names, true);
	return _names;
}