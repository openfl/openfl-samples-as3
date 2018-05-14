package com.eclecticdesignstudio.motion.easing.equations {
	
	
	import com.eclecticdesignstudio.motion.easing.IEasing;
	
	
	/**
	 * @author Joshua Granick
	 */
	final public class CubicEaseInOut implements IEasing {
		
		
		public function calculate (k:Number):Number {
			
			return ((k /= 1 / 2) < 1) ? 0.5 * k * k * k : 0.5 * ((k -= 2) * k * k + 2);
			
		}
		
		
		public function ease (t:Number, b:Number, c:Number, d:Number):Number {
			
			return ((t /= d / 2) < 1) ? c / 2 * t * t * t + b : c / 2 * ((t -= 2) * t * t + 2) + b;
			
		}
		
		
	}
	
	
}