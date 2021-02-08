
/// @func TDS_Option_List(*width)
function TDS_Option_List() constructor {
	option_list_width = (argument_count > 0) ? argument[0] : undefined;
	options = [];
	option_spacer = 1;
	
	/// @func add_option(text)
	add_option = function(_text) {
		if (option_list_width == undefined) array_push(options, new TDS_Option(_text));
		else array_push(options, new TDS_Option(_text, option_list_width));
	}
	
	/* This function sets the highlight on the given option index, and off for all others. 
	There for, an index not included in options, like -1, will turn all highlights off. */
	/// @func option_list_highlight(option_index)
	option_list_highlight = function(_index) {
		for (var i = 0; i < array_length(options); i++) {
			if (i == _index) options[i].option_set_highlight(true);
			else options[i].option_set_highlight(false);
		}
	}
	
	/// @desc Return index of option at given xy. -1 if non at point.
	/// @func option_list_get_option_xy(list_x, list_y, point_x, point_y)
	option_list_get_option_xy = function(_x, _y, _point_x, _point_y) {
		var _y_check = _y;
		for (var i = 0; i < array_length(options); i++) {
			if (options[i].option_point_on(_x, _y_check, _point_x, _point_y)) {
				return i;
			} else {
				_y_check += options[i].option_height;
				_y_check += option_spacer;
			}
		}
		return -1;
	}
	
	/// @func option_list_draw(x, y)
	option_list_draw = function(_x, _y) {
		var _draw_y = _y
		for (var i = 0; i < array_length(options); i++) {
			options[i].option_draw(_x, _draw_y);
			_draw_y += options[i].option_height;
			_draw_y += option_spacer;
		}
	}
}