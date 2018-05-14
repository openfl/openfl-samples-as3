package com.eclecticdesignstudio.motion.actuators {
	
	
	/**
	 * @author Joshua Granick
	 */
	public class PropertyDetails{
		
		
		public var target:Object;
		public var propertyName:String;
		public var start:Number;
		public var change:Number;
		
		
		public function PropertyDetails (target:Object, propertyName:String, start:Number, change:Number):void {
			
			this.target = target;
			this.propertyName = propertyName;
			this.start = start;
			this.change = change;
			
		}
		
		
	}
	

}