package com.eclecticdesignstudio.motion.easing.equations {
	
	
	import com.eclecticdesignstudio.motion.easing.IEasing;
	
	
	/**
	 * @author Joshua Granick
	 */
	final public class QuintEaseOut implements IEasing {
		
		
		public function calculate (k:Number):Number {
			
			return --k * k * k * k * k + 1;
			
		}
		
		
		public function ease (t:Number, b:Number, c:Number, d:Number):Number {
			
			return c * ((t = t / d - 1) * t * t * t * t + 1) + b;
			
		}
		
		
	}
	
	
}