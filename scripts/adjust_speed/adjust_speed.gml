speed_delta = argument0;

if (speed_delta < 0) {
	// do not go negative speed
	if (global.road_speed > 0) {
		global.road_speed += speed_delta;
	}
} else {
	global.road_speed += speed_delta;
}

for (var i = 0; i < road_count; i++) {
	if (roads[i] != noone) {
		roads[i].speed = global.road_speed;
	}
}