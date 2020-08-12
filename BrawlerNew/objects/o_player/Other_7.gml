/// @description Insert description here
// You can write your code in this editor
if state == JUMP {
	state = IDLE;
	alarm_set(0,15);
	jump_pos = 0;
} 

if state == BASIC {
	state = IDLE;
	//alarm_set(0,10);
}

if state == KICK {
	state = IDLE;
	//alarm_set(0,10);
}

if state == ELBOW_DROP {
	state = IDLE;
	//alarm_set(0,10);
}

if state == UPPERCUT {
	state = IDLE;
	alarm_set(0,10);
}

if state == ROUNDHOUSE {
	state = IDLE;
	
}

if state == STOMP {
	state = IDLE;
}

if state == GRAB_FAIL or state == KNOCK_DOWN  {
	state = IDLE;
}

if state == GRABBED_PUNCH_HEAD or state == GRABBED_KNEE {
	if !holding_enemy_death {
		state = GRABBED_ENEMY;
	} else {
		grabbed_enemy.state = ENEMY_STATE.BALDIE_DEATH;
		grabbed_enemy.image_speed = .25;
		grabbed_enemy.image_xscale = -image_xscale;
		state = IDLE;
		holding_enemy_death = false;
		punch_count = 0;
		kick_count = 0;
	}
}

if state == GRABBED_PILEDRIVER or state == GRABBED_SUPLEX {
	state = IDLE;
}

if sprite_index == s_player_bat_attack or (sprite_index == s_player_pickup and state == GRABBED_BAT) {
	sprite_index = s_player_bat_idle;
}




if sprite_index == kick_sprite {
	switch (state) {
		
		case GRABBED_BAT:
		sprite_index = s_player_bat_idle;
		break;
		
		case GRABBED_BOTTLE:
		sprite_index = s_player_bottle_idle;
		break;
		
		case GRABBED_TRASHCAN:
		sprite_index = s_player_trashcan_idle;
		break;
	
	}
}

if  (sprite_index == s_player_pickup and state == GRABBED_BOTTLE) {
	sprite_index = s_player_bottle_idle;
}

if  sprite_index == s_player_trashcan_attack or (sprite_index == s_player_pickup and state == GRABBED_TRASHCAN) {
	sprite_index = s_player_trashcan_idle;
}

if sprite_index == s_player_bottle_throw or sprite_index == s_player_trashcan_throw or sprite_index == s_player_bat_throw  {
	state = IDLE;
}



if state == STUNNED {
	stunned_count++;
	if stunned_count > 2 {
		state = IDLE;
	}
}

if state == HIT {
	state = IDLE;
}

if state == DEAD {
	var _corpse = instance_create_depth(x,y,depth,o_corpse);
	_corpse.sprite_index = s_player_corpse;
	_corpse.image_xscale = image_xscale;
	instance_destroy();
}

if state == RUN_CLOTHESLINE or state == RUN_MID_KICK {
	state = IDLE;
}