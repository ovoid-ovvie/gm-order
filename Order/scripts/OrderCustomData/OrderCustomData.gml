// Your custom commands. At the bottom of this script
// is a guide on their required structure
var _custom =
{
	
}

// Add custom data to global database
global.__order = __OrderMergeData(global.__order, _custom);
__OrderValidateDatabase();

/*
var _custom =
{
	* The entry key must start with an underscore.
	* The command name in the console is the key
	* without the leading unscore, so `_my_command`
	* is typed as `my_command`.
	_my_command : {
		
	    * If you aren't writing your own function,
	    * don't include parenthesis.
	    func : my_function,
		
		* If you are writing your own function,
		* remember to include arguments.
		func : function(arg1, arg2, optional1 = "fallback")
		{
			// do something
			* Inside func, push output to the console
			* log using `__OrderManager.__Push()`. It
			* accepts strings, arrays of strings, or a
			* mix of both.
			__OrderManager.__Push("[OK] Done.");
			* Newline characters in strings are handled
			* automatically, as each line is split into
			* a separate log entry.
		},
		
		* This array contains converter functions
		* applied to each user-provided argument
		* in order. Common converters are `real`,
		* `string`, `bool`, `asset_get_index`, etc.
		args : [
			real,
			string,
		],
		
		* Add an `optional_args` array for arguments
		* that may or may not be provided. Order
		* accepts any number of arguments between the
		* required count and the required plus optional
		* count.
		optional_args : [
			string,
		],
		
		* By convention, the first line of `help`
		* shows the command syntax and the second
		* line gives a brief description, indented
		* with two spaces. Use <arg> for required
		* arguments and <[arg]> for optional ones.
		help : [
			"? command_name <number> <text> <[optional text]>",
			"  ? What the command does."
		],
		
		* If your command always produces the same
		* output on success, you can use the `output`
		* field instead of calling `__Push` inside
		* `func`. Order pushes the output array to
		* the log after `func` runs.
		output : [
			"[OK] my_command ran successfully."
		]
	}

	* Remember to include a comma after each variable
	* in an entry and after each entry, excluding the
	* last.
}
*/