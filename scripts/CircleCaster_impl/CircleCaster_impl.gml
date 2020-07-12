function CircleCaster(position_, radius_, value_) constructor {
	this.position = position_;
	this.radius = radius_;
	this.value = value_;
	
	// https://stackoverflow.com/questions/401847/circle-rectangle-collision-detection-intersection
	function IsOverlapping(rect_) {
		var rect_center_ = rect_.GetCenter();
		var x_ = abs(this.position.x - rect_center_.x);
	    var y_ = abs(this.position.y - rect_center_.y);
		
	    if (x_ > (rect_.dimension.x/2 + this.radius)) { 
			return false; 
		}
		
	    if (y_ > (rect_.dimension.y/2 + this.radius)) { 
			return false; 
		}
		
	    if (x_ <= (rect_.dimension.x/2)) { 
			return true; 
		} 
		
	    if (y_ <= (rect_.dimension.y/2)) { 
			return true; 
		}
		
	    var cDist_sq = power(x_ - rect_.dimension.x/2, 2) + power(y_ - rect_.dimension.y/2, 2);
 
	    return (cDist_sq <= power(this.radius, 2));
	}

	function IsInside(rect_) {
		var xx = rect_.position.x + rect_.dimension.x;
		var yy = rect_.position.y + rect_.dimension.y;
		
		if (point_in_circle(rect_.position.x, rect_.position.y, this.position.x, this.position.y, this.radius) == false) {
			return false;
		}
		
		if (point_in_circle(rect_.position.x, yy, this.position.x, this.position.y, this.radius) == false) {
			return false;
		}
				
		if (point_in_circle(xx, rect_.position.y, this.position.x, this.position.y, this.radius) == false) {
			return false;
		}
				
		if (point_in_circle(xx, yy, this.position.x, this.position.y, this.radius) == false) {
			return false;
		}
		
		return true;
	}
	
	function DebugDraw() {
		draw_circle_color(this.position.x, this.position.y, this.radius, this.value, this.value, true);
	}
}