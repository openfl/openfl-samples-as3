package com.eclecticdesignstudio.motion.easing.equations {
	
	
	import com.eclecticdesignstudio.motion.easing.IEasing;
	
	
	/**
	 * @author Joshua Granick
	 */
	final public class BackEaseInOut implements IEasing {
		
		
		public var s:Number;
		
		
		public function BackEaseInOut (s:Number) {
			
			this.s = s;
			
		}
		
		
		public function calculate (k:Number):Number {
			
			if ((k /= 0.5) < 1) return 0.5 * (k * k * (((s *= (1.525)) + 1) * k - s));
			return 0.5 * ((k -= 2) * k * (((s *= (1.525)) + 1) * k + s) + 2);
			
		}
		
		
		public function ease (t:Number, b:Number, c:Number, d:Number):Number {
			
			if ((t/=d/2) < 1) return c/2*(t*t*(((s*=(1.525))+1)*t - s)) + b;
			return c/2*((t-=2)*t*(((s*=(1.525))+1)*t + s) + 2) + b;
			
		}
		
		
	}
	
	
}