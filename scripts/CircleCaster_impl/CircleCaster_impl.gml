function CircleCaster(position_, radius_, value_) constructor {
	position = position_;
	radius = radius_;
	value = value_;
	
	function IsOverlapping(rect_) {
		var x_ = clamp(position.x, rect_.position.x, rect_.position.x + rect_.dimension.x);
		var y_ = clamp(position.y, rect_.position.y, rect_.position.y + rect_.dimension.y);
		
		return point_distance(position.x, position.y, x_, y_) <= radius; 
	}

	function IsRectInside(rect_) {
		var xx = rect_.position.x + rect_.dimension.x;
		var yy = rect_.position.y + rect_.dimension.y;
		
		if (point_in_circle(rect_.position.x, rect_.position.y, position.x, position.y, radius) == false) {
			return false;
		}
		
		if (point_in_circle(rect_.position.x, yy, position.x, position.y, radius) == false) {
			return false;
		}
				
		if (point_in_circle(xx, rect_.position.y, position.x, position.y, radius) == false) {
			return false;
		}
				
		if (point_in_circle(xx, yy, position.x, position.y, radius) == false) {
			return false;
		}
		
		return true;
	}
	
	function DebugDraw() {
		draw_circle_color(position.x, position.y, radius, value, value, true);
	}
}