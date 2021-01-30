/*
To make life easy, we're just going to copy the Undertale style for this thing.
We never create a button by creating this instance. We always call the creation
function from the dialog gui script.
*/
text = undefined;
label = undefined;
highlight = false;
active = true; // determines if button is visible and logic executes.

/// @func get_mouse_hover()
get_mouse_hover = function() {
	if (!active) return false; // always false if inactive
	
	var _x = device_mouse_x_to_gui(0);
	var _y = device_mouse_y_to_gui(0);

	var _hover_x = (_x >= x && _x <= x + label.textbox_width);
	var _hover_y = (_y >= y && _y <= y + label.textbox_height);

	return (_hover_x && _hover_y);
}

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

set_active = function(_b) {
	active = _b;
	label.visible = _b;
}
