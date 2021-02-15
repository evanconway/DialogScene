/// @description Insert description here
// You can write your code in this editor

var mouse = { x: device_mouse_x_to_gui(0), y: device_mouse_y_to_gui(0) };
var draw = { x: 100, y: 100 };

var _option = current.tds_scene_get_option_at_xy(draw.x, draw.y, mouse.x, mouse.y);
current.tds_scene_option_set_highlight(_option);

if (mouse_check_button_pressed(mb_left)) {
	if (_option < 0) _option = 0;
	
	if (!current.tds_scene_finished()) {
		current.tds_scene_advance(_option);
	} else {
		var _links = current.tds_get_links();
		if (array_length(_links) > 0) {
			current = _links[_option]; // set to option to allow linking from options
		}
	}
}

current.tds_scene_draw(draw.x, draw.y);
