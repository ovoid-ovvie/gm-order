time_source_start(time_source_create(time_source_global, 1, time_source_units_frames, function() 
{
	var _obj = __OrderManager;
	
	if ( !instance_exists(_obj) )
	{
		instance_activate_object(_obj);
		if ( instance_exists(_obj) )
		{
			if ( GM_build_type == "run" )
			{
				__OrderError("__OrderManager has been deactivated.\nPlease ensure that __OrderManager is never deactivated.");
			}
			else
			{
				__OrderTrace("__OrderManager has been deactivated.\nPlease ensure that __OrderManager is never deactivated.\nReactivating now...");
			}
		}
		else
		{
			var _inst = instance_create_depth(0, 0, -15900, _obj);
			_inst.persistent = true;
		}
	}
}, [], -1));

if ( !directory_exists("order_api") )
{
	directory_create("order_api");
}

if ( !directory_exists("order_api/screenshots") )
{
	directory_create("order_api/screenshots");
}