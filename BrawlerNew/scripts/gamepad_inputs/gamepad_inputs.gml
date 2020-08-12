function gamepad_inputs(argument0) {
	/*left = gamepad_axis_value(argument0,gp_axislh) < 0;
	right = gamepad_axis_value(argument0,gp_axislh) > 0;*/
	haxis = gamepad_axis_value(argument0, gp_axislh); 
	vaxis = gamepad_axis_value(argument0, gp_axislv);
	run = gamepad_button_check(argument0, gp_stickl);
	
	up = gamepad_axis_value(argument0,gp_axislv) < 0;
	down = gamepad_axis_value(argument0,gp_axislv) > 0;

	cross = gamepad_button_check_pressed(argument0,gp_face1);
	circle = gamepad_button_check_pressed(argument0,gp_face2);
	square = gamepad_button_check_pressed(argument0,gp_face3);
	triangle = gamepad_button_check_pressed(argument0,gp_face4);
}

function keyboard_inputs(argument0) {
	left = keyboard_check_pressed(ord("A"));
	right = keyboard_check_pressed(ord("D"));
	up = keyboard_check_pressed(ord("W"));
	down = keyboard_check_pressed(ord("S"));

	cross = keyboard_check_pressed(vk_space);
	circle = gamepad_button_check_pressed(argument0,gp_face2);
	square = mouse_check_button_pressed(mb_right);
	triangle = gamepad_button_check_pressed(argument0,gp_face4);


}

