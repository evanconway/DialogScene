/// @description Insert description here
// You can write your code in this editor

test_list = new TDS_Option_List(400);
test_list.option_spacer = 30;

test_list.add_option("Go to the store and purchase vegetables.");
test_list.add_option("Play video games. Try to beat the next level.");
test_list.add_option("Practice the difficult section of your piano sonata.");

portrait = new TDS_Portrait(s_character);
portrait.portrait_scale = 5;
portrait.portrait_set_index(2);
