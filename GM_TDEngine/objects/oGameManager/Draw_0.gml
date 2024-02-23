TDEBuildingDraw(0);

if (keyboard_check(vk_f11)) { mp_grid_draw(global.__TDEGrid); }
if (keyboard_check(vk_f10)) { mp_grid_draw(global.__TDEEnemyGrid); }

draw_set_font(fntDebug);
draw_set_color(c_black);
draw_text(16, 17, $"Enemies: {instance_number(oTDEEnemy)}\nFPS:{fps} / {fps_real}");
draw_set_color(c_white)
draw_text(16, 16, $"Enemies: {instance_number(oTDEEnemy)}\nFPS:{fps} / {fps_real}");