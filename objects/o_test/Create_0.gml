/// @description Insert description here
// You can write your code in this editor

test_list = new TDS_Option_List(360);
test_list.option_list_spacer = 40;
test_list.option_list_set_alignments(fa_top, fa_left);
test_list.option_list_display = 1;
test_list.option_list_set_alignments_options(fa_center, fa_center);

test_list.option_list_add("Purchase groceries.");
test_list.option_list_add("<red pulse>Beat<> next level in Super Mario.");
test_list.option_list_add("Practice the difficult section of your piano sonata.");

test_list.option_list_set_alignments_text(fa_top, fa_center);

portrait = new TDS_Portrait(s_character);
portrait.portrait_scale = 5;
portrait.portrait_set_index(2);
portrait.portrait_set_alignments(fa_bottom, fa_right);

chirping = jtt_create_box_typing(300, 300, "I'm just here to test out some typing effects.", "rise fade");
