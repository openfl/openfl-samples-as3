package com.eclecticdesignstudio.motion.easing.equations {
	
	
	import com.eclecticdesignstudio.motion.easing.IEasing;
	
	
	/**
	 * @author Joshua Granick
	 */
	final public class BackEaseIn implements IEasing {
		
		
		public var s:Number;
		
		
		public function BackEaseIn (s:Number) {
			
			this.s = s;
			
		}
		
		
		public function calculate (k:Number):Number {
			
			return k * k * ((s + 1) * k - s);
			
		}
		
		
		public function ease (t:Number, b:Number, c:Number, d:Number):Number {
			
			return c*(t/=d)*t*((s+1)*t - s) + b;
			
		}
		
		
	}
	
	
}