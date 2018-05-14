package com.eclecticdesignstudio.motion.easing {
	
	
	import com.eclecticdesignstudio.motion.easing.equations.ExpoEaseIn;
	import com.eclecticdesignstudio.motion.easing.equations.ExpoEaseInOut;
	import com.eclecticdesignstudio.motion.easing.equations.ExpoEaseOut;
	
	
	/**
	 * @author Joshua Granick
	 * @author Robert Penner / http://www.robertpenner.com/easing_terms_of_use.html
	 */
	final public class Expo {
		
		
		static public function get easeIn ():IEasing { return new ExpoEaseIn (); }
		static public function get easeOut ():IEasing { return new ExpoEaseOut (); }
		static public function get easeInOut ():IEasing { return new ExpoEaseInOut (); }
		
		
	}
	

}