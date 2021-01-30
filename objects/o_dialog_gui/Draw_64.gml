/// @description Insert description here
// You can write your code in this editor
var draw_options = [draw_get_color(), draw_get_alpha()]
if (choice_selected >= 0) {
	draw_text(0, 0, "Choice Clicked: " + string(choice_selected));
}

draw_set_color(c_lime);
draw_text(0, 50, "Mouse GUI: " + string(mouse[0]) + ", " + string(mouse[1]));

draw_set_color(draw_options[0]);
draw_set_alpha(draw_options[1]);
