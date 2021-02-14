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


colors = jtt_create_box(400, 500, 
	"With <red>color<> tags, <green>text<> can <ltblue>be<> any <yellow>color<>." +
	"It can even be <252,15,192>an rgb code<>. But by far the coolest color is " +
	"<chromatic>chromatic<>!"
	);

combined = jtt_create_box_typing(400, 500,
	"There are also <float>moving<> and <pulse:0.5,0.1>alpha<> effects, which can be " +
	"<shake yellow blink:1,0.2>combined<> with colors. And all these effects can "+
	"be <chromatic wave>typed out!<>"
	);

typing = jtt_create_box_typing(400, 500,
	"These <wave pink>effects<> can even be <wshake>typed<> with special " +
	"<green float>typing effects<> that change how the text <chromatic wave>types out<>."
	, "fade fall");