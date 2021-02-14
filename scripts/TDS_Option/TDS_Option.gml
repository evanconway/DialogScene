/// @desc Return tds_option struct
/// @func TDS_Option(text, *width)
function TDS_Option(_text) constructor {
	option_width_init = (argument_count > 1) ? argument[1] : undefined;
	
	option_text = _text;
	option_jtt = jtt_create_box(option_width_init, undefined, _text);
	option_width = option_jtt.textbox_width;
	option_height = option_jtt.textbox_height;
	
	option_highlight = false;
	option_highlight_text_effect = "yellow pulse:1,0.2";
	option_highlight_color = c_white;
	option_highlight_alpha = 0.1;
	
	// default alignment for options is top left
	option_jtt.set_alignments(fa_top, fa_left, fa_top, fa_left);
	option_alignment_v = fa_top;
	option_alignment_h = fa_left;
	
	option_debugging = true;
	
	// We're leaving alignment for options simple until further notice.
	/// @func option_set_alignments(alignment_v, alignment_h)
	option_set_alignments = function(alignment_v, alignment_h) {
		option_alignment_v = alignment_v;
		option_alignment_h = alignment_h;
		option_jtt.set_alignments(alignment_v, alignment_h, alignment_v, alignment_h);
	}
	
	/// @desc Set alignments of text in option box. 
	/// @func option_set_alignments_text(vertical, horizontal)
	option_set_alignments_text = function(_v, _h) {
		option_jtt.set_alignments(option_alignment_v, option_alignment_h, _v, _h);
	}
	
	/// @func option_get_width()
	option_get_width = function() {
		return option_width;
	}
	
	/// @func option_get_height()
	option_get_height = function() {
		return option_height;
	}
	
	/// @desc Returns true if the given point x/y are inside of option at given x/y.
	/// @func option_point_on(option_x, option_y, point_x, point_y)
	option_point_on = function(option_x, option_y, point_x, point_y) {
		var x_on = false;
		if (option_jtt.alignment_box_h == fa_left) {
			if (point_x >= option_x && point_x <= option_x + option_width) x_on = true;
		}
		if (option_jtt.alignment_box_h == fa_right) {
			if (point_x <= option_x && point_x >= option_x - option_width) x_on = true;
		}
		if (option_jtt.alignment_box_h == fa_center) {
			if (point_x >= option_x - option_width/2 && point_x <= option_x + option_width/2) x_on = true;
		}
		
		var y_on = false;
		if (option_jtt.alignment_box_v = fa_top) {
			if (point_y >= option_y && point_y <= option_y + option_height) y_on = true;
		}
		if (option_jtt.alignment_box_v == fa_bottom) {
			if (point_y <= option_y && point_y >= option_y - option_height) y_on = true;
		}
		if (option_jtt.alignment_box_v == fa_center) {
			if (point_y >= option_y - option_height/2 && point_y <= option_y + option_height/2) y_on = true;
		}
		
		return (x_on && y_on);
	}
	
	/// @func option_set_highlight(boolean)
	option_set_highlight = function(_bool) {
		var _text_align_v = option_jtt.alignment_text_v;
		var _text_align_h = option_jtt.alignment_text_h;
		if (_bool && !option_highlight) {
			option_highlight = true;
			option_jtt = jtt_create_box(option_width_init, undefined, option_text, option_highlight_text_effect);
		}
		if (!_bool && option_highlight) {
			option_highlight = false;
			option_jtt = jtt_create_box(option_width_init, undefined, option_text);
		}
		option_width = option_jtt.textbox_width;
		option_height = option_jtt.textbox_height;
		option_jtt.set_text_align_v(_text_align_v);
		option_jtt.set_text_align_h(_text_align_h);
	}
	
	/// @func option_set_highlight_effect(text, color, alpha)
	option_set_highlight_effect = function(_text, _color, _alpha) {
		if (_text != undefined) option_highlight_text_effect = _text;
		if (_color != undefined) option_highlight_color = _color;
		if (_alpha != undefined) option_highlight_alpha = _alpha;
	}
	
	/// @func option_draw(x, y, *alpha)
	option_draw = function(_x, _y) {
		
		var _alpha = (argument_count > 2) ? argument[2] : 1;
		
		var _x_start = 0;
		var _y_start = 0;
		var _x_end = 0;
		var _y_end = 0;
		
		// horizontal
		if (option_alignment_h == fa_left) {
			_x_start = _x
			_x_end = _x + option_width;
		}
		if (option_alignment_h == fa_right) {
			_x_start = _x - option_width;
			_x_end = _x;
		}
		if (option_alignment_h == fa_center) {
			_x_start = _x - option_width/2;
			_x_end = _x + option_width/2;
		}
			
		// vertical
		if (option_alignment_h == fa_top) {
			_y_start = _y
			_y_end = _y + option_height;
		}
		if (option_alignment_h == fa_bottom) {
			_y_start = _y - option_height;
			_y_end = _y;
		}
		if (option_alignment_h == fa_center) {
			_y_start = _y - option_height/2;
			_y_end = _y + option_height/2;
		}
		
		if (option_highlight) {
			draw_set_alpha(option_highlight_alpha * _alpha);
			draw_set_color(option_highlight_color);
			draw_rectangle(_x_start, _y_start, _x_end, _y_end, false);
		}
		
		option_jtt.draw(_x, _y, _alpha);
		
		if (option_debugging) {
			draw_set_color(c_grey);
			draw_set_alpha(1);
			draw_rectangle(_x_start, _y_start, _x_end, _y_end, true);
			draw_set_color(c_fuchsia);
			draw_circle(_x, _y, 2, false);
		}
	}
}
