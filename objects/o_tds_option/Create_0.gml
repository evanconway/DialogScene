/// @desc Text Dialog Scene Option

text = undefined; // the text displayed by the option
jtt_object = undefined; // the jtt object that displays the option text
highlight = false;
active = true; // determines if button is visible and logic executes.

/// @desc Returns true if mouse is over button.
/// @func get_mouse_hover()
get_mouse_hover = function() {
	if (!active) return false; // always false if inactive
	
	var _x = device_mouse_x_to_gui(0);
	var _y = device_mouse_y_to_gui(0);

	var _hover_x = (_x >= x && _x <= x + label.textbox_width);
	var _hover_y = (_y >= y && _y <= y + label.textbox_height);

	return (_hover_x && _hover_y);
}

/// @desc Set highlight effect of button to true or false.
/// @func set_highlight(boolean)
set_highlight = function(_h) {
	// we only change the highlight if the new setting is different
	if (highlight != _h) {
		if (!highlight) {
			highlight = true;
			label.set_text("<yellow pulse>" + text + "<>");
			label.advance();
		} else {
			highlight = false;
			label.set_text(text);
			label.advance();
		}
	}
}

/// @desc Set visibility and functionality of button on or off.
/// @func set_active(boolean)
set_active = function(_b) {
	active = _b;
	label.visible = _b;
}
