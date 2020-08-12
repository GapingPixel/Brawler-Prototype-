/// @description Insert description here
// You can write your code in this editor
if other.creator == PLAYER or state == HIT then exit;

hp -= other.dmg;

if stunned_hit_count >= 3 {
	state = STUNNED;
} else if state != KNOCK_DOWN {
	state = HIT;
}

