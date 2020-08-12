/// @description Insert description here
// You can write your code in this editor
keyboard_set_map(ord("D"), vk_right);
keyboard_set_map(ord("A"), vk_left);

global.one_second = 60;
global.pad = 1; 
global.gamepad_active = false;
	

gamepad_inputs(global.pad);
