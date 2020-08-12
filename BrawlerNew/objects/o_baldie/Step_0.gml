/// @description Insert description here
// You can write your code in this editor
depth = -y;

if !instance_exists(o_player) {
	image_speed = 0;
	sprite_index = s_baldie_idle;
	exit;
}

switch (state) {
	
	case ENEMY_STATE.Idle:
	image_speed = .1;
	sprite_index = s_baldie_idle;
	if distance_to_object(o_player) < 150 and alarm_get(0) <= 0 {
		state = ENEMY_STATE.FOLLOW;
	}
	
	if o_player.x < x {
		image_xscale = -1;
	} else {
		image_xscale = 1;
	}	
	break;
	
	
	case ENEMY_STATE.GROGGY:
	image_speed = .1;
	sprite_index = s_baldie_groggy;
	break;
	
	case ENEMY_STATE.DOWNED:
	image_speed = .5;
	sprite_index = s_baldie_downed;
	break;
	
	case ENEMY_STATE.GRABBED:
	image_speed = .2;
	break;
	
	case ENEMY_STATE.FOLLOW:
	image_speed = .5;
	sprite_index = s_baldie_run;
	if distance_to_object(o_player) >= 50 {
		sprite_index = s_baldie_run;
		mp_potential_step_object(o_player.x,o_player.y,1.5,o_solid);
	} else {
		sprite_index = s_baldie_walk;
		mp_potential_step_object(o_player.x,o_player.y,1,o_solid);
	}
	
	
	if distance_to_object(o_player) < 4 {
		if o_player.state == STUNNED {
			state = ENEMY_STATE.BALDIE_KICK;
		} else {
			state = ENEMY_STATE.ATTACK;
			sprite_index = s_baldie_punch_1;
		}
	}
	break;
	
	case ENEMY_STATE.ATTACK:
	image_speed = 1;
	if animation_get_frame(1) {
		var _base_dmg = 1;
		var _dmg = instance_create_depth(x+image_xscale*18,y-20,depth-20,class_dmg);
		_dmg.dmg = _base_dmg;
		_dmg.creator = ENEMY;
		_dmg.image_xscale = 1.5;
		_dmg.image_yscale = 1.5;
		
		with _dmg {
			if place_meeting(x,y,o_player) {
				o_player.stunned_hit_count++;
			}
		}	
	}
	break;
	
	case ENEMY_STATE.BALDIE_FLEE:
	image_speed = .3;
	sprite_index = s_baldie_walk;
	var _dir = flee_dir;
	
	if place_meeting(x+lengthdir_x(.7,_dir),y+lengthdir_y(.7,_dir),o_solid) {
		state = ENEMY_STATE.Idle;
		alarm_set(0,global.one_second*1.5);
	} else {
		x += lengthdir_x(.7,_dir);
		y += lengthdir_y(.7,_dir);
	}
	
	if alarm_get(1) <= 0 {
		state = ENEMY_STATE.Idle;
		alarm_set(0,global.one_second*1.5);
	}
	break;
	
	case ENEMY_STATE.BALDIE_KICK:
	sprite_index = s_baldie_kick;
	image_speed = .5;
	if animation_get_frame(4) {
		var _base_dmg = 2;
		var _dmg = instance_create_depth(x+image_xscale*15,y-25,depth-20,class_dmg);
		_dmg.dmg = _base_dmg;
		_dmg.creator = ENEMY;
		_dmg.image_xscale = 2;
		with _dmg {
			if place_meeting(x,y,o_player) {
				o_player.state = KNOCK_DOWN;
			}
		}
	}
	break;
	
	case ENEMY_STATE.Hit: 
	image_speed = .4;
	sprite_index = s_baldie_hit;
	break;
	
	case ENEMY_STATE.BALDIE_THROWED:
	image_speed = .25;
	sprite_index = s_baldie_downed;
	var _spd = .1;
	if image_index < 2 {
		x += _spd*-(image_xscale);
	}
	break;
	
	case ENEMY_STATE.BALDIE_DEATH:
	image_speed = .25;
	sprite_index = s_baldie_death;
	var _spd = .1;
	if image_index < 2 {
		x += _spd*-(image_xscale);
	}
	break;
}
	
