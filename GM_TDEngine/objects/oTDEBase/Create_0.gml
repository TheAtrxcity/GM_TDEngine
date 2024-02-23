// This is just code to set the building in the middle of the room.
// You can remove this code and place the base anywhere you want. 
x = (room_width / 2);
y = (room_height / 2);

// We set the depth manually so we can place the base wherever we want in the room editor.
depth = (y + 1) * TDE_DEPTH_SORTING.TOWERS

// Snap to a cell so we don't have half cells.
x = TDESnapX(x);
y = TDESnapY(y);

// Occupy cells for building. 
TDEHelperAddCells(true);