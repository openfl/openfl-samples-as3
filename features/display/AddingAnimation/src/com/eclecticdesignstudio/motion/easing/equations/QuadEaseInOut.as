package com.eclecticdesignstudio.motion.easing.equations {
	
	
	import com.eclecticdesignstudio.motion.easing.IEasing;
	
	
	/**
	 * @author Joshua Granick
	 */
	final public class QuadEaseInOut implements IEasing {
		
		
		public function calculate (k:Number):Number {
			
			if ((k *= 2) < 1) {
				return 1 / 2 * k * k;
			}
			return -1 / 2 * ((--k) * (k - 2) - 1);
			
		}
		
		
		public function ease (t:Number, b:Number, c:Number, d:Number):Number {
			
			if ((t /= d / 2) < 1) {
				return c / 2 * t * t + b;
			}
			return -c / 2 * ((--t) * (t - 2) - 1) + b;
			
		}
		
		
	}
	
	
}