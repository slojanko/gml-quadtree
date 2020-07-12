terrain.Draw();

draw_text(720, 20, "Time taken: " + string(performance.GetTime(PerformanceFormat.ms)));
draw_text(720, 35, "Longest time taken: " + string(performance.GetLongestTime(PerformanceFormat.ms)));
draw_text(720, 50, "Tree size: " + string(tree_size));
circle_caster.DebugDraw();

// Color picker
draw_sprite(spr_color, 0, 720, room_height / 2 - sprite_get_height(spr_color) / 2);
