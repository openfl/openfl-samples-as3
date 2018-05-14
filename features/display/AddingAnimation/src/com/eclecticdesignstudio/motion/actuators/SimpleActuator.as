package com.eclecticdesignstudio.motion.actuators {
	
	
	// import flash.display.DisplayObject;
	// import flash.display.Shape;
	// import flash.events.Event;
	// import flash.utils.Dictionary;
	// import flash.utils.getTimer;
	import openfl.display.DisplayObject;
	import openfl.display.Shape;
	import openfl.events.Event;
	// import openfl.utils.Dictionary;
	import openfl.utils.getTimer;
	
	use namespace MotionInternal;
	
	
	/**
	 * @author Joshua Granick
	 * @version 1.2
	 */
	public class SimpleActuator extends GenericActuator {
		
		
		MotionInternal var timeOffset:Number;
		
		protected static var actuators:Array = new Array ();
		protected static var actuatorsLength:uint = 0;
		protected static var shape:Shape;
		
		protected var active:Boolean = true;
		protected var cacheVisible:Boolean;
		protected var detailsLength:uint;
		protected var initialized:Boolean;
		protected var paused:Boolean;
		protected var pauseTime:Number;
		protected var propertyDetails:Array = new Array ();
		protected var sendChange:Boolean = false;
		protected var setVisible:Boolean;
		protected var startTime:Number = getTimer () / 1000;
		protected var toggleVisible:Boolean;
		
		
		public function SimpleActuator (target:Object, duration:Number, properties:Object) {
			
			super (target, duration, properties);
			
			if (!shape) {
				
				shape = new Shape ();
				shape.addEventListener (Event.ENTER_FRAME, shape_onEnterFrame);
				
			}
			
		}
		
		
		/**
		 * @inheritDoc
		 */
		public override function autoVisible (value:Boolean = true):GenericActuator {
			
			MotionInternal::autoVisible = value;
			
			if (!value) {
				
				toggleVisible = false;
				
				if (setVisible) {
					
					target.visible = cacheVisible;
					
				}
				
			}
			
			return this;
			
		}
		
		
		/**
		 * @inheritDoc
		 */
		public override function delay (duration:Number):GenericActuator {
			
			MotionInternal::delay = duration;
			timeOffset = startTime + duration;
			
			return this;
			
		}
		
		
		protected function initialize ():void {
			
			var details:PropertyDetails;
			var start:Number;
			
			for (var propertyName:String in properties) {
				
				start = Number (target[propertyName]);
				details = new PropertyDetails (target, propertyName, start, Number (properties[propertyName] - start));
				propertyDetails.push (details);
				
			}
			
			detailsLength = propertyDetails.length;
			initialized = true;
			
		}
		
		
		MotionInternal override function move ():void {
			
			toggleVisible = ("alpha" in properties && target is DisplayObject);
			
			if (toggleVisible && !target.visible && properties.alpha != 0) {
				
				setVisible = true;
				cacheVisible = target.visible;
				target.visible = true;
				
			}
			
			timeOffset = startTime;
			actuators.push (this);
			++actuatorsLength;
			
		}
		
		
		/**
		 * @inheritDoc
		 */
		public override function onUpdate (handler:Function, ... parameters:Array):GenericActuator {
			
			MotionInternal::onUpdate = handler;
			MotionInternal::onUpdateParams = parameters;
			sendChange = true;
			
			return this;
			
		}
		
		
		MotionInternal override function pause ():void {
			
			paused = true;
			pauseTime = getTimer ();
			
		}
		
		
		MotionInternal override function resume ():void {
			
			if (paused) {
				
				paused = false;
				timeOffset += (getTimer () - pauseTime) / 1000;
				
			}
			
		}
		
		
		MotionInternal override function stop (properties:Object, complete:Boolean, sendEvent:Boolean):void {
			
			if (active) {
				
				for (var propertyName:String in properties) {
					
					if (propertyName in this.properties) {
						
						active = false;
						
						if (complete) {
							
							apply ();
							
						}
						
						this.complete (sendEvent);
						return;
						
					}
					
				}
				
				if (!properties) {
					
					active = false;
					
					if (complete) {
						
						apply ();
						
					}
					
					this.complete (sendEvent);
					return;
					
				}
				
			}
			
		}
		
		
		MotionInternal function update (currentTime:Number):void {
			
			if (!paused) {
				
				var details:PropertyDetails;
				var easing:Number;
				var i:uint;
				
				var tweenPosition:Number = (currentTime - timeOffset) / duration;
				
				if (tweenPosition > 1) {
					
					tweenPosition = 1;
					
				}
				
				if (!initialized) {
					
					initialize ();
					
				}
				
				if (!MotionInternal::special) {
					
					easing = MotionInternal::ease.calculate (tweenPosition);
					
					for (i = 0; i < detailsLength; ++i) {
						
						details = propertyDetails[i];
						details.target[details.propertyName] = details.start + (details.change * easing);
						
					}
					
				} else {
					
					if (!MotionInternal::reverse) {
						
						easing = MotionInternal::ease.calculate (tweenPosition);
						
					} else {
						
						easing = MotionInternal::ease.calculate (1 - tweenPosition);
						
					}
					
					var endValue:Number;
					
					for (i = 0; i < detailsLength; ++i) {
						
						details = propertyDetails[i];
						
						if (MotionInternal::smartRotation && (details.propertyName == "rotation" || details.propertyName == "rotationX" || details.propertyName == "rotationY" || details.propertyName == "rotationZ")) {
							
							var rotation:Number = details.change % 360;
							
							if (rotation > 180) {
								
								rotation -= 360;
								
							} else if (rotation < -180) {
								
								rotation += 360;
								
							}
							
							endValue = details.start + rotation * easing;
							
						} else {
							
							endValue = details.start + (details.change * easing);
							
						}
						
						if (!MotionInternal::snapping) {
							
							details.target[details.propertyName] = endValue;
							
						} else {
							
							details.target[details.propertyName] = Math.round (endValue);
							
						}
						
					}
					
				}
				
				if (tweenPosition === 1) {
					
					if (MotionInternal::repeat === 0) {
						
						active = false;
						
						if (toggleVisible && target.alpha === 0) {
							
							target.visible = false;
							
						}
						
						complete (true);
						return;
						
					} else {
						
						if (MotionInternal::reflect) {
							
							MotionInternal::reverse = !MotionInternal::reverse;
							
						}
						
						startTime = currentTime;
						timeOffset = startTime + MotionInternal::delay;
						
						if (MotionInternal::repeat > 0) {
							
							MotionInternal::repeat --;
							
						}
						
					}
					
				}
				
				if (sendChange) {
					
					change ();
					
				}
				
			}
			
		}
		
		
		
		
		// Event Handlers
		
		
		
		
		protected static function shape_onEnterFrame (event:Event):void {
			
			var currentTime:Number = getTimer () / 1000;
			
			var actuator:SimpleActuator;
			
			for (var i:uint = 0; i < actuatorsLength; i++) {
				
				actuator = actuators[i];
				
				if (actuator.active) {
					
					if (currentTime > actuator.timeOffset) {
						
						actuator.MotionInternal::update (currentTime);
						
					}
					
				} else {
					
					actuators.splice (i, 1);
					--actuatorsLength;
					i --;
					
				}
				
			}
			
		}
		
		
	}
	
	
}