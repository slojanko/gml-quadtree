function Rect(position_, dimension_) constructor {
	position = position_;
	dimension = dimension_;
	
	function GetCenter() {
		var center_ = new Vector2(position.x + dimension.x / 2, position.y + dimension.y / 2);
		return center_;
	}
}