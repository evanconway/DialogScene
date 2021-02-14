/// @description Insert description here
// You can write your code in this editor

var mouse = { x: device_mouse_x_to_gui(0), y: device_mouse_y_to_gui(0) };
var draw = { x: 100, y: 100 };

if (mouse_check_button_pressed(mb_left)) {
	var _option = scene.tds_scene_get_option_at_xy(draw.x, draw.y, mouse.x, mouse.y);
	if (_option < 0) _option = 0;
	scene.tds_scene_advance(0);
}

scene.tds_scene_draw(draw.x, draw.y);
