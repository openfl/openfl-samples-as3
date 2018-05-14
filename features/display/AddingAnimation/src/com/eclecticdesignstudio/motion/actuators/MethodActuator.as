package com.eclecticdesignstudio.motion.actuators {
	
	
	import com.eclecticdesignstudio.motion.actuators.MotionInternal;
	
	use namespace MotionInternal;
	
	
	/**
	 * @author Joshua Granick
	 * @version 1.2
	 */
	public class MethodActuator extends SimpleActuator {
		
		
		protected var tweenProperties:Object = new Object ();
		
		
		public function MethodActuator (target:Object, duration:Number, properties:Object) {
			
			super (target, duration, properties);
			
			if (!properties.start) {
				
				properties.start = new Array ();
				
			}
			
			if (!properties.end) {
				
				properties.end = properties.start;
				
			}
			
		}
		
		
		MotionInternal override function apply ():void {
			
			(target as Function).apply (null, properties.end);
			
		}
		
		
		protected override function initialize ():void {
			
			var details:PropertyDetails;
			var propertyName:String;
			var start:Object;
			
			for (var i:uint = 0; i < (properties.start as Array).length; i++) {
				
				propertyName = "param" + i;
				start = properties.start[i];
				
				tweenProperties[propertyName] = start;
				
				if (start is Number) {
					
					details = new PropertyDetails (tweenProperties, propertyName, start as Number, Number (properties.end[i]) - (start as Number));
					propertyDetails.push (details);
					
				}
				
			}
			
			detailsLength = propertyDetails.length;
			initialized = true;
			
		}
		
		
		MotionInternal override function update (currentTime:Number):void {
			
			super.update (currentTime);
			
			var parameters:Array = new Array ();
			
			for (var i:uint = 0; i < properties.start.length; i++) {
				
				parameters.push (tweenProperties["param" + i]);
				
			}
			
			(target as Function).apply (null, parameters);
			
		}
		
		
	}
	

}