// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function TDS_Scene(box_width, box_height) constructor {
	tds_box = new TDS_Box(box_width, box_height);
	tds_scene_data = new Game_Tree();
	
	tds_scene_begun = false;
	
	/// @func tds_add(character, text, *portrait_index, *options, *branches)
	tds_add = function(_character, _text) {
		
		var _original_caller = other;
		
		var _data = {
			character: _character,
			text: _text,
			portrait_index: ((argument_count > 2) ? argument[2] : 0),
			options: ((argument_count > 3) ? argument[3] : [])
		};
		
		/* This is so ugly, but I'm not sure how else to do it. We've seen FriendlyCosmonaut do
		something like this in their code. */
		if (argument_count <= 3) tds_scene_data.add(_data, _original_caller);
		// observe: since options are linked to branches, there should never be a call with 4 arguments
		if (argument_count == 5) tds_scene_data.add(_data, _original_caller, argument[4]);
		if (argument_count == 6) tds_scene_data.add(_data, _original_caller, argument[4], argument[5]);
		if (argument_count == 7) tds_scene_data.add(_data, _original_caller, argument[4], argument[5], argument[6]);
		if (argument_count == 8) tds_scene_data.add(_data, _original_caller, argument[4], argument[5], argument[6], argument[7]);
		if (argument_count == 9) tds_scene_data.add(_data, _original_caller, argument[4], argument[5], argument[6], argument[7], argument[8]);
		if (argument_count == 10) tds_scene_data.add(_data, _original_caller, argument[4], argument[5], argument[6], argument[7], argument[8], argument[9]);
		if (argument_count == 11) tds_scene_data.add(_data, _original_caller, argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10]);
		if (argument_count == 12) tds_scene_data.add(_data, _original_caller, argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11]);
	}
	
	/// @func tds_scene_advance(*target_index)
	tds_scene_advance = function() {
		if (!tds_scene_begun) {
			tds_scene_begun = true;
			var _data = tds_scene_data.tree_get_data();
			tds_box.tds_box_set_data(_data.text, _data.portrait_index, _data.character.portrait, _data.character.default_effects, _data.options);
			return; // don't complete function if we haven't "started the scene".
		}
		
		var _index = (argument_count > 0) ? argument[0] : 0;
		
		var _textbox = tds_box.tds_box_jtt;
		if (_textbox == undefined) return;
		
		if (_textbox.get_typing_all_finished()) {
			if (!tds_scene_data.tree_at_end()) {
				tds_scene_data.tree_advance(_index);
				var _data = tds_scene_data.tree_get_data();
				tds_box.tds_box_set_data(_data.text, _data.portrait_index, _data.character.portrait, _data.character.default_effects, _data.options);
			}
		} else {
			_textbox.advance();
		}
	}
	
	/// @func tds_scene_get_option_at_xy(box_x, box_y, x, y)
	tds_scene_get_option_at_xy = function(_box_x, _box_y, _x, _y) {
		return tds_box.tds_box_get_option_at_xy(_box_x, _box_y, _x, _y);
	}
	
	/// @func tds_scene_option_set_highlight(option_index)
	tds_scene_option_set_highlight = function(_index) {
		tds_box.tds_box_option_set_highlight(_index);
	}
	
	/// @func tds_scene_draw(x, y, *alpha)
	tds_scene_draw = function(_x, _y) {
		var _alpha = (argument_count > 2) ? argument[2] : 1;
		tds_box.tds_box_draw(_x, _y, _alpha);
	}
	
	/// @func tds_scene_finished()
	tds_scene_finished = function() {
		return (tds_box.tds_box_jtt.get_typing_all_finished() && tds_scene_data.tree_at_end())
	}
}
