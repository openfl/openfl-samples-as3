package com.eclecticdesignstudio.motion.easing.equations {
	
	
	import com.eclecticdesignstudio.motion.easing.IEasing;
	
	
	/**
	 * @author Joshua Granick
	 */
	final public class ExpoEaseInOut implements IEasing {
		
		
		public function calculate (k:Number):Number {
			
			if (k == 0) { return 0; }
			if (k == 1) { return 1; }
			if ((k /= 1 / 2.0) < 1.0) {
				return 0.5 * Math.pow(2, 10 * (k - 1));
			}
			return 0.5 * (2 - Math.pow(2, -10 * --k));
			
		}
		
		
		public function ease (t:Number, b:Number, c:Number, d:Number):Number {
			
			if (t == 0) {
				return b;
			}
			if (t == d) {
				return b + c;
			}
			if ((t /= d / 2.0) < 1.0) {
				return c / 2 * Math.pow(2, 10 * (t - 1)) + b;
			}
			return c / 2 * (2 - Math.pow(2, -10 * --t)) + b;
			
		}
		
		
	}
	
	
}