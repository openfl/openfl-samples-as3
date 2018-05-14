package com.eclecticdesignstudio.motion.easing {
	
	
	import com.eclecticdesignstudio.motion.easing.equations.BackEaseIn;
	import com.eclecticdesignstudio.motion.easing.equations.BackEaseInOut;
	import com.eclecticdesignstudio.motion.easing.equations.BackEaseOut;
	
	
	/**
	 * @author Joshua Granick
	 * @author Zeh Fernando, Nate Chatellier
	 * @author Robert Penner / http://www.robertpenner.com/easing_terms_of_use.html
	 */
	final public class Back {
		
		
		static public function get easeIn ():IEasing { return new BackEaseIn (1.70158); }
		static public function get easeOut ():IEasing { return new BackEaseOut (1.70158); }
		static public function get easeInOut ():IEasing { return new BackEaseInOut (1.70158); }
		
		
		static public function easeInWith (s:Number):IEasing {
			
			return new BackEaseIn (s);
			
		}
		
		
		static public function easeOutWith (s:Number):IEasing {
			
			return new BackEaseOut (s);
			
		}
		
		
		static public function easeInOutWith (s:Number):IEasing {
			
			return new BackEaseInOut (s);
			
		}
		
		
	}
	

}