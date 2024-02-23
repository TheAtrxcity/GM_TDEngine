depth = -10000;

TDETowersCreate(
sTower, // Sprite
10, // Damage
128, // Range in pixels
10, // Ammo per reload
10, // Attack speed, Time in between shots
120, // Reload Speed, The time it takes to reload
0, // Projectile sprite
0, // Speed a projectile goes
0, // Damage type, 0 = Normal
10, //Cost to buy tower
0 // Cost to upgrade tower 
);

TDEEnemyCreate(
"Name", // Enemy Name
sEnemy, // Sprite Index
100, // Health
1, // Amount of lives removed when reaching base
0.5, // Movement speed in pixels per frame
1 // The amount of money received when killed
);

window_set_cursor(cr_none);

// This code can be freely removed. It's a random map generator.
groundLayer = layer_create(TDE_DEPTH_SORTING.TILES_BACKGROUND,"Grass Tiles");
groundTilemap = layer_tilemap_create(groundLayer, 0, 0, tsGrassTiles, room_width, room_height);

for (var _i = 0; _i < 60; _i++)
{
	var randomTileIndex = irandom_range(2, 5);
	var _x = TDESnapX(irandom(room_width));
	var _y = TDESnapY(irandom(room_height));
	tilemap_set_at_pixel(groundTilemap, randomTileIndex, _x, _y);
}

var _i = 0; 

while (_i < 30)
{
	var _x = TDESnapX(irandom(room_width));
	var _y = TDESnapY(irandom(room_height));
	if (place_free(_x, _y))
	{
		instance_create_depth(_x, _y, TDE_DEPTH_SORTING.ENVIROMENT * (_y + 1), oEnviroment, {image_speed : 0, image_index : irandom(1)});
		_i += 1;
	}
}

mp_grid_add_instances(global.__TDEGrid, oGridOccupier, 1);
mp_grid_add_instances(global.__TDEEnemyGrid, oGridOccupier, 1);