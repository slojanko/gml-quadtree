function Rect(position_, dimension_) constructor {
	this.position = position_;
	this.dimension = dimension_;
	
	function GetCenter() {
		var center_ = new Vector2(this.position.x + this.dimension.x / 2, this.position.y + this.dimension.y / 2);
		return center_;
	}
}