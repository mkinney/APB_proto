// draw speed on spedometer
draw_set_valign(fa_middle);
draw_set_color(c_white);
draw_set_font(fnt_speedometer);
draw_text(obj_steering_wheel.x - 10, obj_steering_wheel.y, string(global.road_speed * 10));