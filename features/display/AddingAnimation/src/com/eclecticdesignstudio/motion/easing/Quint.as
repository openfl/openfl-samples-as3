package com.eclecticdesignstudio.motion.easing {
	
	
	import com.eclecticdesignstudio.motion.easing.equations.QuintEaseIn;
	import com.eclecticdesignstudio.motion.easing.equations.QuintEaseInOut;
	import com.eclecticdesignstudio.motion.easing.equations.QuintEaseOut;
	
	
	/**
	 * @author Joshua Granick
	 * @author Philippe / http://philippe.elsass.me
	 * @author Robert Penner / http://www.robertpenner.com/easing_terms_of_use.html
	 */
	final public class Quint {
		
		
		static public function get easeIn ():IEasing { return new QuintEaseIn (); }
		static public function get easeOut ():IEasing { return new QuintEaseOut (); }
		static public function get easeInOut ():IEasing { return new QuintEaseInOut (); }
		
		
	}

}