function Vector2(x_, y_) constructor {
	x = x_;
	y = y_;
	
	function Add(other_) {
		x += other_.x;
		y += other_.y;
	}
	
	function Subtract(other_) {
		x -= other_.x;
		y -= other_.y;
	}
	
	function Multiply(other_) {
		x *= other_;
		y *= other_;
	}
	
	function Divide(other_) {
		x /= other_;
		y /= other_;
	}
	
	function DotProduct(other_) {
		return (x * other_.x + y * other_.y);
	}
	
	function Length() {
		return sqrt(x * x + y * y);
	}
}