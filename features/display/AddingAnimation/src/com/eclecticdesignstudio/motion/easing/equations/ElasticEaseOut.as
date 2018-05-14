package com.eclecticdesignstudio.motion.easing.equations {
	
	
	import com.eclecticdesignstudio.motion.easing.IEasing;
	
	
	/**
	 * @author Joshua Granick
	 */
	final public class ElasticEaseOut implements IEasing {
		
		
		public var a:Number;
		public var p:Number;
		
		
		public function ElasticEaseOut (a:Number, p:Number) {
			
			this.a = a;
			this.p = p;
			
		}
		
		
		public function calculate (k:Number):Number {
			
			if (k == 0) return 0; if (k == 1) return 1; if (!p) p = 0.3;
			var s:Number;
			if (!a || a < 1) { a = 1; s = p / 4; }
			else s = p / (2 * Math.PI) * Math.asin (1 / a);
			return (a * Math.pow(2, -10 * k) * Math.sin((k - s) * (2 * Math.PI) / p ) + 1);
			
		}
		
		
		public function ease (t:Number, b:Number, c:Number, d:Number):Number {
			
			if (t == 0) {
				return b;
			}
			if ((t /= d) == 1) {
				return b + c;
			}
			if (!p) {
				p = d * 0.3;
			}
			var s:Number;
			if (!a || a < Math.abs(c)) {
				a = c;
				s = p / 4;
			}
			else {
				s = p / (2 * Math.PI) * Math.asin(c / a);
			}
			return a * Math.pow(2, -10 * t) * Math.sin((t * d - s) * (2 * Math.PI) / p) + c + b;
			
		}
		
		
	}
	
	
}