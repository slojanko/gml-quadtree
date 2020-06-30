game_set_speed(30, gamespeed_fps);
show_debug_overlay(true);

terrain = new Quadtree(new Vector2(350, 350), new Vector2(700, 700), 8, 0);
performance = new Performance();

// Paint tool
radius = 250;
value = c_white;
time_taken = 0;
longest_time_taken = 0;
tree_size = 0;