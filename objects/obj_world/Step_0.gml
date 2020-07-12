// Update caster values
circle_caster.radius += circle_caster.radius * 0.2  * (mouse_wheel_up() - mouse_wheel_down());
if (circle_caster.radius < 1) {
	circle_caster.radius = 1;
}

circle_caster.position.x = mouse_x;
circle_caster.position.y = mouse_y;
	
// Paint with left mouse button
if (mouse_check_button(mb_left)) {
	performance.Start();
	terrain.SetValue(circle_caster);
	terrain.Optimize();
	performance.End();
	
	tree_size = terrain.GetTreeSize();
}


// Color pick with right mouse button
if (mouse_check_button(mb_right)) {
	circle_caster.value = draw_getpixel(mouse_x, mouse_y);
}