/// @description Insert description here
// You can write your code in this editor

depth = -y-2;
image_speed = .2;

switch state {

	case IDLE:
	if stamina < 9 {
		stamina += .01 
	}
	
	var dir = point_direction(0,0,input.haxis, input.vaxis);
	
	if (input.haxis == 0 and input.vaxis == 0) {
		len = 0;
		sprite_index = s_player_idle;
	} else {
		if input.run {
			len = spd*1.5;
			sprite_index = s_player_run;
		} else {
			len = spd;
			
			sprite_index = s_player_walk;
		}
		get_face(dir);
	}
	
	hspd = lengthdir_x(len,dir);
	vspd = lengthdir_y(len,dir);
	
	player_move();

	
	if input.cross and stamina >= 1 and alarm_get(0)<=0 {
		state = JUMP;
		sprite_index = s_player_jump;
		//o_crystal.alarm[0] = room_speed*.15;
		image_index = 0;
		//stamina--;
		oldy = y;
	}
	
	if input.square and stamina > 1 and alarm_get(0)<=0 {
		
		if input.run {
			state = RUN_CLOTHESLINE;	
			last_hspd = hspd;
			last_vspd = vspd;
		} else {
			state = BASIC;
		}
		
		var _enemy = instance_nearest(x,y,o_baldie)
		if _enemy != noone {
		
			if distance_to_point(_enemy.x,_enemy.y) <= 16 {
		
				switch _enemy.state {
		
					case ENEMY_STATE.GROGGY:
					state = UPPERCUT;
					break;
			
					case ENEMY_STATE.DOWNED:
					state = ELBOW_DROP;
					break;
				} 
			}
		} 
		
		if state == BASIC {
			if punch_sprite == s_player_basic {
				punch_sprite = s_player_basic_2;
			} else {
				punch_sprite = s_player_basic;
			}
		}
		
		//o_crystal.alarm[0] = room_speed*.15;
		image_index = 0;
		//stamina--;
	}
	
	if input.triangle and stamina > 1 and alarm_get(0)<=0 {
		
		if input.run {
			state = RUN_MID_KICK;	
			last_hspd = hspd;
			last_vspd = vspd;
		} else {
			state = KICK;
		}
		
		
		var _enemy = instance_nearest(x,y,o_baldie);
		if _enemy != noone {
			if distance_to_point(_enemy.x,_enemy.y) <= 16 {
		
				switch _enemy.state {
		
					case ENEMY_STATE.GROGGY:
					state = ROUNDHOUSE;
					break;
			
					case ENEMY_STATE.DOWNED:
					state = STOMP;
					break;
			
					default:
					
					if kick_sprite == s_player_kick {
						kick_sprite = s_player_kick_2;
					} else {
						kick_sprite = s_player_kick;
					}
					break;
				}
			}
		} 
		
		if state == KICK {
			if kick_sprite == s_player_kick {
					kick_sprite = s_player_kick_2;
			} else {
				kick_sprite = s_player_kick;
			}
		}
		
		//o_crystal.alarm[0] = room_speed*.15;
		image_index = 0;
		//stamina--;
	}
	
	
	if input.circle and stamina > 1 and alarm_get(0)<=0 {
		
		state = GRAB_FAIL;
		
		if place_meeting(x,y,o_bat) {
			state = GRABBED_BAT;
			sprite_index = s_player_pickup;
			
		} 
		if place_meeting(x,y,o_bottle) {
			state = GRABBED_BOTTLE;
			sprite_index = s_player_pickup;
		} 
		if place_meeting(x,y,o_trashcan) {
			state = GRABBED_TRASHCAN;
			sprite_index = s_player_pickup;
		} 
		
		grabbed_enemy = instance_nearest(x,y,o_baldie);
		if grabbed_enemy != noone {
			if distance_to_point(grabbed_enemy.x,grabbed_enemy.y) <= 16 {
				state = GRABBED_ENEMY;
				grabbed_enemy.state = ENEMY_STATE.GRABBED;
				grabbed_enemy.y = y;
				grabbed_enemy.x = x+25*image_xscale;
				sprite_index = s_baldie_grabbed;
				grabbed_enemy.image_xscale = image_xscale;
				
			} 
		} 
		
	}
	
	break;
	
	case JUMP:
	if image_index < 1 and sprite_index != s_player_jump_punch and sprite_index != s_player_jump_kick {
		if input.square {
			var _oldframe = image_index;
			sprite_index = s_player_jump_punch;
			image_index = _oldframe;
		}
		if input.triangle {
			var _oldframe = image_index;
			sprite_index = s_player_jump_kick;
			image_index = _oldframe;
		}
	}
	
	if sprite_index == s_player_jump_punch or sprite_index == s_player_jump_kick {
		if animation_get_frame(1.5) {
			var _jump_dmg = 1;
			var _dmg = instance_create_depth(x+image_xscale*12,y-30,depth-20,class_dmg);
			_dmg.dmg = _jump_dmg;
			_dmg.image_yscale = 2;
			_dmg.image_xscale = 1.5;
		}
	}
	
	image_speed = .25;
	if jump_pos != -1 {
	
		var dir = point_direction(0,0,input.haxis, input.vaxis);
	
		if (input.haxis == 0 and input.vaxis == 0) {
			len = 0;
		} else {
			len = spd*3.2;
			get_face(dir);
		}
	
		hspd = lengthdir_x(len,dir);
		vspd = lengthdir_y(len,dir);

		player_move();
		
		if jump_height > jump_pos {
			jump_pos+= jump_spd;
			y -= jump_spd;
		} else {
			y += jump_spd*1.5;
			if y >= oldy {
				y = oldy;
				jump_pos = -1;
			}
		}
		
	}
	
	break;
	
	case UPPERCUT:
	sprite_index = s_player_uppercut;
	image_speed = .25;
	var _uppercut_dmg = 2;
	if animation_get_frame(2) {
		var _dmg = instance_create_depth(x+image_xscale*12,y-30,depth-20,class_dmg);
		_dmg.dmg = _uppercut_dmg;
	}
	break;
	
	case KICK:
	sprite_index = kick_sprite;
	image_speed = .25;
	var _kick_dmg = 1;
	if animation_get_frame(1) {
		var _dmg = instance_create_depth(x+image_xscale*12,y-30,depth-20,class_dmg);
		_dmg.dmg = _kick_dmg;
	}
	break;
	
	case BASIC:
	sprite_index = punch_sprite;
	image_speed = .25;
	var _punch_dmg = 1;
	if animation_get_frame(1) {
		var _dmg = instance_create_depth(x+image_xscale*12,y-30,depth-20,class_dmg);
		_dmg.dmg = _punch_dmg;
	}
	break;
	
	case ELBOW_DROP:
	sprite_index = s_player_elbowdrop;
	image_speed = .25;
	var _elbowdrop_dmg = 2;
	if animation_get_frame(2) {
		var _dmg = instance_create_depth(x+image_xscale,y,depth-20,class_dmg);
		_dmg.dmg = _elbowdrop_dmg;
	}
	break;
	
	case ROUNDHOUSE:
	sprite_index = s_player_roundhouse;
	image_speed = .25;
	var _roundhouse_dmg = 2;
	if animation_get_frame(3) {
		var _dmg = instance_create_depth(x+image_xscale*12,y-30,depth-20,class_dmg);
		_dmg.dmg = _roundhouse_dmg;
	}
	break;
	
	case STOMP:
	sprite_index = s_player_stomp;
	image_speed = .25;
	var _stomp_dmg = 1;
	if animation_get_frame(1) {
		var _dmg = instance_create_depth(x,y,depth-20,class_dmg);
		_dmg.dmg = _stomp_dmg;
		_dmg.image_xscale = 3;
	}
	break;
	
	case GRAB_FAIL:
	sprite_index = s_player_grab;
	image_speed = .25;
	break;
	
	case GRABBED_ENEMY:
	image_speed = .25;
	if input.circle {
		state = IDLE;
		grabbed_enemy.state = IDLE;
	}
	
	var dir = point_direction(0,0,input.haxis, input.vaxis);
	
	if (input.haxis == 0 and input.vaxis == 0) {
		len = 0;
	} else {
		len = spd;
		//get_face(dir);
	}
	
	hspd = lengthdir_x(len,dir);
	vspd = lengthdir_y(len,dir);
	
	player_move();
	
	grabbed_enemy.x += hspd; 
	grabbed_enemy.y += vspd;
	
	if (hspd != 0 or vspd != 0 ) {
		sprite_index = s_player_grabbing_walk;
		grabbed_enemy.sprite_index = s_baldie_grabbed_walking;
	} else {
		sprite_index = s_player_grab;
		grabbed_enemy.sprite_index = s_baldie_grabbed;
	}
	
	if input.square and stamina > 1 and alarm_get(0)<=0 {
		punch_count++;
		if punch_count == 3 {
			state = GRABBED_SUPLEX;
			grabbed_enemy.sprite_index = s_baldie_grabbed_suplex;
			grabbed_enemy.x = x;
			grabbed_enemy.image_xscale = -grabbed_enemy.image_xscale;
			punch_count = 0;
			
		} else {
			state = GRABBED_PUNCH_HEAD;
			grabbed_enemy.sprite_index = s_baldie_grabbed_punch_head;
			grabbed_enemy.hp -= 1;
			if grabbed_enemy.hp <= 0 {
				holding_enemy_death = true;
			}
		}
		
	}
	
	if input.triangle and stamina > 1 and alarm_get(0)<=0 {
		kick_count++;
		if kick_count == 3 {
			state = GRABBED_PILEDRIVER;
			sprite_index = s_player_combo_piledriver;
			grabbed_enemy.sprite_index = s_baldie_grabbed_piledriver;
			grabbed_enemy.x = x//*image_xscale;
			grabbed_enemy.image_xscale = -grabbed_enemy.image_xscale;
			kick_count = 0;
			
		} else {
			state = GRABBED_KNEE;
			grabbed_enemy.sprite_index = s_baldie_grabbed_punch_head;
			grabbed_enemy.hp -= 1;
			if grabbed_enemy.hp <= 0 {
				holding_enemy_death = true;
			}
			
		}
	}
	break;
	
	case GRABBED_PILEDRIVER:
	sprite_index = s_player_combo_piledriver;
	image_speed = .25;
	break;
	
	case GRABBED_PUNCH_HEAD:
	sprite_index = s_player_punch_head;
	image_speed = .25;
	break;
	
	case GRABBED_KNEE:
	sprite_index = s_player_grabbing_knee;
	image_speed = .25;
	break;
	
	case GRABBED_SUPLEX:
	sprite_index = s_player_suplex;
	image_speed = .25;
	break;
	
	case GRABBED_BAT:
	grabbed_item(s_player_bat_attack,s_player_bat_throw,s_player_bat_walk,s_player_bat_idle);
	
	if animation_get_frame(2) and sprite_index == s_player_bat_attack {
		var _bat_dmg = 2;
		var _dmg = instance_create_depth(x+image_xscale*12,y-25,depth-20,class_dmg);
		_dmg.dmg = _bat_dmg;
		_dmg.image_xscale = 3;
		
	}
	break;
	
	case GRABBED_BOTTLE:
	grabbed_item(s_player_bottle_throw,s_player_bottle_throw,s_player_bottle_walk,s_player_bottle_idle);
	break;
	
	case GRABBED_TRASHCAN:
	grabbed_item(s_player_trashcan_attack,s_player_trashcan_throw,s_player_trashcan_walk,s_player_trashcan_idle);
	if animation_get_frame(2) and sprite_index == s_player_trashcan_attack {
		var _trashcan_dmg = 3;
		var _dmg = instance_create_depth(x+image_xscale*12,y-25,depth-20,class_dmg);
		_dmg.dmg = _trashcan_dmg;
		_dmg.image_xscale = 2;
		_dmg.image_yscale = 2;
		
	}
	break;
	
	case STUNNED:
	image_speed = .25;
	sprite_index = s_player_stunned;
	break;
	
	case KNOCK_DOWN:
	image_speed = .25;
	sprite_index = s_player_knockdown;
	break;
	
	case HIT:
	image_speed = .3;
	sprite_index = s_player_stunned;
	break;
	
	case DEAD:
	image_speed = .3;
	sprite_index = s_player_dead;
	break;
	
	case RUN_CLOTHESLINE:
	image_speed = .25;
	sprite_index = s_player_clothesline;
	hspd = last_hspd/2;
	vspd = last_vspd/2;
	player_move();
	
	if animation_get_frame(2) {
		var _run_dmg = 2;
		var _dmg = instance_create_depth(x+image_xscale*15,y-30,depth-20,class_dmg);
		_dmg.dmg = _run_dmg;
		_dmg.image_xscale = 2;
	
	}
	break;
	
	case RUN_MID_KICK:
	image_speed = .25;
	sprite_index = s_player_mid_kick;
	
	hspd = last_hspd/2;
	vspd = last_vspd/2;
	player_move();
	
	if animation_get_frame(2) {
		var _run_dmg = 2;
		var _dmg = instance_create_depth(x+image_xscale*15,y-30,depth-20,class_dmg);
		_dmg.dmg = _run_dmg;
		_dmg.image_xscale = 2;
	
	}
	break;

}

if hp <= 0 {
	state = DEAD;
	
	/*state = BALDIE_DEATH;
	image_speed = .25;*/
}