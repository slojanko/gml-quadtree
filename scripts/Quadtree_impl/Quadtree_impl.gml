function Quadtree(rect_, max_depth_, value_) constructor {
	rect = rect_;
	max_depth = max_depth_;
	value = value_;
	
	// Cache edges
	left_edge = rect.position.x;
	top_edge = rect.position.y;
	right_edge = rect.position.x + rect.dimension.x;
	bottom_edge = rect.position.y + rect.dimension.y;
	
	value = value_;
	is_split = false;
	
	subtree = array_create(4, undefined);
	
	function SetValue(caster_) {
		// Skip if not split and values match
		if (is_split == false && value == caster_.value) {
			return;
		}
		
		// Skip if not overlapping circle
		if (caster_.IsOverlapping(rect) == false) {
			return;
		}
				
		// Skip if max depth reached
		if (max_depth <= 0) { 
			value = caster_.value;
			return;
		}
		
		// Optimize if whole tree is covered by circle
		if (caster_.IsInside(rect)) {
			if (is_split == true) {
				RemoveSubtrees();
			}
			value = caster_.value;
			return;
		}
			
		var previous_value = value;
		value = caster_.value;
			
		// Subdivide and repeat 
		if (is_split == false) {			
			// Top left | Top right | Bottom left | Bottom right
			subtree[0] = new Quadtree(new Rect(new Vector2(left_edge, top_edge), new Vector2(rect.dimension.x / 2, rect.dimension.y / 2)), max_depth - 1, previous_value);
			subtree[1] = new Quadtree(new Rect(new Vector2(left_edge + rect.dimension.x / 2, top_edge), new Vector2(rect.dimension.x / 2, rect.dimension.y / 2)), max_depth - 1, previous_value);
			subtree[2] = new Quadtree(new Rect(new Vector2(left_edge, top_edge + rect.dimension.y / 2), new Vector2(rect.dimension.x / 2, rect.dimension.y / 2)), max_depth - 1, previous_value);
			subtree[3] = new Quadtree(new Rect(new Vector2(left_edge + rect.dimension.x / 2, top_edge + rect.dimension.y / 2), new Vector2(rect.dimension.x / 2, rect.dimension.y / 2)), max_depth - 1, previous_value);
			is_split = true;
		}
				
		for(var i = 0; i < 4; i++) {
			subtree[i].SetValue(caster_);
		}
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
		// Return success if not split
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
	
	function GetTreeSize() {
		var size_ = 0;
		
		if (is_split == false) {
			size_ = 1;
		} else {
			for(var i = 0; i < 4; i++) {
				size_ += subtree[i].GetTreeSize();
			}
		}
			
		return size_;
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