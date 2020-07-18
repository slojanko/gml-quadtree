function RectCaster(position_, dimension_, value_) constructor {
	position = position_;
	dimension = dimension_;
	value = value_;
	
	function IsOverlapping(rect_) {
		if (position.x > (rect_.position.x + rect_.dimension.x) || rect_.position.x > (position.x + dimension.x))
			return false;
			
		if (position.y > (rect_.position.y + rect_.dimension.y) || rect_.position.y > (position.y + dimension.y))
			return false;
			
		return true;
	}

	function IsRectInside(rect_) {
		var xx = rect_.position.x + rect_.dimension.x;
		var yy = rect_.position.y + rect_.dimension.y;
		
		if (point_in_rectangle(rect_.position.x, rect_.position.y, position.x, position.y, position.x + dimension.x, position.y + dimension.y) == false) {
			return false;
		}
				
		if (point_in_rectangle(xx, yy, position.x, position.y, position.x + dimension.x, position.y + dimension.y) == false) {
			return false;
		}
		
		return true;
	}
	
	function DebugDraw() {
		draw_rectangle_color(position.x, position.y, position.x + dimension.x, position.y + dimension.y, value, value, value, value, true);
	}
}