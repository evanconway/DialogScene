
scene = new TDS_Scene(800, 600);

circle = new TDS_Character(s_character, "font:f_jtt_default chirp:snd_chirp2");
square = new TDS_Character(s_character2, "font:f_handwriting chirp:snd_textbox_default");
	
scene.tds_add(circle, "Hello there!", 0);
scene.tds_add(square, "This is the intro", 1);
scene.tds_add(circle, "Which option would you prefer?", 0, ["Good", "Bad"], function() {
	scene.tds_add(circle, "I'm glad you chose the good.", 0);
	scene.tds_add(circle, "The bad is pretty bad", 2);
}, function() {
	scene.tds_add(square, "Oh yeah, I'm the bad.", 2);
	scene.tds_add(square, "I'm glad you're not scared of a little danger.", 0);
	scene.tds_add(square, "What's the baddest thing you've ever done?", 2, ["skipped class", "stole a chocolate milk", "I don't say please at the dinner table"], function() {
		scene.tds_add(square, "School's pretty lame, I can understand that.", 0);
	}, function() {
		scene.tds_add(square, "Wow dude what's wrong with you?", 2);
		scene.tds_add(square, "The regular milk not good enough?", 1);
		scene.tds_add(square, "What's your favorite flavor?", 0, ["Chocolate", "Vanilla", "Strawberry"], function() {
			scene.tds_add(square, "Truly you are traditional to the bone.");
		}, function() {
			scene.tds_add(square, "Safe, but not without flavor. I like that.", 0);
		}, function() {
			scene.tds_add(square, "I'm shocked! I would've never guessed.", 1);
		});
	}, function() {
		scene.tds_add(square, "You should be ashamed of yourself.", 1);
		scene.tds_add(square, "But, I admire you confidence.", 0);
	});
});
scene.tds_add(circle, "Talk to you later!", 0);
scene.tds_add(square, "Yeah, goodbye!", 1);

scene.tds_scene_advance();
