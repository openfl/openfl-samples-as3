package com.eclecticdesignstudio.motion.easing.equations {
	
	
	import com.eclecticdesignstudio.motion.easing.IEasing;
	
	
	/**
	 * @author Joshua Granick
	 */
	final public class ExpoEaseIn implements IEasing {
		
		
		public function calculate (k:Number):Number {
			
			return k == 0 ? 0 : Math.pow(2, 10 * (k - 1));
			
		}
		
		
		public function ease (t:Number, b:Number, c:Number, d:Number):Number {
			
			return t == 0 ? b : c * Math.pow(2, 10 * (t / d - 1)) + b;
			
		}
		
		
	}
	
	
}