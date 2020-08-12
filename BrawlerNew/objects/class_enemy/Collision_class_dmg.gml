/// @description Insert description here
// You can write your code in this editor
if other.creator == ENEMY or state == ENEMY_STATE.Hit then exit;

hp -= other.dmg;
state = ENEMY_STATE.Hit;

if hp <= 0 {
	state = ENEMY_STATE.BALDIE_DEATH;
	image_speed = .25;
}