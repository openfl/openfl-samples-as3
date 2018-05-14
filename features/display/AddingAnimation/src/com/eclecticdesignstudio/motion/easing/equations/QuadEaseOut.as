package com.eclecticdesignstudio.motion.easing.equations {
	
	
	import com.eclecticdesignstudio.motion.easing.IEasing;
	
	
	/**
	 * @author Joshua Granick
	 */
	final public class QuadEaseOut implements IEasing {
		
		
		public function calculate (k:Number):Number {
			
			return -k * (k - 2);
			
		}
		
		
		public function ease (t:Number, b:Number, c:Number, d:Number):Number {
			
			return -c * (t /= d) * (t - 2) + b;
			
		}
		
		
	}
	
	
}