/// @description Insert description here
// You can write your code in this editor
#macro IDLE 0
#macro JUMP 1
#macro RUN 2
#macro BASIC 3
#macro UPPERCUT 4
#macro ELBOW_DROP 5
#macro KICK 20
#macro ROUNDHOUSE 7
#macro STOMP 8
#macro GRABBED_ENEMY 9
#macro GRAB_FAIL 10
#macro GRABBED_PUNCH_HEAD 11
#macro GRABBED_SUPLEX 12
#macro GRABBED_KNEE 13
#macro GRABBED_BAT 14
#macro GRABBED_TRASHCAN 15
#macro GRABBED_BOTTLE 16
#macro GRABBED_PILEDRIVER 19
#macro STUNNED 17
#macro KNOCK_DOWN 18
#macro HIT 21
#macro DEAD 22
#macro RUN_CLOTHESLINE 23
#macro RUN_MID_KICK 24
//Colls
#macro h 0
#macro v 1

hp = 10;

state = IDLE;
spd = 1;
len = 0;
face = 0;
stamina = 9;
hspd = 0;
vspd = 0;

face = 0;

grav = .5;

jump_spd = 4;


jump_p = 0;

jump_height = 35;
jump_pos = 0;

oldy = noone;

punch_sprite = s_player_basic;
kick_sprite = s_player_kick_2;

grabbed_enemy = noone;

punch_count = 0;
kick_count = 0;

stunned_hit_count = 0;
stunned_count = 0;

holding_enemy_death = false;

yplus = 0;

mask_index = s_player_idle;

last_hspd = 0;
last_vspd = 0;

#region Functions






#endregion