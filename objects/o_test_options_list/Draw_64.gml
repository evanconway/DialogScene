/// @description Insert description here
// You can write your code in this editor

var mouse = [device_mouse_x_to_gui(0), device_mouse_y_to_gui(0)];
var _draw = { x: 50, y: 300 };

var _hovered = test_list.option_list_get_option_xy(_draw.x, _draw.y, mouse[0], mouse[1]);
//draw_set_color(c_white);
//draw_set_alpha(1);
//draw_text(0, 0, string(_hovered));

test_list.option_list_highlight(_hovered);

//test_list.option_list_draw(_draw.x, _draw.y);

//portrait.portrait_draw(200, 200);

colors.draw(500, 200);
combined.draw(500, 200);
typing.draw(500, 200);
