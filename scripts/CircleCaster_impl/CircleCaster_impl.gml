function CircleCaster(position_, radius_, value_) constructor {
	position = position_;
	radius = radius_;
	radius2 = radius * radius;
	value = value_;
	
	function IsOverlapping(rect_) {
		var x_ = clamp(position.x, rect_.position.x, rect_.position.x + rect_.dimension.x);
		var y_ = clamp(position.y, rect_.position.y, rect_.position.y + rect_.dimension.y);
		
		return point_distance_sq(position.x, position.y, x_, y_) <= radius2; 
	}

	function IsRectInside(rect_) {
		var x_ = rect_.position.x + rect_.dimension.x;
		var y_ = rect_.position.y + rect_.dimension.y;
		
		if (point_distance_sq(rect_.position.x, rect_.position.y, position.x, position.y) > radius2)
			return false;
			
		if (point_distance_sq(rect_.position.x, y_, position.x, position.y) > radius2)
			return false;
			
		if (point_distance_sq(x_, rect_.position.y, position.x, position.y) > radius2)
			return false;
			
		if (point_distance_sq(x_, y_, position.x, position.y) > radius2)
			return false;
		
		return true;
	}
	
	function DebugDraw() {
		draw_circle_color(position.x, position.y, radius, value, value, true);
	}
	
	function ScaleRadius(scale_) {
		radius *= scale_;
		radius = max(1, radius);
		radius2 = radius * radius;
	}
}