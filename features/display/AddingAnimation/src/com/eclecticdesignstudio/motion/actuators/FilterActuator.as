package com.eclecticdesignstudio.motion.actuators {
	
	
	// import flash.display.DisplayObject;
	// import flash.filters.BitmapFilter;
	import openfl.display.DisplayObject;
	import openfl.filters.BitmapFilter;
	
	use namespace MotionInternal;
	
	
	/**
	 * @author Joshua Granick
	 * @version 1.2
	 */
	public class FilterActuator extends SimpleActuator {
		
		
		protected var filter:BitmapFilter;
		protected var filterClass:Class;
		protected var filterIndex:int = -1;
		
		
		public function FilterActuator (target:Object, duration:Number, properties:Object) {
			
			super (target, duration, properties);
			
			if (properties.filter is Class) {
				
				filterClass = properties.filter;
				
				for each (var filter:BitmapFilter in (target as DisplayObject).filters) {
					
					if (filter is filterClass) {
						
						this.filter = filter;
						
					}
					
				}
				
			} else {
				
				filterIndex = properties.filter;
				this.filter = (target as DisplayObject).filters [filterIndex];
				
			}
			
		}
		
		
		MotionInternal override function apply ():void {
			
			for (var propertyName:String in properties) {
				
				if (propertyName != "filter") {
					
					filter[propertyName] = properties[propertyName];
					
				}
				
			}
			
			var filters:Array = target.filters;
			filters[properties.filter] = filter;
			target.filters = filters;
			
		}
		
		
		protected override function initialize ():void {
			
			var details:PropertyDetails;
			var start:Number;
			
			for (var propertyName:String in properties) {
				
				if (propertyName != "filter") {
					
					start = Number (filter[propertyName]);
					details = new PropertyDetails (filter, propertyName, start, Number (properties[propertyName] - start));
					propertyDetails.push (details);
					
				}
				
			}
			
			detailsLength = propertyDetails.length;
			initialized = true;
			
		}
		
		
		MotionInternal override function update (currentTime:Number):void {
			
			super.update (currentTime);
			
			var filters:Array = (target as DisplayObject).filters;
			
			if (filterIndex > -1) {
				
				filters[properties.filter] = filter;
				
			} else {
				
				for (var i:uint = 0; i < filters.length; i++) {
					
					if (filters[i] is filterClass) {
						
						filters[i] = filter;
						
					}
					
				}
				
			}
			
			target.filters = filters;
			
		}
		
		
	}
	

}