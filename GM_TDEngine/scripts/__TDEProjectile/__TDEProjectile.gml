function TDEProjectileStep()
{
	depth = y * TDE_DEPTH_SORTING.PROJECTILES;
	x = x + lengthdir_x(projectileSpeed, projectileDirection);
	y = y + lengthdir_y(projectileSpeed, projectileDirection);
	image_angle = projectileDirection;
	
	if (place_meeting(x, y, oTDEEnemy))
	{
		instance_place(x, y, oTDEEnemy).health -= projectileDamage;
		instance_destroy();
	}
}