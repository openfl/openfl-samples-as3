package com.eclecticdesignstudio.motion.easing.equations {
	
	
	import com.eclecticdesignstudio.motion.easing.IEasing;
	
	
	/**
	 * @author Joshua Granick
	 */
	final public class SineEaseIn implements IEasing {
		
		
		public function calculate (k:Number):Number {
			
			return 1 - Math.cos(k * (Math.PI / 2));
			
		}
		
		
		public function ease (t:Number, b:Number, c:Number, d:Number):Number {
			
			return -c * Math.cos(t / d * (Math.PI / 2)) + c + b;
			
		}
		
		
	}
	
	
}