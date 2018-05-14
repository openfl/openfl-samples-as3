package com.eclecticdesignstudio.motion.easing {
	
	
	import com.eclecticdesignstudio.motion.easing.equations.QuartEaseIn;
	import com.eclecticdesignstudio.motion.easing.equations.QuartEaseInOut;
	import com.eclecticdesignstudio.motion.easing.equations.QuartEaseOut;
	
	
	/**
	 * @author Joshua Granick
	 * @author Philippe / http://philippe.elsass.me
	 * @author Robert Penner / http://www.robertpenner.com/easing_terms_of_use.html
	 */
	final public class Quart {
		
		
		static public function get easeIn ():IEasing { return new QuartEaseIn (); }
		static public function get easeOut ():IEasing { return new QuartEaseOut (); }
		static public function get easeInOut ():IEasing { return new QuartEaseInOut (); }
		
		
	}
	

}