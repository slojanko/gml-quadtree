// Update caster values
circle_caster.radius += circle_caster.radius * 0.2  * (mouse_wheel_up() - mouse_wheel_down());
if (circle_caster.radius < 1) {
	circle_caster.radius = 1;
}

// Color pick with right mb
if (mouse_check_button(mb_right)) {
	circle_caster.value = draw_getpixel(mouse_x, mouse_y);
}

circle_caster.position.x = mouse_x;
circle_caster.position.y = mouse_y;
	
// Paint with left mb
if (mouse_check_button(mb_left)) {
	performance.Start();
	terrain.ApplyCaster(circle_caster);
	terrain.Optimize();
	performance.End();
	
	tree_size = terrain.GetTreeSize();
}

// Check for caster in quadtree with middle mb
if (mouse_check_button(mb_middle)) {
	contains_caster = terrain.ContainsCaster(circle_caster)
}