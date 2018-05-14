package com.eclecticdesignstudio.motion.easing {
	
	
	import com.eclecticdesignstudio.motion.easing.equations.LinearEaseNone;
	
	
	/**
	 * @author Joshua Granick
	 * @author Philippe / http://philippe.elsass.me
	 * @author Robert Penner / http://www.robertpenner.com/easing_terms_of_use.html
	 */
	final public class Linear {
		
		
		static public function get easeNone ():IEasing { return new LinearEaseNone (); }
		
		
	}
	

}