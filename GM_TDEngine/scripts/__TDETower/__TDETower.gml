function TDETowers() constructor
{
	static towers = [];
}

function TDETowersCreate(_sprite, _damage, _range, _ammo, _attackSpeed, _reloadSpeed, _projectileSprite, _projectileSpeed, _projectileType, _cost, _upgradeCost) : TDETowers() constructor 
{
		data = 
		{
			sprite : _sprite,
			damage : _damage,
			range : _range,
			ammo : _ammo,
			attackSpeed : _attackSpeed,
			reloadSpeed : _reloadSpeed,
			projectileSprite : _projectileSprite,
			projectileSpeed : _projectileSpeed,
			projectileType : _projectileType,
			upgradeCost : _upgradeCost,
			cost : _cost,
		}
		array_push(TDETowers.towers, data);
		show_debug_message($"{TDETowers.towers}");
}

function TDETowersStep(_index)
{
	var _tower = TDETowers.towers[_index];
	var _xCenter = x + sprite_get_width(_tower.sprite) / 2;
	var _yCenter = y + sprite_get_height(_tower.sprite) / 2;
	
	#region Targetting and finding enemies
	scoutingTimer++
	if (scoutingTimer >= _tower.attackSpeed)
	{
			// Set the position and size of the rectangle in the middle of the tower
			var _towerRange = _tower.range;
			var _halfWidth = _towerRange / 2;
			var _halfHeight = _towerRange / 2;
			
			// Find targets within the towers range
			var _enemiesInRange = ds_list_create();
			var _enemiesCount = collision_rectangle_list( _xCenter - _halfWidth, _yCenter - _halfHeight, _towerRange, _towerRange, oTDEEnemy, false, true, _enemiesInRange, false);
			targetEnemy = _enemiesInRange[| 0];
			if (_enemiesCount > 0)
			{
			    for (var _i = 0; _i < _enemiesCount; _i++;)
			    {
					if (targeting == TDE_TARGETING.LOWEST_HEALTH)
					{
						if (targetEnemy.health < _enemiesInRange[| _i].health) break;
						targetEnemy = _enemiesInRange[| _i]; 
					}				
			    }
			}
			ds_list_destroy(_enemiesInRange);
	}
	#endregion
	
	attackTimer++
	if (instance_exists(targetEnemy) && ammo > 0 && attackTimer >= _tower.attackSpeed)
	{
		instance_create_depth(_xCenter, _yCenter, TDE_DEPTH_SORTING.PROJECTILES, oTDEProjectile);
		ammo -= 1;
		attackTimer = 0;
	}
}