global.__order =
{
	_clear : {
		func : function() {
			__OrderManager.__Clear();
		},
		args : [],
		help : [
			$"? clear",
			$"  ? Wipes the console text buffer."
		]
	},

	_game_restart : {
		func : game_restart,
		args : [],
		help : [
			$"? game_restart",
			$"  ? Restarts the game and returns it to its opening state."
		],
		output : [
			$"[OK] Game successfully restarted."
		]
	},

	_quit : {
		func : game_end,
		args : [],
		help : [
			$"? quit",
			$"  ? Closes the game."
		],
		output : [
			$"[OK] Game successfully closed."
		]
	},
	
	_overlay : {
		func : function(toggle) {
			show_debug_overlay(toggle);
			var _str = ( toggle ) ? "visible" : "hidden";
			__OrderManager.__Push($"[OK] Debug overlay set to {_str}.");
		},
		args : [
			bool
		],
		help : [
			$"? overlay <true/false>",
			$"  ? Toggles FPS/Memory graphs, also known as the debug overlay."
		]
	},

	_log : {
		func : function(toggle) {
			show_debug_log(toggle);
			var _str = ( toggle ) ? "visible" : "hidden";
			__OrderManager.__Push($"[OK] GML output window set to {_str}.");
		},
		args : [
			bool
		],
		help : [
			$"? log <true/false>",
			$"  ? Toggles the GML output window."
		]
	},

	_fps : {
		func : function() {
			var _array = [
				$"FPS: {fps}",
				$"FPS Real: {fps_real}"
			]
			__OrderManager.__Push(_array);
		},
		args : [],
		help : [
			$"? fps",
			$"  ? Returns current 'fps' and 'fps_real' values to the console."
		]
	},

	_goto : {
		func : function(roomId) {
			if ( roomId == room )
			{
				__OrderManager.__Push($"[x] target room cannot be current room");
				return;
			}
			if ( room_exists(roomId))
			{
				room_goto(roomId);
				__OrderManager.__Push($"[OK] You have arrived in {room_get_name(roomId)}.");
			}
			else
			{
				__OrderManager.__Push($"[x] invalid room");
			}
		},
		args : [
			asset_get_index
		],
		help : [
			$"? goto <name>",
			$"  ? Teleport to a given room."
		]
	},

	_spawn : {
		func : function(obj) {
			if ( obj == -1 )
			{
				__OrderManager.__Push($"[x] invalid object");
				return;
			}
			var _inst = instance_create_depth(mouse_x, mouse_y, 0, obj);
			__OrderManager.__Push($"[OK] Successfully spawned instance {real(_inst)}.");
		},
		args : [
			asset_get_index
		],
		help : [
			$"? spawn <object name>",
			$"  ? Spawn an instance of a specified object at your mouse."
		]
	},

	_instance_count : {
		func : function(obj) {
			if ( obj == -1 )
			{
				__OrderManager.__Push($"[x] invalid object");
				return;
			}
			__OrderManager.__Push($"? There are {instance_number(obj)} instances of object {object_get_name(obj)}.");
		},
		args : [
			asset_get_index
		],
		help : [
			$"? instance_count <object name>",
			$"  ? Returns the instance count of a specified object."
		]
	},

	_destroy : {
		func : function(inst) {
			if ( inst == noone || !instance_exists(inst) )
			{
				__OrderManager.__Push($"[x] invalid id");
				return;
			}
			instance_destroy(inst);
			__OrderManager.__Push($"[OK] Successfully destroyed instance {inst}.");
		},
		args : [
			real
		],
		help : [
			$"? destroy <instance id>",
			$"  ? Destroys the specified instance."
		]
	},

	_destroy_all: {
		func : function(obj) {
			if ( !object_exists(obj) )
			{
				__OrderManager.__Push($"[x] invalid object");
				return;
			}
			var _num = instance_number(obj);
			instance_destroy(obj);
			if ( _num > 0 )
			{
				var _str = ( _num == 1 ) ? "instance" : "instances";
				__OrderManager.__Push($"[OK] Destroyed {_num} {_str} of object {object_get_name(obj)}.");
			}
			else
			{
				__OrderManager.__Push($"[x] No instances of object {object_get_name(obj)} found.");
			}
		},
		args : [
			asset_get_index
		],
		help : [
			$"? destroy_all <object name>",
			$"  ? Destroys all instances of a target object."
		]
	},

	_layer_set_visible : {
		func : function(layer, toggle) {
			if ( !layer_exists(layer) )
			{
				__OrderManager.__Push($"[x] layer could not be found");
				return;
			}
			layer_set_visible(layer, toggle);
			var _str = toggle ? "set to visible." : "set to hidden.";
			__OrderManager.__Push($"[OK] Layer {layer_get_name(layer)} {_str}");
		},
		args : [
			layer_get_id,
			bool
		],
		help : [
			$"? layer_set_visible <layer name> <true/false>",
			$"  ? Sets a specified layer to either visible or hidden."
		]
	},

	_global_get : {
		func : function(variable) {
			if ( !variable_global_exists(variable) )
			{
				__OrderManager.__Push($"[x] variable could not be found");
				return;
			}
			var _var = variable_global_get(variable);
			__OrderManager.__Push($"? global.{variable}: [{typeof(_var)}] {_var}");
		},
		args : [
			string
		],
		help : [
			$"? global_get <variable>",
			$"  ? Returns the current value of a specified global variable."
		]
	},

	_global_set : {
		func : function(variable, type, value) {
			if ( !variable_global_exists(variable) )
			{
				__OrderManager.__Push($"[x] variable could not be found");
				return;
			}
			var _prev = variable_global_get(variable);
			var _func;
			switch type
			{
				case "string": _func = string; break;
				case "bool": _func = bool; break;
				case "real": _func = real; break;
				case "int64": _func = int64; break;
				case "default":
					__OrderManager.__Push($"[x] invalid type");
					return;
					break;
			}
			variable_global_set(variable, _func(value));
			__OrderManager.__Push($"# global.{variable} was previously set to [{typeof(_prev)}] {_prev}.");
			__OrderManager.__Push($"[OK] global.{variable} set to {value} of type {type}.");
		},
		args : [
			string,
			string,
			string
		],
		help : [
			$"? global_set <variable> <type> <value>",
			$"  ? Sets a global variable to a new value. Type can be 'string', 'bool', 'real', or `int64`."
		]
	},

	_instance_get : {
		func : function(inst, variable) {
			if ( inst == noone || !instance_exists(inst) )
			{
				__OrderManager.__Push($"[x] invalid id");
			}
			else
			{
				if ( variable_instance_exists(inst, variable) )
				{
					var _var = variable_instance_get(inst, variable);
					__OrderManager.__Push($"? object: {object_get_name(inst.object_index)}  id: {real(inst.id)}");
					__OrderManager.__Push($"  ? {variable}: [{typeof(_var)}] {_var}");
				}
				else
				{
					__OrderManager.__Push($"? object: {object_get_name(inst.object_index)}  id: {real(inst.id)}");
					__OrderManager.__Push($"[x] variable {variable} not found");
				}
			}
		},
		args : [
			real,
			string
		],
		help : [
			$"? instance_get <instance id> <variable>",
			$"  ? Returns the current value of a specified instance variable."
		]
	},

	_instance_set : {
		func : function(inst, variable, type, value)
		{
			if ( inst == noone || !instance_exists(inst) )
			{
				__OrderManager.__Push($"[x] invalid id");
			}
			else
			{
				if ( variable_instance_exists(inst, variable) )
				{
					var _prev = variable_instance_get(inst, variable);
					var _func;
					switch type 
					{
						case "string": _func = string; break;
						case "bool": _func = bool; break;
						case "real": _func = real; break;
						case "int64": _func = int64; break;
						case "default":
							__OrderManager.__Push($"[x] invalid type");
							return;
							break;
					}
					variable_instance_set(inst, variable, _func(value));
					__OrderManager.__Push($"? object: {object_get_name(inst.object_index)}  id: {real(inst.id)}");
					__OrderManager.__Push($"# {variable} was previously set to [{typeof(_prev)}] {_prev}.");
					__OrderManager.__Push($"[OK] {variable} set to {value} of type {type}.");
				}
				else
				{
					__OrderManager.__Push($"? object: {object_get_name(inst.object_index)}  id: {real(inst.id)}");
					__OrderManager.__Push($"[x] variable {variable} not found");
				}
			}
		},
		args : [
			real,
			string,
			string,
			string
		],
		help : [
			$"? instance_set <instance id> <variable> <type> <value>",
			$"  ? Sets an instance variable to a new value. Type can be 'string', 'bool', 'real', or `int64`."
		]
	},

	_inspect : {
		/// @param {Id.Instance} inst
		func : function(inst = undefined) {
			inst ??= instance_position(mouse_x, mouse_y, all);
			if ( inst == noone || !instance_exists(inst) )
			{
				__OrderManager.__Push($"[x] instance not found at mouse position or invalid id");
			}
			else
			{
				__OrderManager.__Push($"? object: {object_get_name(inst.object_index)}  id: {real(inst.id)}");
				__OrderManager.__Push($"? position: ({inst.x}, {inst.y})");

				var _names = variable_instance_get_names(inst);
				__OrderManager.__Push($"? {array_length(_names)} variables found");

				for (var i = 0; i < array_length(_names); i++)
				{
					var _var = variable_instance_get(inst, _names[i]);
					__OrderManager.__Push($"  ? {_names[i]}: [{typeof(_var)}] {_var}");
				}
			}
		},
		args : [],
		optional_args : [
			real
		],
		help : [
			$"? inspect <[instance id]>",
			$"  ? Returns the variable names and values of the instance at the mouse's position. Optionally pass an instance ID to inspect directly."
		]
	},

	_instances : {
		func : function() {
			var _obj = {};
			for (var i = 0; i < instance_count; i++)
			{
				var _inst = instance_find(all, i);
				var _name = object_get_name(_inst.object_index)
				if ( !variable_struct_exists(_obj, _name) )
				{
					_obj[$ _name] = 1;
				}
				else
				{
					_obj[$ _name]++;
				}
			}
			var _names = variable_struct_get_names(_obj);
			for (var i = 0; i < array_length(_names); i++)
			{
				var _str = ( _obj[$ _names[i]] == 1 ) ? "instance" : "instances";
				__OrderManager.__Push($"? Object {_names[i]}: {_obj[$ _names[i]]} {_str}");
			}
		},
		args : [],
		help : [
			$"? instances",
			$"  ? Returns a list of all active objects in the room and their instance counts."
		]
	},
	
	_physics_view : {
		func : function(toggle, extended = undefined) {
			if ( !room_get_info(room).physicsWorld )
			{
				__OrderManager.__Push("[x] room does not contain physics world");
				return;
			}
			__OrderManager.drawDebugActive = toggle;
			if ( !is_undefined(extended) )
			{
				__OrderManager.drawDebugExtended = extended;
			}
			var _str1 = ( toggle ) ? "visible" : "hidden";
			var _str2 = ( __OrderManager.drawDebugExtended ) ? "extended" : "regular";
			__OrderManager.__Push($"[OK] Physics view set to {_str1} as {_str2} view.");
		},
		args : [
			bool
		],
		optional_args : [
			bool
		],
		help : [
			$"? physics_view <true/false> <[extended view true/false]>",
			$"  ? Toggles the physics debug overlay on/off. Optionally pass an argument to toggle extended view."
		]
	},

	_audio_debug : {
		func : function(toggle) {
			audio_debug(toggle);
			var _str = ( toggle ) ? "visible" : "hidden";
			__OrderManager.__Push($"[OK] Audio debug overlay set to {_str}.");
		},
		args : [
			bool
		],
		help : [
			$"? audio_debug <true/false>",
			$"  ? Toggles the audio debug overlay on/off."
		]
	},

	_flush_textures : {
		func : draw_texture_flush,
		args : [],
		help : [
			$"? flush_textures",
			$"  ? Removes all textures from video memory, reloading on first use."
		],
		output : [
			$"[OK] Textures flushed."
		]
	},

	_echo : {
		func : function(str) {
			__OrderManager.__Push(str);
		},
		args : [
			string
		],
		help : [
			$"? echo <text>",
			$"  ? Prints text back to the console."
		]
	},
	
	_instance_freeze : {
		func : function(inst, toggle) {
			if ( inst == noone )
			{
				__OrderManager.__Push($"[x] invalid id");
				return;
			}
			var _func = ( toggle ) ? instance_deactivate_object : instance_activate_object;
			_func(inst);
			var _str = ( toggle ) ? "frozen" : "unfrozen";
			__OrderManager.__Push($"[OK] Instance {inst} {_str}.");
		},
		args : [
			real,
			bool
		],
		help : [
			$"? instance_freeze <instance id> <true/false>",
			$"  ? Freezes/unfreezes an instance."
		]
	},

	_room_info : {
		func : function() {
			var _array = [
				$"? current room: {room_get_name(room)}",
				$"  ? width: {room_width}  height: {room_height}",
				$"  ? instance count: {instance_count}",
				$"  ? persistent: {room_persistent ? "yes" : "no"}"
			];
			__OrderManager.__Push(_array);
		},
		args : [],
		help : [
			$"? room_info",
			$"  ? Returns current room name, dimensions, instance count, and persistent status."
		]
	},

	_room_restart : {
		func : room_restart,
		args : [],
		help : [
			$"? room_restart",
			$"  ? Restarts the current room without a full game restart."
		],
		output : [
			$"[OK] Room successfully restarted."
		]
	},

	_instance_move : {
		func : function(inst, _x, _y)
		{
			if ( inst == noone || !instance_exists(inst) )
			{
				__OrderManager.__Push($"[x] invalid id");
				return;
			}
			inst.x = _x;
			inst.y = _y;
			__OrderManager.__Push($"[OK] Instance {inst} position is now ({inst.x}, {inst.y}).");
		},
		args : [
			real,
			real,
			real
		],
		help : [
			$"? instance_move <instance id> <x> <y>",
			$"  ? Teleports an instance to the given x/y coordinates."
		]
	},

	_timescale : {
		func : function(mult) {
			game_set_speed(mult * 60, gamespeed_fps);
			__OrderManager.__Push($"[OK] Game speed set to {mult}x.");
		},
		args : [
			real
		],
		help : [
			$"? timescale <multiplier>",
			$"  ? Applies a given multiplier to the game speed."
		]
	},

	_pause : {
		func : function(toggle) {
			if ( toggle )
			{
				instance_deactivate_all(true);
				instance_activate_object(__OrderManager);
				var _count = 0;
				for (var i = 0; i < array_length(ORDER_PAUSE_EXCLUDE); i++)
				{
					if ( object_exists(ORDER_PAUSE_EXCLUDE[i]) )
					{
						instance_activate_object(ORDER_PAUSE_EXCLUDE[i]);
						_count++;
					}
				}
				__OrderManager.__Push($"[OK] Successfully paused. {_count} objects excluded.");
			}
			else
			{
				instance_activate_all();
				__OrderManager.__Push($"[OK] Successfully unpaused.");
			}
		},
		args : [
			bool
		],
		help : [
			$"? pause <true/false>",
			$"  ? Pauses/unpauses the game by freezing/unfreezing all instances."
		]
	},

	_screenshot : {
		func : function() {
			var _dir = "order_api/screenshots/image*.png";
			var _count = 0;
			var _file = file_find_first(_dir, 0);
			while ( _file != "" )
			{
				_count++;
				_file = file_find_next();
			}
			file_find_close();
			var _filename = string(_count);
			while ( string_length(_filename) < 4 )
			{
				_filename = " " + _filename;
			}
			_filename = string_replace_all(_filename, " ", "0");
			_filename = "order_api/screenshots/image" + _filename + ".png";
			surface_save(application_surface, _filename);
			__OrderManager.__Push($"[OK] Screenshot {_filename} successfully saved to local app data.");
		},
		args : [],
		help : [
			$"? screenshot",
			$"  ? Saves an image of the application surface to local app data."
		]
	},

	_audio_pause_all : {
		func : function(toggle) {
			if ( toggle )
			{
				audio_pause_all();
			}
			else
			{
				audio_resume_all();
			}
			var _str = ( toggle ) ? "paused" : "unpaused";
			__OrderManager.__Push($"[OK] Audio successfully {_str}.");
		},
		args : [
			bool
		],
		help : [
			$"? audio_pause_all <true/false>",
			$"  ? Pauses/unpauses all audio."
		]
	},

	_audio_stop_all : {
		func : audio_stop_all,
		args : [],
		help : [
			$"? audio_stop_all",
			$"  ? Stops all audio."
		],
		output : [
			$"[OK] All audio stopped successfully."
		]
	},

	_global_list : {
		func : function() {
			var _names = variable_instance_get_names(global);
			for (var i = 0; i < array_length(_names); i++)
			{
				var _var = variable_global_get(_names[i]);
				__OrderManager.__Push($"? global.{_names[i]}: [{typeof(_var)}] {_var}");
			}
		},
		args : [],
		help : [
			$"? global_list",
			$"  ? Lists all global variables and their current values."
		]
	},

	_export : {
		func : function() {
			var _dir = "order_api/console*.txt";
			var _count = 0;
			var _file = file_find_first(_dir, 0);
			while ( _file != "" )
			{
				_count++;
				_file = file_find_next();
			}
			file_find_close();
			var _filename = string(_count);
			while ( string_length(_filename) < 4 )
			{
				_filename = " " + _filename;
			}
			_filename = string_replace_all(_filename, " ", "0");
			_filename = "order_api/console" + _filename + ".txt";
			var _file = file_text_open_write(_filename);
			for (var i = 0; i < array_length(__OrderManager.log); i++)
			{
				file_text_write_string(_file, __OrderManager.log[i]);
				file_text_writeln(_file);
			}
			file_text_close(_file);
			__OrderManager.__Push($"[OK] Log {_filename} successfully saved to local app data.");
		},
		args : [],
		help : [
			$"? export",
			$"  ? Exports the current console log to a text file in local app data."
		]
	},

	_history : {
		func : function() {
			if ( array_length(__OrderManager.history) == 0 )
			{
				__OrderManager.__Push($"[x] history is empty");
				return;
			}
			__OrderManager.__Push($"? Command history:");
			for (var i = 0; i < array_length(__OrderManager.history); i++)
			{
				__OrderManager.__Push($"  > {__OrderManager.history[i]}");
			}
		},
		args : [],
		help : [
			$"? history",
			$"  ? Prints previously entered commands."
		]
	},

	_delta : {
		func : function() {
			__OrderManager.__Push($"? delta_time: {delta_time}");
		},
		args : [],
		help : [
			$"? delta",
			$"  ? Returns the current value of 'delta_time' to the console."
		]
	},

	_instance_near : {
		func : function(dist) {
			var _count = 0;
			for (var i = 0; i < instance_count; i++)
			{
				var _inst = instance_find(all, i);
				if ( point_distance(_inst.x, _inst.y, mouse_x, mouse_y) <= dist )
				{
					__OrderManager.__Push($"? object: {object_get_name(_inst.object_index)}  id: {real(_inst.id)}");
					__OrderManager.__Push($"  ? position: ({_inst.x}, {_inst.y})");
					_count++;
				}
			}
			if ( _count == 0 )
			{
				__OrderManager.__Push($"[x] 0 instances found");
			}
			else
			{
				var _str = ( _count == 1 ) ? "instance" : "instances";
				__OrderManager.__Push($"[OK] {_count} {_str} found.");
			}
		},
		args : [
			real
		],
		help : [
			$"? instance_near <distance>",
			$"  ? Lists all instances within a given distance to the mouse."
		]
	},

	_layer_list : {
		func : function() {
			var _layers = layer_get_all();
			var _count = 0;
			for (var i = 0; i < array_length(_layers); i++)
			{
				__OrderManager.__Push($"? layer: {layer_get_name(_layers[i])}");
				var _str = ( layer_get_visible(_layers[i]) ) ? "true" : "false";
				__OrderManager.__Push($"  ? depth: {layer_get_depth(_layers[i])}  visibility: {_str}");
				_count++;
			}
			if ( _count == 0 )
			{
				__OrderManager.__Push($"[x] no layers found");
			}
			else
			{
				var _str = ( _count == 1 ) ? "layer" : "layers";
				__OrderManager.__Push($"[OK] {_count} {_str} found.");
			}
		},
		args : [],
		help : [
			$"? layer_list",
			$"  ? Lists all layers in the current room with their visibility and depth."
		]
	}
}