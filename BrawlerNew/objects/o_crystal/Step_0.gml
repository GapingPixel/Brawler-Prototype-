/// @description Insert description here
// You can write your code in this editor

depth = o_player.depth+1;


image_index = round(o_player.stamina);

if alarm_get(0) <= 0 {
	image_alpha = .3;
} else {
	image_alpha = 1;
}

image_angle += 1.5;

x= o_player.x;

y = o_player.y-26;