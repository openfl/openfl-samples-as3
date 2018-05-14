package com.eclecticdesignstudio.motion.actuators {
	
	
	import com.eclecticdesignstudio.motion.easing.IEasing;
	import com.eclecticdesignstudio.motion.Actuate;
	// import flash.events.Event;
	import openfl.events.Event;
	
	use namespace MotionInternal;
	
	
	/**
	 * @author Joshua Granick
	 * @version 1.2
	 */
	public class GenericActuator {
		
		
		MotionInternal var duration:Number;
		MotionInternal var properties:Object;
		MotionInternal var target:Object;
		
		MotionInternal var autoVisible:Boolean = true;
		MotionInternal var delay:Number = 0;
		MotionInternal var ease:IEasing;
		MotionInternal var onUpdate:Function;
		MotionInternal var onUpdateParams:Array;
		MotionInternal var onComplete:Function;
		MotionInternal var onCompleteParams:Array;
		MotionInternal var reflect:Boolean = false;
		MotionInternal var repeat:int = 0;
		MotionInternal var reverse:Boolean = false;
		MotionInternal var smartRotation:Boolean = false;
		MotionInternal var snapping:Boolean = false;
		MotionInternal var special:Boolean = false;
		
		
		public function GenericActuator (target:Object, duration:Number, properties:Object) {
			
			this.target = target;
			this.properties = properties;
			this.duration = duration;
			
			MotionInternal::ease = Actuate.defaultEase;
			
		}
		
		
		MotionInternal function apply ():void {
			
			for (var propertyName:String in properties) {
				
				target[propertyName] = properties[propertyName];
				
			}
			
		}
		
		
		/**
		 * Flash performs faster when objects are set to visible = false rather than only alpha = 0. autoVisible toggles automatically based on alpha values
		 * @param	value		Whether autoVisible should be enabled (Default is true)
		 * @return		The current actuator instance
		 */
		public function autoVisible (value:Boolean = true):GenericActuator {
			
			MotionInternal::autoVisible = value;
			
			return this;
			
		}
		
		
		protected function change ():void {
			
			if (MotionInternal::onUpdate != null) {
				
				MotionInternal::onUpdate.apply (null, MotionInternal::onUpdateParams);
				
			}
			
		}
		
		
		protected function complete (sendEvent:Boolean = true):void {
			
			if (sendEvent) {
				
				change ();
				
				if (MotionInternal::onComplete != null) {
					
					MotionInternal::onComplete.apply (null, MotionInternal::onCompleteParams);
					
				}
				
			}
			
			Actuate.unload (this);
			
		}
		
		
		/**
		 * Increases the delay before a tween is executed
		 * @param	duration		The amount of seconds to delay
		 * @return		The current actuator instance
		 */
		public function delay (duration:Number):GenericActuator {
			
			MotionInternal::delay = duration;
			
			return this;
			
		}
		
		
		/**
		 * Sets the easing which is used when running the tween
		 * @param	easing		An easing equation, like Elastic.easeIn or Quad.easeOut
		 * @return		The current actuator instance
		 */
		public function ease (easing:IEasing):GenericActuator {
			
			MotionInternal::ease = easing;
			
			return this;
			
		}
		
		
		MotionInternal function move ():void {
			
			
			
		}
		
		
		/**
		 * Defines a function which will be called when the tween updates
		 * @param	handler		The function you would like to be called
		 * @param	parameters		Parameters you would like to pass to the handler function when it is called
		 * @return		The current actuator instance
		 */
		public function onUpdate (handler:Function, ... parameters:Array):GenericActuator {
			
			MotionInternal::onUpdate = handler;
			MotionInternal::onUpdateParams = parameters;
			
			return this;
			
		}
		
		
		/**
		 * Defines a function which will be called when the tween finishes
		 * @param	handler		The function you would like to be called
		 * @param	parameters		Parameters you would like to pass to the handler function when it is called
		 * @return		The current actuator instance
		 */
		public function onComplete (handler:Function, ... parameters:Array):GenericActuator {
			
			MotionInternal::onComplete = handler;
			MotionInternal::onCompleteParams = parameters;
			
			if (MotionInternal::duration == 0) {
				
				complete ();
				
			}
			
			return this;
			
		}
		
		
		MotionInternal function pause ():void {
			
			
			
		}
		
		
		/**
		 * Automatically changes the reverse value when the tween repeats. Repeat must be enabled for this to have any effect
		 * @param	value		Whether reflect should be enabled (Default is true)
		 * @return		The current actuator instance
		 */
		public function reflect (value:Boolean = true):GenericActuator {
			
			MotionInternal::reflect = true;
			MotionInternal::special = true;
			
			return this;
			
		}
		
		
		/**
		 * Repeats the tween after it finishes
		 * @param	times		The number of times you would like the tween to repeat, or -1 if you would like to repeat the tween indefinitely (Default is -1)
		 * @return		The current actuator instance
		 */
		public function repeat (times:int = -1):GenericActuator {
			
			MotionInternal::repeat = times;
			
			return this;
			
		}
		
		
		MotionInternal function resume ():void {
			
			
			
		}
		
		
		/**
		 * Sets if the tween should be handled in reverse
		 * @param	value		Whether the tween should be reversed (Default is true)
		 * @return		The current actuator instance
		 */
		public function reverse (value:Boolean = true):GenericActuator {
			
			MotionInternal::reverse = value;
			special = true;
			
			return this;
			
		}
		
		
		/**
		 * Enabling smartRotation can prevent undesired results when tweening rotation values
		 * @param	value		Whether smart rotation should be enabled (Default is true)
		 * @return		The current actuator instance
		 */
		public function smartRotation (value:Boolean = true):GenericActuator {
			
			MotionInternal::smartRotation = value;
			special = true;
			
			return this;
			
		}
		
		
		/**
		 * Snapping causes tween values to be rounded automatically
		 * @param	value		Whether tween values should be rounded (Default is true)
		 * @return		The current actuator instance
		 */
		public function snapping (value:Boolean = true):GenericActuator {
			
			MotionInternal::snapping = value;
			special = true;
			
			return this;
			
		}
		
		
		MotionInternal function stop (properties:Object, complete:Boolean, sendEvent:Boolean):void {
			
			
			
		}
		
		
	}
	
	
}