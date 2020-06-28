function Vector2(x_, y_) constructor {
	this.x = x_;
	this.y = y_;
	
	function Add(other_) {
		this.x += other_.x;
		this.y += other_.y;
	}
	
	function Subtract(other_) {
		this.x -= other_.x;
		this.y -= other_.y;
	}
	
	function Multiply(other_) {
		this.x *= other_;
		this.y *= other_;
	}
	
	function DotProduct(other_) {
		return (this.x * other_.x + this.y * other_.y);
	}
	
	function Length() {
		return sqrt(this.x * this.x + this.y * this.y);
	}
}