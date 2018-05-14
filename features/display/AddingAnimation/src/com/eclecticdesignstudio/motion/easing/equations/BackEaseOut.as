package com.eclecticdesignstudio.motion.easing.equations {
	
	
	import com.eclecticdesignstudio.motion.easing.IEasing;
	
	
	/**
	 * @author Joshua Granick
	 */
	final public class BackEaseOut implements IEasing {
		
		
		public var s:Number;
		
		
		public function BackEaseOut (s:Number) {
			
			this.s = s;
			
		}
		
		
		public function calculate (k:Number):Number {
			
			return ((k = k - 1) * k * ((s + 1) * k + s) + 1);
			
		}
		
		
		public function ease (t:Number, b:Number, c:Number, d:Number):Number {
			
			return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;
			
		}
		
		
	}
	
	
}