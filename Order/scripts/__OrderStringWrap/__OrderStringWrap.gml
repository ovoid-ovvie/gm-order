// Feather disable all

function __OrderStringWrap(str, firstLineWidth, subsequentLineWidth)
{
	var _lines = [];
	var _remaining = str;
	var _isFirst = true;
	
	while ( string_length(_remaining) > 0 )
	{
		var _maxW = _isFirst ? firstLineWidth : subsequentLineWidth;
		var _lastFit = 0;
		var _lo = 0;
		var _hi = string_length(_remaining);
		
		while ( _lo <= _hi )
		{
			var _mid = floor((_lo + _hi) / 2);
			var _test = string_copy(_remaining, 1, _mid);
			if ( string_width(_test) <= _maxW )
			{
				_lastFit = _mid;
				_lo = _mid + 1;
			}
			else
			{
				_hi = _mid - 1;
			}
		}
		
		if ( _lastFit == 0 && string_length(_remaining) > 0 )
		{
			_lastFit = 1;
		}
		
		array_push(_lines, string_copy(_remaining, 1, _lastFit));
		_remaining = string_delete(_remaining, 1, _lastFit);
		_isFirst = false;
	}
	
	if ( array_length(_lines) == 0 )
	{
		array_push(_lines, "");
	}
	
	return _lines;
}

