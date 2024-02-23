/// @function AnimateWithCurve(_animationCurve, _curveName, _speed, _startValue, _endValue)
/// @param {.GMAnimCurve} animation_asset
/// @param {string} curve_name
/// @param {real} animation_speed
/// @param {real} starting_value
/// @param {real} endValue
function AnimateWithCurve(_animationCurve, _curveName, _speed, _startValue, _endValue) constructor
{
	curve = animcurve_get_channel(_animationCurve, _curveName);
	percent = 0;
	animationSpeed = _speed;
	startValue = _startValue;
	endValue = _endValue;
	
	Run = function() // Runs the animation (needs to be run every frame)
	{
		percent = min(1, percent + animationSpeed);
		
		position = animcurve_channel_evaluate(curve, percent);
		var _calculateLength = endValue - startValue;
		
		return (startValue + (_calculateLength * position))
	}
	
	Value = function()
	{
		var _calculateLength = endValue - startValue;
		
		return (startValue + (_calculateLength * position))
	}
	
	Loop = function()
	{
	    percent = percent + animationSpeed;
	
	    if (percent >= 1 || percent <= 0) {
	        animationSpeed = -animationSpeed; // Reverse direction
	        percent = clamp(percent, 0, 1); // Ensure percent stays within [0, 1]
	    }
	
	    position = animcurve_channel_evaluate(curve, percent);
	    var _calculateLength = endValue - startValue;
	
	    return (startValue + (_calculateLength * position));
	}

	
	Reverse = function() // Reverses the animation
	{
		percent = max(0, percent - animationSpeed);
		
		position = animcurve_channel_evaluate(curve, percent);
		var _calculateLength = endValue - startValue;
		
		return (startValue + (_calculateLength * position))
	}
	
	AnimationEnd = function() // Checks if the animation has ended
	{
		if (percent >= 1) { return (true) } else { return (false) }
	}
	
	Reset = function() //Resets the animation
	{
		percent = 0;
	}
}

function TDEHelperAddCells(_originMiddle, _sprite = sprite_index, _x = x, _y = y)
{
	if (_originMiddle)
	{
	    var halfWidth = sprite_get_width(_sprite) / 2;
	    var halfHeight = sprite_get_height(_sprite) / 2;
	    
	    var horizontalCells = sprite_get_width(_sprite) / GRID_WIDTH;
	    var verticalCells = sprite_get_height(_sprite) / GRID_HEIGHT;
	    
	    for (var i = 0; i < horizontalCells; i++)
	    {
	        for (var j = 0; j < verticalCells; j++)
	        {
	            var cellX = floor((_x - halfWidth + (i * GRID_WIDTH)) / GRID_WIDTH);
	            var cellY = floor((_y - halfHeight + (j * GRID_HEIGHT)) / GRID_HEIGHT);
	    
	            mp_grid_add_cell(global.__TDEGrid, cellX, cellY);
	        }
	    }
	}
	else
	{
	    var horizontalCells = sprite_get_width(_sprite) / GRID_WIDTH;
	    var verticalCells = sprite_get_height(_sprite) / GRID_HEIGHT;
	    
		show_debug_message($"Function TDEHelperAddCells\n\nHorizontal Cells: {horizontalCells}\nVertical Cells: {verticalCells}")
		
	    for (var i = 0; i < horizontalCells; i++)
	    {
	        for (var j = 0; j < verticalCells; j++)
	        {
	            var cellX = floor((_x + (i * GRID_WIDTH)) / GRID_WIDTH);
	            var cellY = floor((_y + (j * GRID_HEIGHT)) / GRID_HEIGHT);
	    
	            mp_grid_add_cell(global.__TDEGrid, cellX, cellY);
	        }
	    }
	}
}

function TDESnapX(_x)
{
	return (floor(_x / GRID_WIDTH) * GRID_WIDTH);
}

function TDESnapY(_y)
{
	return (floor(_y / GRID_HEIGHT) * GRID_HEIGHT);
}