view_enabled = true;
view_visible[0] = true;
window_set_size(1280, 720);
display_set_gui_size(1280, 720);
surface_resize(application_surface, 1280, 720);

var _x = display_get_gui_width() / 2;
var _y = display_get_gui_height() - display_get_gui_height() / 16;
var _width = display_get_gui_width() / 2;
var _height = display_get_gui_height() / 3;

global.JTT_DEBUGGING = false;
global.JTT_DEFAULT_TYPING_CHIRP = snd_textbox_default;
textbox = jtt_create_box_typing_gui(_x, _y, _width, _height);
textbox.set_alignments(fa_bottom, fa_center, fa_top, fa_left);

choices = [];
choice_selected = -1; // for informing the system something was chosen
choice_highlighted = -1; // for selecting choices with kb/gp

mouse = [device_mouse_x_to_gui(0), device_mouse_y_to_gui(0)];
mouse_prev = mouse;

mouse_using = false;
mouse_using_prev = false;

dialog_tree = new game_tree();

// this function MUST be called after populating the tree to setup the dialog correctly
/// @desc Populate gui with data from current tree state
dialog_set_data = function() {
	var data = dialog_tree.tree_get_data();
	var _choices = [];
	
	/*
	To make life easier, data for steps in dialog can be one of two things: A string, or an
	array of strings. If the data is just a string, there will be no choices, and the
	textbox will be populated with the given string. If data is an array of strings. The 
	textbox will be populated with string at index 0, and the remaining entries will be
	choices for the textbox.
	*/
	
	if (is_string(data)) {
		dialog_set_text(data);
	}
	
	if (is_array(data)) {
		dialog_set_text(data[0]);
		// branch choices are all remaining options
		for (var i = 1; i < array_length(data); i++) {
			array_push(_choices, data[i]);
		}
	}
	
	dialog_set_choices(_choices);
}

/// @func dialog_set_text(new_text)
dialog_set_text = function(new_text) {
	textbox.set_text(new_text);
	textbox.advance();
}

/// @func dialog_set_choices(choices_array)
dialog_set_choices = function(_c) {
	// clear old buttons
	for (var i = 0; i < array_length(choices); i++) {
		instance_destroy(choices[i]);
	}
	choices = array_create(array_length(_c));
	var button_x = 100;
	var button_y = 100
	for (var i = 0; i < array_length(_c); i++) {
		choices[i] = create_button(button_x, button_y, _c[i]);
		choices[i].set_active(false);
		button_y += (choices[i].label.textbox_height + 1);
	}
}

/*
with (dialog_tree) {
	add("A");
	add("B");
	add(["C", "D", "Q"], function() {
		add("D");
		add("E");
		add(["F", "G", "J"], function() {
			add(["G", "H", "I"], function() {
				add("H");
			}, function() {
				add("I");
			});
		}, function() {
			add("J");
			add(["K", "L", "N"], function() {
				add("L");
				add("M");
			}, function() {
				add("N");
			});
			add("O");
		});
		add("P");
	}, function() {
		add("Q");
		add("R");
		add("S");
	});
	add("T");
	add("U");
}
*/

with (dialog_tree) {
	add("Greetings player!");
	add("I am your friendly example dialog tree.");
	add(["What would you like to know?", "How do you work?", "Who made you?"], function() {
		add("Why, it's quite simple. You add dialog to me with the \"add\" function.");
		add("Different branches can be created by making functions right in the tree!");
		add(["Isn't that neat?", "Don't you have a gui?", "I guess..."], function() {
			add("...");
			add(["ISN'T THAT NEAT???", "yes..."], function() {
				add("Of course it is!");
			});
		}, function() {
			add("If you're not impressed, you're welcome to go learn some OTHER system :D");
			add("And I'll take my intuitive self to some OTHER developer who will APPRECIATE me.");
		})
	}, function() {
		add("0rd1n4ry did. I was created in the hopes of making a beautiful visual novel.");
		add("Thank you for asking!");
	});
	add("Good day to you player!");
}

dialog_set_data();
