enum PerformanceFormat {
	s = 1000000, 
	ms = 1000, 
	ns = 1
}

function Performance() constructor{
	this.time_taken = 0;
	this.start_time = 0;
	this.end_time = 0;
	this.is_ticking = false;
	this.longest_time_taken = 0;
	
	function Start() {
		if (is_ticking == false) {
			this.start_time = get_timer();
			this.is_ticking = true;
		}
	}
	
	function End() {
		if (this.is_ticking == true) {
			this.end_time = get_timer();
			this.time_taken = this.end_time - this.start_time;
			if (this.time_taken > this.longest_time_taken) {
				this.longest_time_taken = this.time_taken;
			}	
			this.is_ticking = false;
		}
	}
		
	function Reset() {	
		this.time_taken = 0;
		this.start_time = 0;
		this.end_time = 0;
		this.is_ticking = false;
		this.longest_time_taken = 0;
	}
	
	function GetTime(performance_format_) {
		return this.time_taken / performance_format_;
	}
	
	function GetLongestTime(performance_format_) {
		return this.longest_time_taken / performance_format_;
	}
}