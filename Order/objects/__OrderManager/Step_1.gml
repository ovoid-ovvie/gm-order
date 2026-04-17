if ( !summonConsume && keyboard_check_pressed(ORDER_SUMMON_KEY) )
{
	summonConsume = true;
	consoleActive = !consoleActive;
	showTrail = true;
	keyboard_string = "";
	viewpoint = undefined;
}