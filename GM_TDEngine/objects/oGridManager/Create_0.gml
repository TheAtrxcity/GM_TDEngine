global.__TDEGrid = mp_grid_create(0, 0, room_width / GRID_WIDTH, room_height / GRID_HEIGHT, GRID_WIDTH, GRID_HEIGHT);
global.__TDEEnemyGrid =  mp_grid_create(0, 0, (room_width + 16) / GRID_WIDTH, (room_height + 16) / GRID_HEIGHT, GRID_WIDTH, GRID_HEIGHT);
mp_grid_add_instances(global.__TDEGrid, oGridOccupier, 1);