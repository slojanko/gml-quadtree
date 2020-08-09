// Update caster values
var scale = 1 + 0.2 * (mouse_wheel_up() - mouse_wheel_down());
if (scale != 1)
	circle_caster.ScaleRadius(scale);

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
	performance.Start();
	contains_caster = terrain.ContainsOnlyCaster(circle_caster);
	performance.End();
}