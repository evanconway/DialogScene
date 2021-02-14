/// @description Insert description here
// You can write your code in this editor

if (keyboard_check_pressed(ord("1"))) {
	box.tds_box_set_data("I'm so amazing", 0, s_character, undefined);
}

if (keyboard_check_pressed(ord("2"))) {
	box.tds_box_set_data("What should we do today?", 1, s_character, undefined, 
		[
			"Go to the store",
			"Play Sports!",
			"I dunno..."
		]
	);
}

if (keyboard_check_pressed(ord("3"))) {
	box.tds_box_set_data("Maybe not.", 2, s_character);
}

if (keyboard_check_pressed(ord("4"))) {
	box.tds_box_set_data("I'm a total box.", 0, s_character2, "chirp:snd_chirp2 f:f_handwriting");
}

if (keyboard_check_pressed(ord("5"))) {
	box.tds_box_set_data("I hear a strange sound.", 1, s_character2, "chirp:snd_chirp2 f:f_handwriting");
}

if (keyboard_check_pressed(ord("6"))) {
	box.tds_box_set_data("It's a monster.", 2, s_character2, "chirp:snd_chirp2 f:f_handwriting");
}

var mouse = { x: device_mouse_x_to_gui(0), y: device_mouse_y_to_gui(0) };

if (keyboard_check_pressed(vk_up)) box.tds_box_option_set_highlight_prev();
if (keyboard_check_pressed(vk_down)) box.tds_box_option_set_highlight_next();

//box.tds_box_option_set_highlight_at_xy(100, 100, mouse.x, mouse.y);

box.tds_box_draw(100, 100);
