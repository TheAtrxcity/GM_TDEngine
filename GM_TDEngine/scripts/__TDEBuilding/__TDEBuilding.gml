function TDEBuilding() constructor
{
	canBuild = function(_index)
	{
		var _selectedTowerSprite = TDETowers.towers[_index].sprite;	
			
		var _x = TDESnapX(mouse_x);
		var _y = TDESnapY(mouse_y);
		
		var _horizontalCells = sprite_get_width(_selectedTowerSprite) / GRID_WIDTH;
		var _verticalCells = sprite_get_height(_selectedTowerSprite) / GRID_HEIGHT;
		
		for (var _i = 0; _i < _horizontalCells; _i++)
		{
			for (var _j = 0; _j < _verticalCells; _j++)
			{
				var _canBuildCell = mp_grid_get_cell(global.__TDEGrid, ((_x + _i * GRID_WIDTH) / GRID_WIDTH),(( _y + _j * GRID_HEIGHT) / GRID_HEIGHT)) == 0
				if (_canBuildCell == false) 
				{
					return false;
				}
			}
		}
		return true;
	}
}

function TDEBuildingDraw(_index) : TDEBuilding() constructor
{
	var _selectedTowerSprite = TDETowers.towers[_index].sprite;
	
	var _horizontalCells = sprite_get_width(_selectedTowerSprite) / GRID_WIDTH;
	var _verticalCells = sprite_get_height(_selectedTowerSprite) / GRID_HEIGHT;
	
	var _x = TDESnapX(mouse_x);
	var _y = TDESnapY(mouse_y);
	
	//Draw the build cells and check them individually
	for (var _i = 0; _i < _horizontalCells; _i++)
	{
		for (var _j = 0; _j < _verticalCells; _j++)
		{
			var _canBuildCell = mp_grid_get_cell(global.__TDEGrid, ((_x + _i * GRID_WIDTH) / GRID_WIDTH),(( _y + _j * GRID_HEIGHT) / GRID_HEIGHT)) == 0
			
			if (_canBuildCell) { draw_sprite_stretched_ext(sGridChecker, 0, _x + (_i * GRID_WIDTH), _y + (_j * GRID_HEIGHT), GRID_WIDTH, GRID_HEIGHT, c_white, 0.8); } 
			else { draw_sprite_stretched_ext(sGridChecker, 0, _x + (_i * GRID_WIDTH), _y + (_j * GRID_HEIGHT), GRID_WIDTH, GRID_HEIGHT, c_red, 0.8); } 
		}
	}
	
	// Set the position and size of the rectangle
	var _xCenter = _x + sprite_get_width(_selectedTowerSprite) / 2;
	var _yCenter = _y + sprite_get_height(_selectedTowerSprite) / 2;
	var _towerRange = TDETowers.towers[_index].range;
	var _halfWidth = _towerRange / 2;
	var _halfHeight = _towerRange / 2;
	
	// Draw the stretched sprite
	draw_sprite_stretched(sRangeSprite, image_index / 10, _xCenter - _halfWidth, _yCenter - _halfHeight, _towerRange, _towerRange);

	if (canBuild(_index))
	{ draw_sprite_ext(_selectedTowerSprite, 0, _x, _y, 1, 1, 0, c_white, 0.6); }
	else { draw_sprite_ext(_selectedTowerSprite, 0, _x, _y, 1, 1, 0, c_white, 0.4); }
}

function TDEBuildingBuild(_index) : TDEBuilding() constructor
{
	var _selectedTower = TDETowers.towers[_index];
	
	if (canBuild(_index) && TDE_MONEY > _selectedTower.cost)
	{
		var _x = TDESnapX(mouse_x);
		var _y = TDESnapY(mouse_y);
		
		buildTower = instance_create_depth(_x, _y, TDE_DEPTH_SORTING.TOWERS, oTDETower,
		{
			sprite_index : _selectedTower.sprite,
			cost : _selectedTower.cost,
		});

		TDEHelperAddCells(false, _selectedTower.sprite, buildTower.x, buildTower.y);
		
		TDE_MONEY -= _selectedTower.cost;
	}
}

function TDEBuildingRemove() : TDEBuilding() constructor
{
	var _towerUnderMouse = instance_position(mouse_x, mouse_y, oTDETower);
	
	if (_towerUnderMouse != noone)
	{
		var _towerSprite = _towerUnderMouse.sprite_index;
		
		var _horizontalCells = sprite_get_width(_towerSprite) / GRID_WIDTH;
		var _verticalCells = sprite_get_height(_towerSprite) / GRID_HEIGHT;
		
		var _x = _towerUnderMouse.x;
		var _y = _towerUnderMouse.y;
		
		for (var _i = 0; _i < _horizontalCells; _i++)
		{
			for (var _j = 0; _j < _verticalCells; _j++)
			{
				mp_grid_clear_cell(global.__TDEGrid, ((_x + _i * GRID_WIDTH) / GRID_WIDTH),(( _y + _j * GRID_HEIGHT) / GRID_HEIGHT));
			}
		}
		
		with (_towerUnderMouse)
		{
			instance_destroy();
			TDE_MONEY += (cost / 100) * TDE_RESELL_PERCENTAGE;
		}
	}
}