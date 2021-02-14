/// @description Insert description here
// You can write your code in this editor

scene = new TDS_Scene(800, 600);

/// @func character_1(text, *portrait_index, *options)
function character_1(_text) constructor {
	text = _text;
	portrait_index = (argument_count > 1) ? argument[1] : undefined;
	options = (argument_count > 2) ? argument[2] : [];
	
	portrait = s_character;
	default_effects = "font:f_jtt_default chirp:snd_chirp2";
}

/// @func character_2(text, *portrait_index, *options)
function character_2(_text) constructor {
	text = _text;
	portrait_index = (argument_count > 1) ? argument[1] : undefined;
	options = (argument_count > 2) ? argument[2] : [];
	
	portrait = s_character2;
	default_effects = "font:f_handwriting chirp:snd_textbox_default";
}

//tds_box_set_data(text, portrait_index, portrait, default_effects, options)

with (scene.tds_scene_data) {
	add(new other.character_1("Hello there!", 0));
	add(new other.character_1("I'm the intro guy.", 1));
	add(new other.character_1("Which option would you prefer?", 0, ["Good", "Bad"]), function() {
		add(new other.character_1("I'm glad you chose the good.", 0));
		add(new other.character_1("The bad is pretty pad", 2));
	}, function() {
		add(new other.character_2("Oh yeah, I'm the bad.", 2));
		add(new other.character_2("I'm glad you're not scared of a little danger.", 0));
	});
	add(new other.character_1("Talk to you later!", 0));
	add(new other.character_2("Yeah, goodbye!", 1));
}

scene.tds_scene_advance();