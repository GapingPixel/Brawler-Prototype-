/// @description Insert description here
// You can write your code in this editor
if sprite_index == s_baldie_downed {
	image_speed = 0;
	image_index = image_number-1;
}

if state == ENEMY_STATE.BALDIE_DEATH {
	instance_destroy();
	var _corpse = instance_create_depth(x,y,depth,o_corpse);
	_corpse.sprite_index = s_baldie_corpse;
	_corpse.image_xscale = image_xscale;
}

if sprite_index == s_baldie_punch_1 and !punch_spr {
	 sprite_index = s_baldie_punch_2;
} else if sprite_index == s_baldie_punch_2 {
		 sprite_index = s_baldie_punch_1;
		 punch_spr = true;
} else if sprite_index == s_baldie_punch_1 and punch_spr {
	punch_spr = false;
	//alarm_set(0,global.one_second*1.5);
	if o_player.state == STUNNED {
		state = ENEMY_STATE.BALDIE_KICK;
	} else {
		state = ENEMY_STATE.BALDIE_FLEE;
		flee_dir = point_direction(o_player.x,o_player.y,x,y);
		alarm_set(1,global.one_second*1.5);
	}
	o_player.stunned_hit_count = 0;
	
}

if sprite_index == s_baldie_kick {
	state = ENEMY_STATE.BALDIE_FLEE;
	flee_dir = point_direction(o_player.x,o_player.y,x,y);
	alarm_set(1,global.one_second*1.5);
}


if state == ENEMY_STATE.BALDIE_THROWED {
	state = ENEMY_STATE.Idle;
}

if sprite_index == s_baldie_grabbed_suplex {
	state = ENEMY_STATE.BALDIE_THROWED;
	image_xscale = -image_xscale;
	x += image_xscale*-25;
	hp -= 3;
	if hp <= 0 {
		state = ENEMY_STATE.BALDIE_DEATH;
		image_speed = .25;
	}
}

if sprite_index == s_baldie_grabbed_piledriver {
	state = ENEMY_STATE.BALDIE_THROWED;
	x += image_xscale*-25;
	hp -= 3;
	if hp <= 0 {
		state = ENEMY_STATE.BALDIE_DEATH;
		image_speed = .25;
	}
}

if state == ENEMY_STATE.Hit {
	state = ENEMY_STATE.BALDIE_FLEE;
	flee_dir = point_direction(o_player.x,o_player.y,x,y);
	alarm_set(1,global.one_second*1.5);
}







