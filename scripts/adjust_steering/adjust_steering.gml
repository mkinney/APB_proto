steering_delta = argument0;

// can only steer if we are going some speed
if (global.road_speed > 0) {
	// be sure to stay on the road
	var new_x = obj_car_cop.x + steering_delta;
	if (new_x > 100 - 16) && (new_x < 100 + 256 - 48) {
		obj_car_cop.x += steering_delta;
	}
}