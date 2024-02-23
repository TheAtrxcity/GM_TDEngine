function TDEEnemy() constructor 
{
	static enemies = [];
}

function TDEEnemyCreate(_name, _sprite, _health, _damage, _movementSpeed, _worth) : TDEEnemy() constructor
{
		data = 
		{
			name : _name,
			sprite : _sprite,
			health : _health,
			damage : _damage,
			movementSpeed : _movementSpeed,
			worth : _worth,
		}
		array_push(TDEEnemy.enemies, data);	
}

function TDEEnemyFindPath(_sortDepth)
{
	
	if (_sortDepth) 
	{
		depthCounter += movementSpeed / GRID_WIDTH;
		if (depthCounter >= 1)
		{
			depth = y * TDE_DEPTH_SORTING.ENEMIES; 
			depthCounter = 0;
		}
	}
	
	var _isFollowingPath = (path_endaction == path_action_stop) ? false : true;
	
	if (!_isFollowingPath)
	{
		var _foundPath = mp_grid_path(global.__TDEEnemyGrid, path, x, y, oTDEBase.x, oTDEBase.y, true);
		if (_foundPath)
		{ 
			path_start(path, movementSpeed, path_action_stop, 0); 
			show_debug_message("Function TDEEnemyFindPath\nStarted Path\n");
		}
	}
	
	if (position_meeting(x, y, oTDEBase)) { instance_destroy(); }
}

function TDEEnemyDraw()
{
	var _facingRight = (point_direction(x, y, oTDEBase.x, oTDEBase.y) > 90 && point_direction(x, y, oTDEBase.x, oTDEBase.y) < 270) ? -1 : 1;
	draw_sprite_ext(sprite, image_index, x, y, _facingRight, 1, 0, c_white, 1);
}

function TDEEnemySpawnAtEdge(_index)
{	
	// Randomly choose one of the four edges
	var edge = irandom(3); // 0: top, 1: right, 2: bottom, 3: left
	
	// Set initial position based on the chosen edge
	var _xPosition, _yPosition;
	var _i = 0;
	
	while (_i < 1)
	{
		var _tempPath = path_add()
		
		if (edge == 0)
		{
		        _xPosition = irandom(room_width);
		        _yPosition = 0;
		}
		else if (edge == 1)
		{
		        _xPosition = room_width;
		        _yPosition = irandom(room_height);
		}
		else if (edge == 2)
		{
		        _xPosition = irandom(room_width);
		        _yPosition = room_height;
		}
		else if (edge == 3)
		{
		        _xPosition = 0;
		        _yPosition = irandom(room_height);
		}
		
		var _foundPath = mp_grid_path(global.__TDEEnemyGrid, _tempPath, _xPosition, _yPosition, oTDEBase.x, oTDEBase.y, 1);
		if (_foundPath) 
		{
			_i++;
			path_delete(_tempPath);
		}
	}
	
	if (is_real(_index))
	{
		var _enemyData =TDEEnemy.enemies[_index];
		instance_create_depth(_xPosition, _yPosition, TDE_DEPTH_SORTING.ENEMIES, oTDEEnemy,
		{
			sprite_index : _enemyData.sprite,
			name : _enemyData.name,
			health : _enemyData.health,
			damage : _enemyData.damage,
			movementSpeed : _enemyData.movementSpeed,
			worth : _enemyData.worth,
		});
	}
	else { instance_create_depth(_xPosition, _yPosition, TDE_DEPTH_SORTING.ENEMIES, _index); }
}