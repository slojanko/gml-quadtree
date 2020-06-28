// Increase radius with scroll wheel
radius += radius * 0.2  * (mouse_wheel_up() - mouse_wheel_down());
if (radius < 1) {
	radius = 1;
}
	
	
// Paint with left mouse button
if (mouse_check_button(mb_left)) {
	terrain.SetValueInCircle(new Vector2(mouse_x, mouse_y), radius, value);
	// terrain.Optimize();
}

// Color pick with right mouse button
if (mouse_check_button(mb_right)) {
	value = draw_getpixel(mouse_x, mouse_y);
}