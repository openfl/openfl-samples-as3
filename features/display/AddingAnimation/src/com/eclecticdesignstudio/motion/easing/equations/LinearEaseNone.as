package com.eclecticdesignstudio.motion.easing.equations {
	
	
	import com.eclecticdesignstudio.motion.easing.IEasing;
	
	
	/**
	 * @author Joshua Granick
	 */
	final public class LinearEaseNone implements IEasing {
		
		
		public function calculate (k:Number):Number {
			
			return k;
			
		}
		
		
		public function ease (t:Number, b:Number, c:Number, d:Number):Number {
			
			return c * t / d + b;
			
		}
		
		
	}
	
	
}