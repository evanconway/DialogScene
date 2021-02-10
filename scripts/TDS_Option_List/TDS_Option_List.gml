
/// @func TDS_Option_List(*width)
function TDS_Option_List() constructor {
	
	// this width variable is only used for forcing options to be the same width
	option_list_width = (argument_count > 0) ? argument[0] : undefined;
	options = [];
	option_list_spacer = 1;
	
	option_list_align_v = fa_top;
	option_list_align_h = fa_left;
	
	option_list_options_align_v = fa_top;
	option_list_options_align_h = fa_left;
	
	option_list_text_align_v = fa_top;
	option_list_text_align_h = fa_left;
	
	option_list_display = 0; // 0 for vertial, 1 for horizontal
	
	option_list_debugging = true;
	
	/// @func option_list_add(text)
	option_list_add = function(_text) {
		var _new_option = (option_list_width == undefined) ? new TDS_Option(_text) : new TDS_Option(_text, option_list_width);
		_new_option.option_set_alignments(fa_top, fa_left); // the options themselves always have top left alignment
		_new_option.option_set_alignments_text(option_list_text_align_v, option_list_text_align_h)
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
		
		// Note that we don't change the alignment of the options themselves. They are always top/left
	}
	
	/// @func option_list_set_alignments_options(vertical, horizontal)
	option_list_set_alignments_options = function(_v, _h) {
		option_list_options_align_v = _v;
		option_list_options_align_h = _h;
	}
	
	/// @func option_list_set_alignments_text(vertical, horizontal)
	option_list_set_alignments_text = function(_v, _h) {
		option_list_text_align_v = _v;
		option_list_text_align_h = _h;
		for (var i = 0; i < array_length(options); i++) {
			options[i].option_set_alignments_text(_v, _h);
		}
	}
	
	/// @func option_list_get_xy_of_option(list_x, list_y, option_index)
	option_list_get_xy_of_option = function(_x, _y, _index) {
		
		// placing function values in variables for optimization
		var _list_width = option_list_get_width(); 
		var _list_height = option_list_get_height();
		
		// assume top
		if (option_list_align_v == fa_center) _y -= _list_height / 2;
		if (option_list_align_v == fa_bottom) _y -= _list_height;
		
		// assume left
		if (option_list_align_h == fa_center) _x -= _list_width / 2;
		if (option_list_align_h == fa_right) _x -= _list_width;
		
		var _draw_y = _y;
		var _draw_x = _x;
		
		/* We will always draw options with a top left alignment. The text inside
		the options can have different alignments, and the list itself can have
		different alignments. */
		
		if (option_list_display == 0) {
			for (var i = 0; i < array_length(options); i++) {
				var _option = options[i];
				
				/* Recall that our options can have different widths, so we have to set
				_draw_x to the correct position depending on its width if the alignment
				isn't "left". */
				_draw_x = _x;
				if (option_list_options_align_h == fa_center) _draw_x += (_list_width - _option.option_get_width()) / 2;
				if (option_list_options_align_h == fa_right) _draw_x += (_list_width - _option.option_get_width());
				
				// return values if this is the correct index
				if (_index == i) return { x: _draw_x, y: _draw_y };
				
				_draw_y += _option.option_get_height();
				_draw_y += option_list_spacer;
			}
		}
		
		if (option_list_display == 1) {
			for (var i = 0; i < array_length(options); i++) {
				var _option = options[i];
				
				/* Our options will also likely have different heights, so we have to
				apply the same logic for horizontal display here, but for the _draw_y
				position for all alignments that aren't "top". */
				_draw_y = _y;
				if (option_list_options_align_v == fa_center) _draw_y += (_list_height - _option.option_get_height()) / 2;
				if (option_list_options_align_v == fa_bottom) _draw_y += (_list_height - _option.option_get_height());
				
				if (_index == i) return { x: _draw_x, y: _draw_y };
				
				_draw_x += _option.option_get_width();
				_draw_x += option_list_spacer;
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
