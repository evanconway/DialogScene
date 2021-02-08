/// @desc Return tds_option struct
/// @func TDS_Option(text, *width)
function TDS_Option(_text) constructor {
	var _width = (argument_count > 1) ? argument[1] : undefined;
	
	option_text = _text;
	jtt_text = jtt_create_box(_width, undefined, _text);
	option_width = jtt_text.textbox_width;
	option_height = jtt_text.textbox_height;
	option_highlight = false;
	option_highlight_text_effect = "yellow pulse:1,0.2";
	option_highlight_color = c_white;
	option_highlight_alpha = 0.1;
	
	// default alignment for options is top left
	jtt_text.set_alignments(fa_top, fa_left, fa_top, fa_left);
	option_alignment_v = fa_top;
	option_alignment_h = fa_left;
	
	// We're leaving alignment for options simple until further notice.
	/// @func option_set_alignments(alignment_v, alignment_h)
	option_set_alignments = function(alignment_v, alignment_h) {
		option_alignment_v = alignment_v;
		option_alignment_h = alignment_h;
		jtt_text.set_alignments(alignment_v, alignment_h, alignment_v, alignment_h);
	}
	
	/// @desc Returns true if the given point x/y are inside of option at given x/y.
	/// @func option_point_on(option_x, option_y, point_x, point_y)
	option_point_on = function(option_x, option_y, point_x, point_y) {
		var x_on = false;
		if (jtt_text.alignment_box_h == fa_left) {
			if (point_x >= option_x && point_x <= option_x + option_width) x_on = true;
		}
		if (jtt_text.alignment_box_h == fa_right) {
			if (point_x <= option_x && point_x >= option_x - option_width) x_on = true;
		}
		if (jtt_text.alignment_box_h == fa_center) {
			if (point_x >= option_x - option_width/2 && point_x <= option_x + option_width/2) x_on = true;
		}
		
		var y_on = false;
		if (jtt_text.alignment_box_v = fa_top) {
			if (point_y >= option_y && point_y <= option_y + option_height) y_on = true;
		}
		if (jtt_text.alignment_box_v == fa_bottom) {
			if (point_y <= option_y && point_y >= option_y - option_height) y_on = true;
		}
		if (jtt_text.alignment_box_v == fa_center) {
			if (point_y >= option_y - option_height/2 && point_y <= option_y + option_height/2) y_on = true;
		}
		
		return (x_on && y_on);
	}
	
	/// @func option_set_highlight(boolean)
	option_set_highlight = function(_bool) {
		if (_bool && !option_highlight) {
			option_highlight = true;
			jtt_text.set_text("<" + option_highlight_text_effect + ">" + option_text);
			jtt_text.advance();
		}
		if (!_bool && option_highlight) {
			option_highlight = false;
			jtt_text.set_text(option_text);
			jtt_text.advance();
		}
	}
	
	/// @func option_set_highlight_effect(text, color, alpha)
	option_set_highlight_effect = function(_text, _color, _alpha) {
		if (_text != undefined) option_highlight_text_effect = _text;
		if (_color != undefined) option_highlight_color = _color;
		if (_alpha != undefined) option_highlight_alpha = _alpha;
	}
	
	/// @func option_draw(x, y)
	option_draw = function(_x, _y) {
		if (option_highlight) {
			draw_set_alpha(option_highlight_alpha);
			draw_set_color(option_highlight_color);
			
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
			
			draw_rectangle(_x_start, _y_start, _x_end, _y_end, false);
		}
		jtt_text.draw(_x, _y);
	}
}
