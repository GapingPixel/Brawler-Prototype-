// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function animation_get_frame(frame){
	var _frame = argument0;
	var _speed = global.one_second/sprite_get_speed(sprite_index);
	return (image_index >= _frame+1 - image_speed/_speed) and (image_index < _frame+1);
}