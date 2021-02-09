/// @description Insert description here
// You can write your code in this editor

var mouse = [device_mouse_x_to_gui(0), device_mouse_y_to_gui(0)];

var _hovered = test_list.option_list_get_option_xy(300, 300, mouse[0], mouse[1]);
draw_set_color(c_white);
draw_set_alpha(1);
draw_text(0, 0, string(_hovered));

test_list.option_list_highlight(_hovered);

test_list.option_list_draw(300, 300);

portrait.portrait_draw(200, 200);

portrait.portrait_set_alignments(fa_bottom, fa_right);
