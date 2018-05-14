package com.eclecticdesignstudio.motion.easing {
	
	
	import com.eclecticdesignstudio.motion.easing.equations.SineEaseIn;
	import com.eclecticdesignstudio.motion.easing.equations.SineEaseInOut;
	import com.eclecticdesignstudio.motion.easing.equations.SineEaseOut;
	
	
	/**
	 * @author Joshua Granick
	 * @author Robert Penner / http://www.robertpenner.com/easing_terms_of_use.html
	 */
	final public class Sine {
		
		
		static public function get easeIn ():IEasing { return new SineEaseIn (); }
		static public function get easeOut ():IEasing { return new SineEaseOut (); }
		static public function get easeInOut ():IEasing { return new SineEaseInOut (); }
		
		
	}
	
	
}