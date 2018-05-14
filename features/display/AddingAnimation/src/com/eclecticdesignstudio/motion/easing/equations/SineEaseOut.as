package com.eclecticdesignstudio.motion.easing.equations {
	
	
	import com.eclecticdesignstudio.motion.easing.IEasing;
	
	
	/**
	 * @author Joshua Granick
	 */
	final public class SineEaseOut implements IEasing {
		
		
		public function calculate (k:Number):Number {
			
			return Math.sin(k * (Math.PI / 2));
			
		}
		
		
		public function ease (t:Number, b:Number, c:Number, d:Number):Number {
			
			return c * Math.sin(t / d * (Math.PI / 2)) + b;
			
		}
		
		
	}
	
	
}