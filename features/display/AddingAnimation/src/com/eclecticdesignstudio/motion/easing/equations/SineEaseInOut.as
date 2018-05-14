package com.eclecticdesignstudio.motion.easing.equations {
	
	
	import com.eclecticdesignstudio.motion.easing.IEasing;
	
	
	/**
	 * @author Joshua Granick
	 */
	final public class SineEaseInOut implements IEasing {
		
		
		public function calculate (k:Number):Number {
			
			return - (Math.cos(Math.PI * k) - 1) / 2;
			
		}
		
		
		public function ease (t:Number, b:Number, c:Number, d:Number):Number {
			
			return -c / 2 * (Math.cos(Math.PI * t / d) - 1) + b;
			
		}
		
		
	}
	
	
}