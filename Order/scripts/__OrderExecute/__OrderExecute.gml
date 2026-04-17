// Feather disable all

function __OrderExecute(input)
{
	if ( !instance_exists(__OrderManager) )
	{
		__OrderManager.__Push($"[x] unexpected error, please try again");
		__OrderTrace("unexpected error");
		return;
	}

	try
	{
		__OrderTrace("Beginning execution...");
		__OrderTrace("Converting command to lowercase...");
		var _inputCommand = string_split(input, " ");
		if ( array_length(_inputCommand) > 0 )
		{
			_inputCommand[0] = string_lower(_inputCommand[0]);
		}
		__OrderTrace("Command converted to lowercase.");
		
		__OrderTrace("Checking for empty command...")
		if ( array_length(_inputCommand) == 0 )
		{
			__OrderManager.__Push($"> {_inputCommand}");
			__OrderManager.__Push($"[x] command is empty");
			__OrderTrace("command is empty");
			return;
		}
		__OrderTrace("Command is not empty.");

		if ( _inputCommand[0] == "help" )
		{
			__OrderTrace("Executing help...");
			if ( array_length(_inputCommand) > 1 )
			{
				_inputCommand[1] = string_lower(_inputCommand[1]);
				__OrderManager.__Push($"> {_inputCommand}");
				if ( _inputCommand[1] == "help" )
				{
					__OrderManager.__Push($"? help <[topic]>");
					__OrderManager.__Push($"  ? Returns information about commands and instructions on how to use them. Optionally pass a topic to return information about every command with the topic in its name.");
					return;
				}
				var _names = __OrderStructGetNamesAlphabetical(global.__order);
				var _iterCount = 0;
				for (var i = 0; i < array_length(_names); i++)
				{
					__OrderTrace($"[{i}/{array_length(_names) - 1}] Evaluating relevance...")
					if ( string_count(_inputCommand[1], _names[i]) > 0 )
					{
						__OrderManager.__Push(global.__order[$ _names[i]].help);
						_iterCount++;
					}
				}
				__OrderTrace("Relevance evaluated.");
				if ( _iterCount == 0 )
				{
					__OrderManager.__Push($"[x] unknown help topic");
					__OrderTrace("unknown help topic");
				}
			}
			else
			{
				__OrderTrace("Showing all...");
				__OrderManager.__Push($"> {_inputCommand}");
				var _names = __OrderStructGetNamesAlphabetical(global.__order);
				for (var i = 0; i < array_length(_names); i++)
				{
					__OrderManager.__Push(global.__order[$ _names[i]].help);
				}
			}
			__OrderManager.__Push("---");
			__OrderTrace("Execution complete.");
			return;
		}

		if ( !variable_struct_exists(global.__order, "_" + _inputCommand[0]) )
		{
			__OrderManager.__Push($"> {_inputCommand}");
			__OrderManager.__Push($"[x] unknown command: {_inputCommand[0]}");
			
			__OrderTrace("Unknown command.");
			var _closest = __OrderFindClosestCommand(_inputCommand[0]);
			__OrderTrace("Search complete.");
			__OrderTrace("Validating result...");
			if ( _closest != "" )
			{
				__OrderManager.__Push($"? Did you mean '{_closest}'?");
			}
			__OrderTrace("Validation complete.");
			
			return;
		}
		else
		{
			var _command = global.__order[$ "_" + _inputCommand[0]];

			var _required = array_length(_command.args);
			var _optional = variable_struct_exists(_command, "optional_args") ? array_length(_command.optional_args) : 0;
			var _provided  = array_length(_inputCommand) - 1;
			
			__OrderTrace("Checking argument count...")
			if ( _provided < _required || _provided > _required + _optional )
			{
				var _str1 = ( _provided == 1 ) ? "argument was" : "arguments were";
				var _str2 = ( _required == 1 ) ? "was" : "were";
				__OrderManager.__Push($"> {_inputCommand}");
				if ( _optional > 0 )
				{
					__OrderManager.__Push($"[x] {_provided} {_str1} provided where {_required}-{_required + _optional} were expected");
				}
				else
				{
					__OrderManager.__Push($"[x] {_provided} {_str1} provided where {_required} {_str2} expected");
				}
				__OrderTrace("incorrect amount of arguments");
				return;
			}
			__OrderTrace("Argument count validated.")

			var _args = [];

			__OrderTrace("Forming args...")
			for (var i = 0; i < _required; i++)
			{
				array_push(_args, _command.args[i](_inputCommand[i + 1]));
			}
			__OrderTrace("Args: ", _args);

			__OrderTrace("Forming optional args...")
			if ( _optional > 0 )
			{
				for (var i = 0; i < _provided - _required; i++)
				{
					array_push(_args, _command.optional_args[i](_inputCommand[_required + i + 1]));
				}
			}
			__OrderTrace("Optional args: ", _optional);
			
			__OrderTrace("Executing command...")
			method_call(_command.func, _args);
	
			if ( variable_struct_exists(_command, "output") )
			{
				__OrderManager.__Push(_command.output);
			}
			__OrderTrace("Execution complete.");
			
			__OrderTrace("Updating history...")
			var _str = variable_clone(_inputCommand[0]);
			for (var i = 1; i < array_length(_inputCommand); i++)
			{
				_str += " " + variable_clone(_inputCommand[i]);
			}
			array_push(__OrderManager.history, _str);
			__OrderTrace("History updated.")
			
			return;
		}
	}
	catch (_exception)
	{
		__OrderManager.__Push($"[x] unknown error or invalid argument");
		__OrderManager.__Push($"[x] message: {_exception.message}");
		__OrderManager.__Push($"[x] longMessage: {_exception.longMessage}");
		__OrderManager.__Push($"[x] script: {_exception.script}");
		__OrderManager.__Push($"[x] stacktrace: {_exception.stacktrace}");
		__OrderTrace(_exception);
	}
}