package com.eclecticdesignstudio.motion.easing.equations {
	
	
	import com.eclecticdesignstudio.motion.easing.IEasing;
	
	
	/**
	 * @author Joshua Granick
	 */
	final public class QuintEaseIn implements IEasing {
		
		
		public function calculate (k:Number):Number {
			
			return k * k * k * k * k;
			
		}
		
		
		public function ease (t:Number, b:Number, c:Number, d:Number):Number {
			
			return c * (t /= d) * t * t * t * t + b;
			
		}
		
		
	}
	
	
}