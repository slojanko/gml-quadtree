terrain.Draw();

draw_text(0, 20, "Time taken: " + string(performance.GetTime(PerformanceFormat.ms)));
draw_text(0, 35, "Longest time taken: " + string(performance.GetLongestTime(PerformanceFormat.ms)));
draw_circle_color(mouse_x, mouse_y, radius, value, value, true);

// Color picker
draw_sprite(spr_color, 0, 720, room_height / 2 - sprite_get_height(spr_color) / 2);
// draw_rectangle_color(0, room_height - 50, room_width, room_height, c_white, c_black, c_black, c_white, false);