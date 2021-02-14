// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function TDS_Box(width, height) constructor {
	
	// note that when drawing the box, the border and padding are INCLUDED in the width.
	tds_box_width = width;
	tds_box_height = height;
	
	tds_box_alignment_v = fa_top;
	tds_box_alignment_h = fa_left;
	
	tds_box_text = undefined; // string assigned to jtt textbox
	tds_box_portrait = undefined; // sprite of character portrait
	tds_box_portrait_index = 0; // index of character sprite
	
	tds_box_padding = ceil(tds_box_width / 50); // distance from edge of box all elements will be
	
	tds_box_color = c_dkgray;
	tds_box_border_color = c_white;
	tds_box_border_width = ceil(tds_box_width / 50);
	
	tds_box_jtt = undefined; // this is defined in set_data
	tds_box_options = undefined; // this is defined in set_data
	tds_box_option_highlighted = 0; // index of option highlighted
	
	/* By default, portraits will be their natural width and height. But we
	can force them to be a different width and height. If the width is larger
	than the given maximum, then the portrait will be scaled down to fit. There
	is no maximum height variable, because we will use the height of the box as
	it's maximum. */
	tds_box_portrait_max_width = floor((tds_box_width - (tds_box_padding + tds_box_border_width) * 2) / 3); // default is half of box width
	
	tds_box_portrait_scaletomax = true; // if true, portraits are scaled to maximum possible values
	
	
	/* Changing portrait index without changing portrait will leave the current portrait as is. Undefined must be
	manually passed into the portrait parameter to remove the portrait. */
	/// @func tds_box_set_data(text, *portrait_index, *portrait, *default_effects, *options)
	tds_box_set_data = function(_text) {
		
		tds_box_portrait_index = (argument_count > 1) ? argument[1] : 0;
		tds_box_portrait = (argument_count > 2) ? argument[2] : tds_box_portrait;
		var _effects = (argument_count > 3) ? argument[3] : undefined;
		
		var _pwidth = tds_box_get_portrait_width() + tds_box_padding;
		var _textwidth = tds_box_width - _pwidth - tds_box_border_width * 2 - tds_box_padding * 2;
		
		tds_box_text = _text;
		if (_text != undefined) tds_box_jtt = jtt_create_box_typing(_textwidth, undefined, _text, _effects);
		
		if (argument_count > 4) {
			var _options = new TDS_Option_List(_textwidth);
			for (var i = 0; i < array_length(argument[4]); i++) {
				_options.option_list_add(array_get(argument[4], i));
			}
			tds_box_options = _options;
		} else {
			tds_box_options = undefined;
		}
	}
	
	/// @func tds_box_set_alignments(vertical, horizontal)
	tds_box_set_alignments = function(_v, _h) {
		tds_box_alignment_v = _v;
		tds_box_alignment_h = _h;
	}
	
	/// @func tds_box_get_portrait_scale()
	tds_box_get_portrait_scale = function() {
		if (tds_box_portrait == undefined) return 0;
		var _pwidth = sprite_get_width(tds_box_portrait);
		var _pheight = sprite_get_height(tds_box_portrait);
		var _pscale = tds_box_portrait_scaletomax ? tds_box_portrait_max_width / _pwidth : 1;
		if (_pwidth * _pscale > tds_box_portrait_max_width) _pscale = tds_box_portrait_max_width / _pwidth;
		var _height_max = tds_box_height - tds_box_padding * 2 - tds_box_border_width * 2;
		if (_pheight * _pscale > _height_max) _pscale = _height_max / _pheight;
		return _pscale;
	}
	
	/// @func tds_box_get_portrait_width()
	tds_box_get_portrait_width = function() {
		if (tds_box_portrait == undefined) return 0;
		return tds_box_get_portrait_scale() * sprite_get_width(tds_box_portrait);
	}
	
	/// @func tds_box_get_portrait_height()
	tds_box_get_portrait_height = function() {
		if (tds_box_portrait == undefined) return 0;
		return tds_box_get_portrait_scale() * sprite_get_height(tds_box_portrait);
	}
	
	/// @func tds_box_get_option_at_xy(box_x, box_y, x, y)
	tds_box_get_option_at_xy = function(_box_x, _box_y, _x, _y) {
		if (tds_box_options == undefined) return -1;
		
		// recall that the options list is offset by the portrait and text
		_box_x += (tds_box_border_width + tds_box_padding);
		if (tds_box_portrait != undefined) _box_x += (tds_box_get_portrait_width() + tds_box_padding);
		_box_y += (tds_box_border_width + tds_box_padding);
		if (tds_box_jtt != undefined) _box_y += (tds_box_jtt.textbox_height + tds_box_padding);
		
		// modify for alignments
		// assume left aligned
		if (tds_box_alignment_h == fa_center) _box_x -= floor(tds_box_width / 2);
		if (tds_box_alignment_h == fa_right) _box_x -= tds_box_width;
		
		// assume top aligned
		if (tds_box_alignment_v == fa_center) _box_y -= floor(tds_box_height / 2);
		if (tds_box_alignment_v == fa_bottom) _box_y -= tds_box_height;
		
		return tds_box_options.option_list_get_option_at_xy(_box_x, _box_y, _x, _y);
	}
	
	/* The user should rarely need to call this. The highlight should almost always be set with the
	other functions. This is mainly for use in the draw method. */
	/// @func tds_box_option_set_highlight(index)
	tds_box_option_set_highlight = function(_index) {
		if (tds_box_options != undefined) {
			tds_box_options.option_list_set_highlight(_index);
			tds_box_option_highlighted = _index;
		}
	}
	
	/// @func tds_box_option_set_highlight_at_xy(box_x, box_y, x, y)
	tds_box_option_set_highlight_at_xy = function(_box_x, _box_y, _x, _y) {
		tds_box_option_highlighted = tds_box_get_option_at_xy(_box_x, _box_y, _x, _y);
	}
	
	/// @func tds_box_option_set_highlight_next()
	tds_box_option_set_highlight_next = function() {
		if (tds_box_options == undefined) return;
		if (tds_box_option_highlighted < 0 || tds_box_option_highlighted >= tds_box_options.option_list_get_number()) {
			tds_box_option_highlighted = 0;
		} else {
			tds_box_option_highlighted += 1;
			if (tds_box_option_highlighted >= tds_box_options.option_list_get_number()) {
				tds_box_option_highlighted = tds_box_options.option_list_get_number() - 1;
			}
		}
	}
	
	/// @func tds_box_option_set_highlight_prev()
	tds_box_option_set_highlight_prev = function() {
		if (tds_box_options == undefined) return;
		if (tds_box_option_highlighted < 0 || tds_box_option_highlighted >= tds_box_options.option_list_get_number()) {
			tds_box_option_highlighted = 0;
		} else {
			tds_box_option_highlighted -= 1;
			if (tds_box_option_highlighted < 0) {
				tds_box_option_highlighted = 0;
			}
		}
	}
	
	/// @func tds_box_draw(x, y, *alpha)
	tds_box_draw = function(_x, _y) {
		var _alpha = (argument_count > 0) ? argument[0] : 1;
		
		// assume left aligned
		if (tds_box_alignment_h == fa_center) _x -= floor(tds_box_width / 2);
		if (tds_box_alignment_h == fa_right) _x -= tds_box_width;
		
		// assume top aligned
		if (tds_box_alignment_v == fa_center) _y -= floor(tds_box_height / 2);
		if (tds_box_alignment_v == fa_bottom) _y -= tds_box_height;
		
		// box includes width of border
		draw_set_alpha(_alpha);
		draw_set_color(tds_box_border_color);
		draw_rectangle(_x, _y, _x + tds_box_width, _y + tds_box_height, false);
		
		// border width drawn, adjust x/y
		_x += tds_box_border_width;
		_y += tds_box_border_width;
		
		var _width = tds_box_width - tds_box_border_width * 2;
		var _height = tds_box_height - tds_box_border_width * 2;
		
		draw_set_color(tds_box_color);
		draw_rectangle(_x, _y, _x + _width, _y + _height, false);
		
		// inner box draw, adjust for padding
		_x += tds_box_padding;
		_y += tds_box_padding;
		
		_width -= tds_box_padding * 2;
		_height -= tds_box_padding * 2;
		
		// draw portrait
		if (tds_box_portrait != undefined) {
			var _pscale = tds_box_get_portrait_scale();
			draw_sprite_ext(tds_box_portrait, tds_box_portrait_index, _x, _y, _pscale, _pscale, 0, -1, _alpha);
		}
		
		// portrait drawn, adjust x/y
		_x += (tds_box_get_portrait_width() + tds_box_padding);
		
		if (tds_box_jtt != undefined) {
			tds_box_jtt.draw(_x, _y);
		}
		
		// text drawn, adjust x/y
		if (tds_box_jtt != undefined) {
			_y += tds_box_jtt.textbox_height;
			_y += tds_box_padding;
		}
		
		if (tds_box_options != undefined && tds_box_jtt != undefined && tds_box_jtt.get_typing_all_finished()) {
			tds_box_options.option_list_draw(_x, _y);
		}
		
		tds_box_option_set_highlight(tds_box_option_highlighted);
	}
}
