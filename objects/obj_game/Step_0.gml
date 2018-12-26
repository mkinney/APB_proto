var last_y = -64;
for (var i = 0; i < road_count; i++) {
	if (roads[i] == noone) {
		var r = instance_create_layer(100, last_y, "Instances", obj_road);
		r.direction = 270;
		r.speed = global.road_speed;
		roads[i] = r;
		last_y -= 64;
	} else {
		if (roads[i].y > room_height) {
			instance_destroy(roads[i]);
			roads[i] = noone;
		} else {
			last_y = roads[i].y - 64;
		}
	}
}

if (device_mouse_check_button_pressed(0, mb_left)) {
	
	// see if we have left clicked the virtual steering wheel
	var vs = instance_position(mouse_x, mouse_y, obj_steering_wheel);
	if (vs != noone) {
		show_debug_message("vs pressed");
		
		// which side of wheel
		var sw = obj_steering_wheel;
		var right = point_in_rectangle(mouse_x, mouse_y, sw.x, sw.y, sw.x + sw.sprite_width / 2, sw.y + sw.sprite_height);
		
		show_debug_message("mouse_x:" + string(mouse_x) + " mouse_y:" + string(mouse_y));
		show_debug_message("sw x:" + string(sw.x) + " y:" + string(sw.y));
		show_debug_message("sw x2:" + string(sw.x + sw.sprite_width / 2) + " y:" + string(sw.y + sw.sprite_height));

		if (right) {
			adjust_steering(steering_amount);
		} else {
			adjust_steering(steering_amount * -1);
		}

	}
	
	// siren
	var s = instance_position(mouse_x, mouse_y, obj_siren);
	if (s != noone) {
		show_debug_message("siren pressed siren:" + string(siren));
		siren = !siren;
		if (siren) {
			audio_play_sound(snd_siren, 100, true);
			obj_siren.image_alpha = 1;
			alarm[0] = siren_delay;
		} else {
			audio_stop_sound(snd_siren);
			alarm[0] = -1;
			obj_siren.image_alpha = 0.5;
		}
	}		
}

// allow arrow keys to steer
var left = keyboard_check(vk_left);
if (left) {
	adjust_steering(steering_amount * -1);
}
var right = keyboard_check(vk_right);
if (right) {
	adjust_steering(steering_amount);
}
// space for brake
var space = keyboard_check_pressed(vk_space);
if (space) {
	adjust_speed(-1);
}
// down for gas
var down = keyboard_check_pressed(vk_down);
if (down) {
	adjust_speed(1);
}

var s_key = keyboard_check_released(ord("S"));
if (s_key) {
	// siren
	show_debug_message("S pressed for siren: " + string(siren));
	siren = !siren;
	if (siren) {
		audio_play_sound(snd_siren, 100, true);
		obj_siren.image_alpha = 1;
		alarm[0] = siren_delay;
	} else {
		audio_stop_sound(snd_siren);
		alarm[0] = -1;
		obj_siren.image_alpha = 0.5;
	}
}

// set the road speed
sprite_set_speed(spr_road, global.road_speed, spritespeed_framespersecond);