
/// @func TDS_Option_List(*width)
function TDS_Option_List() constructor {
	
	// this width variable is only used for forcing options to be the same width
	option_list_width = (argument_count > 0) ? argument[0] : undefined;
	options = [];
	option_list_spacer = 1;
	
	option_list_align_v = fa_top;
	option_list_align_h = fa_left;
	
	option_list_display = 0; // 0 for vertial, 1 for horizontal
	
	option_list_debugging = true;
	
	/// @func option_list_add(text)
	option_list_add = function(_text) {
		var _new_option = (option_list_width == undefined) ? new TDS_Option(_text) : new TDS_Option(_text, option_list_width);
		_new_option.option_set_alignments(option_list_align_v, option_list_align_h);
		array_push(options, _new_option);
	}
	
	/* This function sets the highlight on the given option index, and off for all others. 
	Therefore, an index not included in options, like -1, will turn all highlights off. */
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
		for (var i = 0; i < array_length(options); i++) {
			var _check = option_list_get_xy_of_option(_x, _y, i);
			if (options[i].option_point_on(_check.x, _check.y, _point_x, _point_y)) {
				return i;
			} 
		}
		return -1;
	}
	
	/// @func option_list_get_width()
	option_list_get_width = function() {
		var result = 0;
		
		// recall that options will all have the same width if it was specified at list creation
		for (var i = 0; i < array_length(options); i++) {
			var _width = options[i].option_get_width();
			if (option_list_display == 0) {
				if (_width > result) result = _width;
			}
			if (option_list_display == 1) {
				result += _width;
			}
		}
		
		if (option_list_display == 1) result += (option_list_spacer * (array_length(options) - 1));
		return result;
	}
	
	/// @function option_list_get_height()
	option_list_get_height = function() {
		var result = 0;
		
		for (var i = 0; i < array_length(options); i++) {
			var _height = options[i].option_get_height();
			if (option_list_display == 0) {
				result += _height;
			}
			if (option_list_display == 1) {
				if (_height > result) result = _height;
			}
		}
		
		if (option_list_display == 0) result += (option_list_spacer * (array_length(options) - 1));
		return result;
	}
	
	/// @func option_list_set_alignments(vertical, horizontal)
	option_list_set_alignments = function(_v, _h) {
		if (_v == fa_top || _v == fa_bottom || _v == fa_center) option_list_align_v = _v;
		else show_error("TDS error. Improper option list alignment value.", true);
		
		if (_h == fa_left || _h == fa_right || _h == fa_center) option_list_align_h = _h;
		else show_error("TDS error. Improper option list alignment value.", true);
		
		// assign alignments to options
		for (var i = 0; i < array_length(options); i++) {
			options[i].option_set_alignments(option_list_align_v, option_list_align_h);
		}
	}
	
	/// @func option_list_get_xy_of_option(list_x, list_y, option_index)
	option_list_get_xy_of_option = function(_x, _y, _index) {
		var _draw_y = _y;
		var _draw_x = _x;
		
		/* Since the options display their own alignment correctly, all we
		need to do for a vertical display is keep track of y drawing. */
		if (option_list_display == 0) {
			if (option_list_align_v == fa_top) {
				for (var i = 0; i < array_length(options); i++) {
					if (i == _index) return { x: _draw_x, y: _draw_y };
					_draw_y += options[i].option_get_height();
					_draw_y += option_list_spacer;
				}
			}
			if (option_list_align_v == fa_bottom) {
				for (var i = array_length(options) - 1; i >= 0; i--) {
					if (i == _index) return { x: _draw_x, y: _draw_y };
					_draw_y -= options[i].option_get_height();
					_draw_y -= option_list_spacer;
				}
			}
			if (option_list_align_v == fa_center) {
				/* Center is slightly more complicated. We have to start drawing
				half way up the height of the list, but offset by half the height
				of the first option. */
				_draw_y -= (option_list_get_height() / 2);
				_draw_y += (options[0].option_get_height() / 2);
				for (var i = 0; i < array_length(options); i++) {
					if (i == _index) return { x: _draw_x, y: _draw_y };
					_draw_y += (options[i].option_get_height() / 2);
					_draw_y += option_list_spacer;
					if ((i + 1) < array_length(options)) _draw_y += (options[i + 1].option_get_height() / 2);
				}
			}
		}
		
		/* The same principle applies for horizontal drawing, just with the x
		position instead. */
		if (option_list_display == 1) {
			if (option_list_align_h == fa_left) {
				for (var i = 0; i < array_length(options); i++) {
					if (i == _index) return { x: _draw_x, y: _draw_y };
					_draw_x += options[i].option_get_width();
					_draw_x += option_list_spacer;
				}
			}
			if (option_list_align_h == fa_right) {
				for (var i = array_length(options) - 1; i >= 0; i--) {
					if (i == _index) return { x: _draw_x, y: _draw_y };
					_draw_x -= options[i].option_get_width();
					_draw_x -= option_list_spacer;
				}
			}
			if (option_list_align_h == fa_center) {
				_draw_x -= (option_list_get_width() / 2);
				_draw_x += (options[0].option_get_width() / 2);
				for (var i = 0; i < array_length(options); i++) {
					if (i == _index) return { x: _draw_x, y: _draw_y };
					_draw_x += options[i].option_get_width();
					_draw_x += option_list_spacer;
				}
			}
		}
		
		return undefined;
	}
	
	/// @func option_list_draw(x, y)
	option_list_draw = function(_x, _y) {
		for (var i = 0; i < array_length(options); i++) {
			var _draw = option_list_get_xy_of_option(_x, _y, i);
			options[i].option_draw(_draw.x, _draw.y);
		}
		
		// debugging
		if (option_list_debugging) {
			_draw_x = _x;
			_draw_y = _y;
			draw_set_alpha(1);
			draw_set_color(c_gray);
			if (option_list_align_h == fa_right) _draw_x -= option_list_get_width();
			if (option_list_align_h == fa_center) _draw_x -= option_list_get_width() / 2;
			if (option_list_align_v == fa_bottom) _draw_y -= option_list_get_height();
			if (option_list_align_v == fa_center) _draw_y -= option_list_get_height() / 2;
			draw_rectangle(_draw_x, _draw_y, _draw_x + option_list_get_width(), _draw_y + option_list_get_height(), true);
			draw_set_color(c_fuchsia);
			draw_circle(_x, _y, 3, false);
		}
	}
}
