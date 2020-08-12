function player_move() {
	/*if !place_meeting(x,y,o_solid) && vspd >= 0 && place_meeting(x,y+2+abs(hspd),o_solid) {
		while(!place_meeting(x,y+1,o_solid)) {
			y += 1;
		}
	}*/
	if place_meeting(x+hspd,y,o_solid) {
	    yplus = 0;
	    while (place_meeting(x+hspd,y-yplus,o_solid) && yplus <= abs(1*hspd)) {
			yplus += 1;
		}
		/*while (place_meeting(x+hspd,y-yplus,o_solid) && yplus >= abs(1*hspd)) {
			yplus -= 1;
		}*/
	    if place_meeting(x+hspd,y-yplus,o_solid) {
	        while (!place_meeting(x+sign(hspd),y,o_solid)) x+=sign(hspd);
	        hspd = 0;
	    } else {
	        y -= yplus
	    }
	}
	x += hspd;
	/*if place_meeting(x+hspd, y, o_solid) {
		while !place_meeting(x+hspd, y, o_solid) {
			x += sign(len);
		}
		hspd = 0;
	}
	x += hspd;*/

	if place_meeting(x, y+vspd, o_solid)  {
		while !place_meeting(x, y+vspd, o_solid) {
			y += sign(len);
		}
		vspd = 0;
		
	}
	y += vspd;
	
}

function get_face (_dir) {
	face = round(_dir/180); 
	
	switch face {
		
		case 0:
		image_xscale = 1;
		break;
			
		case 1:
		image_xscale = -1;
		break;
		
	}
}

function grabbed_item(_attack, _throw, _walk, _idle) {
	image_speed = .25;
	if sprite_index == _throw and animation_get_frame(image_number-1) {
			
				switch (sprite_index) {
				
				case s_player_bat_throw:
				var _bat = instance_create_depth(x+18*image_xscale,y-35,depth,o_throwable);
				_bat.sprite_index = s_throw_bat;
				_bat.speed = image_xscale*4;
				break;
				
				case s_player_bottle_throw:
				var _bat = instance_create_depth(x+12*image_xscale,y-34,depth,o_throwable);
				_bat.sprite_index = s_throw_bottle;
				_bat.speed = image_xscale*4;
				break;
				
				case s_player_trashcan_throw:
				var _bat = instance_create_depth(x+15*image_xscale,y-38,depth,o_throwable);
				_bat.sprite_index = s_throw_trashcan;
				_bat.speed = image_xscale*4;
				break;
			}
	} 
	
	if sprite_index == _attack  or sprite_index == kick_sprite or sprite_index == s_player_pickup 
	or sprite_index == _throw then exit;
	
	var dir = point_direction(0,0,input.haxis, input.vaxis);
	
	if (input.haxis == 0 and input.vaxis == 0) {
		len = 0;
		sprite_index = _idle;
	} else {
		len = spd;
		sprite_index = _walk;
		get_face(dir);
	}
	
	hspd = lengthdir_x(len,dir);
	vspd = lengthdir_y(len,dir);
	

	player_move();
	
		
		if ((input.circle) or input.square and input.triangle) and stamina > 1 and alarm_get(0)<=0 {
			sprite_index = _throw;
		}
		
		
		if input.square and stamina > 1 and alarm_get(0)<=0 {
			sprite_index = _attack;
		}

		
		if input.triangle {
			
			if kick_sprite == s_player_kick {
					kick_sprite = s_player_kick_2;
				} else {
					kick_sprite = s_player_kick;
			}
			sprite_index = kick_sprite;
		}
		
}


