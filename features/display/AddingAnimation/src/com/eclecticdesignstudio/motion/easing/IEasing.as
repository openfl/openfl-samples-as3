package com.eclecticdesignstudio.motion.easing {
	
	
	/**
	 * @author Joshua Granick
	 * @author Philippe / http://philippe.elsass.me
	 */
	public interface IEasing {
		
		
		function calculate (k:Number):Number;
		function ease (t:Number, b:Number, c:Number, d:Number):Number;
		
		
	}
	
	
}