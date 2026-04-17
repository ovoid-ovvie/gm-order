if ( consoleActive )
{
	var _cam = camera_get_active();
	
	var _displayW = display_get_gui_width();
	var _displayH = display_get_gui_height();
	
	draw_set_font(__OrderFont);
	
	var _trail = ORDER_TEXT_CURSOR;
	var _padding = 4;
	var _lineH = string_height("test");
	var _prefixFirst = "> ";
	var _prefixCont  = "-> ";
	var _trailW = string_width(_trail);
	
	var _firstLineW = _displayW - 8 - string_width(_prefixFirst) - 16;
	var _contLineW  = _displayW - 8 - string_width(_prefixCont)  - 16;
	
	var _lines = __OrderStringWrap(keyboard_string, _firstLineW, _contLineW);
	
	var _lastIdx   = array_length(_lines) - 1;
	var _lastMaxW  = ( _lastIdx == 0 ) ? _firstLineW : _contLineW;
	var _lastLineW = string_width(_lines[_lastIdx]);
	var _trailNeedsNewLine = _lastLineW + _trailW > _lastMaxW;
	
	if ( _trailNeedsNewLine )
	{
		array_push(_lines, "");
	}
	
	var _inputChanged = string_length(keyboard_string) != prevKeyboardStringLength;
	var _showingTrail = false;
	
	if ( _inputChanged )
	{
		autocompleteSuggestions = [];
		autocompleteIndex = -1;
		autocompleteBase = "";
		_showingTrail = true;
		alarm[0] = ORDER_PULSE_INTERVAL * game_get_speed(gamespeed_fps);
	}
	else if ( showTrail )
	{
		_showingTrail = true;
	}
	
	var _lineCount   = array_length(_lines);
	var _inputBoxBot = _displayH;
	var _inputBoxTop = _inputBoxBot - _lineCount * _lineH - _padding * 2;
	
	draw_set_colour(c_grey);
	draw_set_alpha(0.7);
	draw_rectangle(0, 0, _displayW, _inputBoxTop, false);
	
	draw_set_colour(c_black);
	draw_set_alpha(0.9);
	draw_rectangle(0, _inputBoxTop, _displayW, _inputBoxBot, false);
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_colour(c_lime);
	draw_set_alpha(1);
	
	for ( var _i = 0; _i < _lineCount; _i++ )
	{
		var _prefix  = ( _i == 0 ) ? _prefixFirst : _prefixCont;
		var _suffix = ( _showingTrail && _i == _lineCount - 1 ) ? _trail : "";
		var _lineStr = _prefix + _lines[_i] + _suffix;
		var _lineY   = _inputBoxTop + _padding + _lineH * _i + _lineH * 0.5;
		draw_text(8, _lineY, _lineStr);
	}
	
	draw_set_colour(c_white);
	
	if ( alarm[0] == -1 )
	{
		alarm[0] = ORDER_PULSE_INTERVAL * game_get_speed(gamespeed_fps);
	}
	
	prevKeyboardStringLength = string_length(keyboard_string);
	
	if ( array_length(log) > 0 )
	{
		viewpoint ??= __IndexLast();
		var _x = 8;
		var _y = _inputBoxTop - _padding - _lineH / 2;
		var _index = viewpoint;
		var _maxLogWidth = _displayW - _padding * 2;
		
		do
		{
			var _logLines = __OrderStringWrap(log[_index], _maxLogWidth, _maxLogWidth);
			var _logLinesCount = array_length(_logLines);
			
			for (var i = _logLinesCount - 1; i >= 0; i--)
			{
				draw_text(_x, _y, _logLines[i]);
				_y -= _lineH;
			}
			
			_index--;
		}
		until ( (_y <= 0) || (_index < 0) );
	}
	
	if ( array_length(autocompleteSuggestions) > 0 )
	{
	    var _suggestY = _inputBoxTop;
	    for (var i = array_length(autocompleteSuggestions) - 1; i >= 0; i--)
	    {
			if ( i != array_length(autocompleteSuggestions) - 1 )
			{
				_suggestY -= _lineH;
			}
	        if ( i == autocompleteIndex )
	        {
	            draw_set_colour(c_white);
	            draw_rectangle(0, _suggestY - _lineH, _displayW, _suggestY, false);
	            draw_set_colour(c_black);
	        }
	        else
	        {
	            draw_set_colour(c_dkgrey);
	            draw_rectangle(0, _suggestY - _lineH, _displayW, _suggestY, false);
	            draw_set_colour(c_lime);
	        }
	        draw_text(8, _suggestY - _lineH * 0.5, autocompleteSuggestions[i]);
	    }
	}
}