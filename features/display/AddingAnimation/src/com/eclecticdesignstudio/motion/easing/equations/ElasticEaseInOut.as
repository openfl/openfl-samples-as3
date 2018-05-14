package com.eclecticdesignstudio.motion.easing.equations {
	
	
	import com.eclecticdesignstudio.motion.easing.IEasing;
	
	
	/**
	 * @author Joshua Granick
	 */
	final public class ElasticEaseInOut implements IEasing {
		
		
		public var a:Number;
		public var p:Number;
		
		
		public function ElasticEaseInOut (a:Number, p:Number) {
			
			this.a = a;
			this.p = p;
			
		}
		
		public function calculate (k:Number):Number {
			
			if (k == 0) {
				return 0;
			}
			if ((k /= 1 / 2) == 2) {
				return 1;
			}
			
			var p:Number = (0.3 * 1.5);
			var a:Number = 1;
			var s:Number = p / 4;
			
			if (k < 1) {
				return -0.5 * (Math.pow(2, 10 * (k -= 1)) * Math.sin((k - s) * (2 * Math.PI) / p));
			}
			return Math.pow(2, -10 * (k -= 1)) * Math.sin((k - s) * (2 * Math.PI) / p) * 0.5 + 1;
			
		}
		
		
		public function ease (t:Number, b:Number, c:Number, d:Number):Number {
			
			if (t == 0) {
				return b;
			}
			if ((t /= d / 2) == 2) {
				return b + c;
			}
			if (!p) {
				p = d * (0.3 * 1.5);
			}
			var s:Number;
			if (!a || a < Math.abs(c)) {
				a = c;
				s = p / 4;
			}
			else {
				s = p / (2 * Math.PI) * Math.asin(c / a);
			}
			if (t < 1) {
				return -0.5 * (a * Math.pow(2, 10 * (t -= 1)) * Math.sin((t * d - s) * (2 * Math.PI) / p)) + b;
			}
			return a * Math.pow(2, -10 * (t -= 1)) * Math.sin((t * d - s) * (2 * Math.PI) / p) * 0.5 + c + b;
			
		}
		
		
	}
	
	
}