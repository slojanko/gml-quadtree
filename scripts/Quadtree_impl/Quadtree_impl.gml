function Quadtree(rect_, max_depth_, value_) constructor {
	rect = rect_;
	max_depth = max_depth_;
	value = value_;
	
	// Cache edges
	left_edge = rect.position.x;
	top_edge = rect.position.y;
	right_edge = rect.position.x + rect.dimension.x;
	bottom_edge = rect.position.y + rect.dimension.y;
	
	is_split = false;
	subtree = array_create(4, undefined);
	
	function ApplyCaster(caster_) {
		if (!is_split && value == caster_.value) {
			return;
		}
		
		if (!caster_.IsOverlapping(rect)) {
			return;
		}
				
		if (max_depth <= 0) { 
			value = caster_.value;
			return;
		}
		
		if (caster_.IsRectInside(rect)) {
			if (is_split) {
				RemoveSubtrees();
			}
			value = caster_.value;
			return;
		}
			
		var previous_value = value;
		value = caster_.value;
			
		if (!is_split) {			
			// Top left | Top right | Bottom left | Bottom right
			var center_ = rect.GetCenter();
			var dimension_ = new Vector2(rect.dimension.x / 2, rect.dimension.y / 2);
			subtree[0] = new Quadtree(new Rect(new Vector2(left_edge, top_edge), dimension_), max_depth - 1, previous_value);
			subtree[1] = new Quadtree(new Rect(new Vector2(center_.x, top_edge), dimension_), max_depth - 1, previous_value);
			subtree[2] = new Quadtree(new Rect(new Vector2(left_edge, center_.y), dimension_), max_depth - 1, previous_value);
			subtree[3] = new Quadtree(new Rect(new Vector2(center_.x, center_.y), dimension_), max_depth - 1, previous_value);
			is_split = true;
		}
				
		for(var i = 0; i < 4; i++) {
			subtree[i].ApplyCaster(caster_);
		}
	}
	
	function ContainsCaster(caster_) {		
		if (!caster_.IsOverlapping(rect)) {
			return false;
		}
		
		if (!is_split) {
			return value == caster_.value;
		}
		
		for(var i = 0; i < 4; i++) {
			if (subtree[i].ContainsCaster(caster_))
				return true;
		}
		
		return false;
	}
	
	function ContainsOnlyCaster(caster_) {
		if (!caster_.IsOverlapping(rect)) {
			return true;
		}
		
		if (!is_split) {
			return value == caster_.value;
		}
		
		for(var i = 0; i < 4; i++) {
			if (!subtree[i].ContainsOnlyCaster(caster_))
				return false;
		}
		
		return true;
	}
	
	function RemoveSubtrees() {
		if (!is_split) 
			return;
			
		for(var i = 0; i < 4; i++) {
			subtree[i].RemoveSubtrees();
			delete subtree[i];
		}
		
		is_split = false;
	}
	
	function Optimize() {
		if (!is_split) {
			return true;
		}
		
		// Try to optimize subtrees
		var success = true;			
		for(var i = 0; i < 4; i++) {
			var subtree_success = subtree[i].Optimize();
			if (!subtree_success) {
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
	
	function GetTreeSize() {
		var size_ = 0;
		
		if (!is_split) {
			size_ = 1;
		} else {
			for(var i = 0; i < 4; i++) {
				size_ += subtree[i].GetTreeSize();
			}
		}
			
		return size_;
	}
	
	function Draw() {
		if (!is_split) {
			draw_set_color(value);
			draw_rectangle(left_edge, top_edge, right_edge, bottom_edge, true);
		} else {
			for(var i = 0; i < 4; i++) {
				subtree[i].Draw();
			}
		}
	}
}