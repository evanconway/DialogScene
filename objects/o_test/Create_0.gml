/// @description Insert description here
// You can write your code in this editor

test_list = new TDS_Option_List(400);
test_list.option_list_spacer = 40;
test_list.option_list_set_alignments(fa_center, fa_center);

test_list.option_list_add("Go to the store and purchase vegetables.");
test_list.option_list_add("Play video games. Try to beat the next level.");
test_list.option_list_add("Practice the difficult section of your piano sonata.");


portrait = new TDS_Portrait(s_character);
portrait.portrait_scale = 5;
portrait.portrait_set_index(2);
portrait.portrait_set_alignments(fa_bottom, fa_right);