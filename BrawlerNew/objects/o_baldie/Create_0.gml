/// @description Insert description here
// You can write your code in this editor
enum ENEMY_STATE {
	Idle,
	DOWNED, 
	GRABBED,
	GROGGY,
	FOLLOW,
	ATTACK, 
	Hit, 
	BALDIE_KICK, 
	BALDIE_THROWED, 
	BALDIE_DEATH, 
	BALDIE_FLEE, 
}



punch_spr = false;
state = ENEMY_STATE.Idle;

hp = 50;

flee_dir = noone;

mask_index = s_baldie_idle;

/*

//image_speed = 1;