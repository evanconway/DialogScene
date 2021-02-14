// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function TDS_Scene(box_width, box_height) constructor {
	tds_box = new TDS_Box(box_width, box_height);
	tds_scene_data = new Game_Tree();
	
	tds_scene_begun = false;
	
	/// @func tds_scene_advance(*target_index)
	tds_scene_advance = function() {
		if (!tds_scene_begun) {
			tds_scene_begun = true;
			var _data = tds_scene_data.tree_get_data();
			tds_box.tds_box_set_data(_data.text, _data.portrait_index, _data.portrait, _data.default_effects, _data.options);
		}
		
		var _index = (argument_count > 0) ? argument[0] : 0;
		
		var _textbox = tds_box.tds_box_jtt;
		if (_textbox == undefined) return;
		
		if (_textbox.get_typing_all_finished()) {
			tds_scene_data.tree_advance(_index);
			var _data = tds_scene_data.tree_get_data();
			tds_box.tds_box_set_data(_data.text, _data.portrait_index, _data.portrait, _data.default_effects, _data.options);
		} else {
			_textbox.advance();
		}
	}
	
	/// @func tds_scene_get_option_at_xy(box_x, box_y, x, y)
	tds_scene_get_option_at_xy = function(_box_x, _box_y, _x, _y) {
		return tds_box.tds_box_get_option_at_xy(_box_x, _box_y, _x, _y);
	}
	
	/// @func tds_scene_draw(x, y, *alpha)
	tds_scene_draw = function(_x, _y) {
		var _alpha = (argument_count > 2) ? argument[2] : 1;
		tds_box.tds_box_draw(_x, _y, _alpha);
	}
}
