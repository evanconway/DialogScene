/// @description Insert description here
// You can write your code in this editor

mouse = [device_mouse_x_to_gui(0), device_mouse_y_to_gui(0)];
if (keyboard_check_pressed(vk_anykey)) {
	mouse_using = false;
}
var _mouse_moved = (mouse[0] != mouse_prev[0] || mouse[1] != mouse_prev[1]);
if (_mouse_moved) {
	mouse_using = true;
}
choice_selected = -1;
if (mouse_using) {
	window_set_cursor(cr_default);
} else {
	window_set_cursor(cr_none);
}

/*
If the text is not finished
*/
if (!textbox.get_typing_all_finished()) {
	// set buttons invisible
	for (var i = 0; i < array_length(choices); i++) {
		choices[i].set_active(false);
	}
	// check for user input to advance text typing
	if (keyboard_check_pressed(vk_space) || mouse_check_button_pressed(mb_left)) {
		textbox.advance();
	}
} else {
	// otherwise set buttons visible...
	for (var i = 0; i < array_length(choices); i++) {
		choices[i].set_active(true);
	}
	// and detect user input for choice selection
	if (mouse_using) {
		choice_highlighted = -1;
		for (var i = 0; i < array_length(choices); i++) {
			var _button = choices[i];
			with (_button) {
				set_highlight(get_mouse_hover());
				if (get_mouse_hover()) other.choice_highlighted = i;
				if (get_mouse_hover() && mouse_check_button_pressed(mb_left)) {
					other.choice_selected = i;
				}
			}
		}
	} else {
		/*
		On the first frame the user changes from mouse input to keyboard input, we
		want to ignore the input if there is no choice highlighted. This creates a 
		clearer user experience. 
		*/
		if (choice_highlighted < 0) choice_highlighted = 0;
		else {
			if (keyboard_check_pressed(vk_up) && choice_highlighted > 0) choice_highlighted--;
			if (keyboard_check_pressed(vk_down) && choice_highlighted < array_length(choices) - 1) choice_highlighted++;
			if (keyboard_check_pressed(vk_enter)) choice_selected = choice_highlighted;
		}
		
		// button highlighting
		for (var i = 0; i < array_length(choices); i++) {
			var _button = choices[i];
			if (choice_highlighted == i) {
				_button.set_highlight(true);
			} else _button.set_highlight(false);
		}
	}
	
	// advance gui depending on input and choice selection
	// logic is different if there are no choices
	if (array_length(choices) <= 0) {
		if (keyboard_check_pressed(vk_space) || mouse_check_button_pressed(mb_left)) {
			dialog_tree.tree_advance();
			dialog_set_data();
		}
	} else {
		if (choice_selected >= 0) {
			dialog_tree.tree_advance(choice_selected);
			dialog_set_data();
		}
	}
}

mouse_prev = mouse;
mouse_using_prev = mouse_using;
