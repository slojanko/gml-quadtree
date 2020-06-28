game_set_speed(30, gamespeed_fps);
show_debug_overlay(true);

terrain = new Quadtree(new Vector2(350, 350), new Vector2(700, 700), 6, 0);

// Paint tool
radius = 15;
value = 0;