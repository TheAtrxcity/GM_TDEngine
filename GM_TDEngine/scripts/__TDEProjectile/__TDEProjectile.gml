function TDEProjectileStep()
{
	depth = y * TDE_DEPTH_SORTING.PROJECTILES;
	x = x + lengthdir_x(projectileSpeed, projectileDirection);
	y = y + lengthdir_y(projectileSpeed, projectileDirection);
	
	image_angle = projectileDirection;
	
	meetEnemy = instance_position(x, y, oTDEEnemy);
	
	if (meetEnemy != noone) { meetEnemy.myHealth -= projectileDamage; instance_destroy();}
}