package com.eclecticdesignstudio.motion.easing.equations {
	
	
	import com.eclecticdesignstudio.motion.easing.IEasing;
	
	
	/**
	 * @author Joshua Granick
	 */
	final public class ExpoEaseOut implements IEasing {
		
		
		public function calculate (k:Number):Number {
			
			return k == 1 ? 1 : (1 - Math.pow(2, -10 * k));
			
		}
		
		
		public function ease (t:Number, b:Number, c:Number, d:Number):Number {
			
			return t == d ? b + c : c * (1 - Math.pow(2, -10 * t / d)) + b;
			
		}
		
		
	}
	
	
}