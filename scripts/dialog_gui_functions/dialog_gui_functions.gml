// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function create_button(x, y, text){
	var result = instance_create_layer(x, y, 1, o_gui_button);
	result.text = text;
	result.label = jtt_create_label_gui(x, y, text);
	result.label.layer = result.layer - 1;
	return result;
}
