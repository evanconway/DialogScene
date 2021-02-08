/// @description Insert description here
// You can write your code in this editor

if (!active) exit;

var _original_color = draw_get_color();
var _original_alpha = draw_get_alpha();

if (highlight) {
	draw_set_color(c_red);
	draw_set_alpha(1);
	//draw_rectangle(x, y, x + label.textbox_width, y + label.textbox_height, false);
}

draw_set_color(_original_color);
draw_set_alpha(_original_alpha);
