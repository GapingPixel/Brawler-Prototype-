/// @description Insert description here
// You can write your code in this editor
var _basex = 48;
draw_sprite(s_player1_thumbtail,0,_basex ,0);
draw_sprite(s_player1_healthbar,0,_basex +24,0);
draw_sprite(s_player1_score,0,_basex +32,13);

if instance_exists(o_player) {
	for (var i = 0; i < o_player.hp; i+=1) {
		draw_sprite(s_player1_hp_segment,0,_basex+25+(i*6),1);	
	}
}/*
var i = 0;

draw_sprite(s_player1_hp_segment,0,_basex+25+(i*6),1);	

i = 1;

draw_sprite(s_player1_hp_segment,0,_basex+25+(i*6),1);	


i = 2;

draw_sprite(s_player1_hp_segment,0,_basex+25+(i*6),1);	