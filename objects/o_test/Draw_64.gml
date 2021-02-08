/// @description Insert description here
// You can write your code in this editor

var _x = 300;
var _y = 300;
var mouse = [device_mouse_x_to_gui(0), device_mouse_y_to_gui(0)];

if (test_option.option_point_on(_x, _y, mouse[0], mouse[1])) {
	test_option.option_set_highlight(true);
} else {
	test_option.option_set_highlight(false);
}

test_option.option_draw(_x, _y);
