function Quadtree(position_, dimension_, max_depth_, value_) constructor {
	position = position_;
	dimension = dimension_;
	max_depth = max_depth_;
	
	// Cache edges
	left_edge = position.x - dimension.x / 2;
	top_edge = position.y - dimension.y / 2;
	right_edge = position.x + dimension.x / 2;
	bottom_edge = position.y + dimension.y / 2;
	
	value = value_;
	is_split = false;
	
	subtree = array_create(4, undefined);
	
	// Todo: Update this to Optimize constantly when changing values
	function SetValueInCircle(position_, radius_, value_) {
		// Skip if not overlapping circle
		if (OverlapCircle(position_, radius_) == false) {
			return;
		}
		
		if (is_split == false && value == value_) {
			return;
		}
				
		// Skip if max depth reached
		if (max_depth <= 0) { 
			value = value_;
			return;
		}
		
		if (VerticesInCircle(position_, radius_)) {
			if (is_split == true) {
				RemoveSubtrees();
			}
			value = value_;
			return;
		}
			
		var previous_value = value;
		value = value_;
			
		// Subdivide and repeat 
		if (is_split == false) {			
			// Top left | Top right | Bottom left | Bottom right
			subtree[0] = new Quadtree(new Vector2(left_edge + dimension.x / 4, top_edge + dimension.y / 4), new Vector2(dimension.x / 2, dimension.y / 2), max_depth - 1, previous_value);
			subtree[1] = new Quadtree(new Vector2(right_edge - dimension.x / 4, top_edge + dimension.y / 4), new Vector2(dimension.x / 2, dimension.y / 2), max_depth - 1, previous_value);
			subtree[2] = new Quadtree(new Vector2(left_edge + dimension.x / 4, bottom_edge - dimension.y / 4), new Vector2(dimension.x / 2, dimension.y / 2), max_depth - 1, previous_value);
			subtree[3] = new Quadtree(new Vector2(right_edge - dimension.x / 4, bottom_edge - dimension.y / 4), new Vector2(dimension.x / 2, dimension.y / 2), max_depth - 1, previous_value);
			is_split = true;
		}
				
		for(var i = 0; i < 4; i++) {
			subtree[i].SetValueInCircle(position_, radius_, value);
		}
	}
	
	function VerticesInCircle(position_, radius_) {
		if (point_in_circle(left_edge, top_edge, position_.x, position_.y, radius_) == false) {
			return false;
		}
		
		if (point_in_circle(right_edge, top_edge, position_.x, position_.y, radius_) == false) {
			return false;
		}
				
		if (point_in_circle(left_edge, bottom_edge, position_.x, position_.y, radius_) == false) {
			return false;
		}
				
		if (point_in_circle(right_edge, bottom_edge, position_.x, position_.y, radius_) == false) {
			return false;
		}
		
		return true;
	}
	
	function RemoveSubtrees() {
		if (is_split == false) 
			return;
			
		for(var i = 0; i < 4; i++) {
			subtree[i].RemoveSubtrees();
			delete subtree[i];
		}
		
		is_split = false;
	}
	
	function Optimize() {
		// Skip if not split
		if (is_split == false) {
			return true;
		}
		
		// Try to optimize subtrees
		// Successfull if all can be optimized and all values are the same
		var success = true;			
		for(var i = 0; i < 4; i++) {
			var subtree_success = subtree[i].Optimize();
			if (subtree_success == false) {
				success = false;
			}
			
			if (subtree[i].value != value) {
				success = false;
			}
		}
			
		if (success) {
			RemoveSubtrees();
		}
			
		return success;
	}
	
	// https://stackoverflow.com/questions/401847/circle-rectangle-collision-detection-intersection
	function OverlapCircle(position_, radius_) {
		var x_ = abs(position_.x - position.x);
	    var y_ = abs(position_.y - position.y);
		
	    if (x_ > (dimension.x/2 + radius_)) { 
			return false; 
		}
		
	    if (y_ > (dimension.y/2 + radius_)) { 
			return false; 
		}
		
	    if (x_ <= (dimension.x/2)) { 
			return true; 
		} 
		
	    if (y_ <= (dimension.y/2)) { 
			return true; 
		}
		
	    var cDist_sq = power(x_ - dimension.x/2, 2) + power(y_ - dimension.y/2, 2);
 
	    return (cDist_sq <= power(radius_, 2));
	}
	
	function Draw() {
		if (is_split == false) {
			draw_set_color(value);
			draw_rectangle(left_edge, top_edge, right_edge, bottom_edge, true);
		} else {
			for(var i = 0; i < 4; i++) {
				subtree[i].Draw();
			}
		}
	}
}