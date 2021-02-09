
/// @func TDS_Portrait(*sprite)
function TDS_Portrait() constructor {
	
	/* Note that we don't bother checking if the given value is a sprite. 
	It's actually hard to confirm a value in Game Maker since everything
	is referenced with integer values. */
	portrait_sprite = (argument_count > 0) ? argument[0] : undefined;
	portrait_index = 0;
	portrait_align_v = fa_top;
	portrait_align_h = fa_left;
	portrait_scale = 1;
	portrait_debugging = true;
	
	/// @func portrait_set_sprite(sprite)
	portrait_set_sprite = function(_sprite) {
		portrait_sprite = _sprite;
		portrait_index = 0;
	}
	
	/// @func portrait_set_index(integer)
	portrait_set_index = function(_index) {
		portrait_index = floor(_index);
	}
	
	/// @func portrait_set_alignments(alignment_v, alignment_h)
	portrait_set_alignments = function(_v, _h) {
		if (_v == fa_top || _v == fa_bottom || _v == fa_center) portrait_align_v = _v;
		else show_error("TDS error. Improper portrait alignment value.", true);
		
		if (_h == fa_left || _h == fa_right || _h == fa_center) portrait_align_h = _h;
		else show_error("TDS error. Improper portrait alignment value.", true);
	}
	
	/// @func portrait_get_width()
	portrait_get_width = function() {
		return sprite_get_width(portrait_sprite) * portrait_scale;
	}
	
	/// @func portrait_get_height()
	portrait_get_height = function() {
		return sprite_get_height(portrait_sprite) * portrait_scale;
	}
	
	/// @func portrait_draw(x, y, *alpha)
	portrait_draw = function(_x, _y) {
		var _debug_xy = [_x, _y];
		
		var _alpha = (argument_count > 0) ? argument[0] : 1;
		if (portrait_align_v == fa_bottom) _y -= portrait_get_height();
		if (portrait_align_v == fa_center) _y -= portrait_get_height() / 2;
		if (portrait_align_h == fa_right) _x -= portrait_get_width();
		if (portrait_align_h == fa_center) _x -= portrait_get_width() / 2;
		draw_sprite_ext(portrait_sprite, portrait_index, _x, _y, portrait_scale, portrait_scale, 0, -1, _alpha);
		
		if (portrait_debugging) {
			draw_set_color(c_gray);
			draw_set_alpha(1);
			draw_rectangle(_x, _y, _x + portrait_get_width(), _y + portrait_get_height(), true);
			draw_set_color(c_fuchsia);
			draw_point(_debug_xy[0], _debug_xy[1]);
		}
	}
}
