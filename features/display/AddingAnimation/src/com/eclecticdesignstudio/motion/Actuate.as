package com.eclecticdesignstudio.motion {
	
	
	import com.eclecticdesignstudio.motion.actuators.GenericActuator;
	import com.eclecticdesignstudio.motion.actuators.MethodActuator;
	import com.eclecticdesignstudio.motion.actuators.MotionInternal;
	import com.eclecticdesignstudio.motion.actuators.MotionPathActuator;
	import com.eclecticdesignstudio.motion.actuators.SimpleActuator;
	import com.eclecticdesignstudio.motion.actuators.TransformActuator;
	import com.eclecticdesignstudio.motion.easing.Expo;
	import com.eclecticdesignstudio.motion.easing.IEasing;
	// import flash.display.DisplayObject;
	// import flash.events.Event;
	// import flash.utils.Dictionary;
	import openfl.display.DisplayObject;
	import openfl.events.Event;
	// import openfl.utils.Dictionary;
	
	
	use namespace MotionInternal;
	
	
	/**
	 * @author Joshua Granick
	 * @version 1.23
	 */
	public class Actuate {
		
		
		public static var defaultActuator:Class = SimpleActuator;
		public static var defaultEase:IEasing = Expo.easeOut;
		// private static var targetLibraries:Dictionary = new Dictionary (true);
		private static var targetLibraries:Object = new Object ();
		
		
		/**
		 * Copies properties from one object to another. Conflicting tweens are stopped automatically
		 * @example		<code>Actuate.apply (MyClip, { alpha: 1 } );</code>
		 * @param	target		The object to copy to
		 * @param	properties		The object to copy from
		 * @param	customActuator		A custom actuator to use instead of the default (Optional)
		 * @return		The current actuator instance, which can be used to apply properties like onComplete or onUpdate handlers
		 */
		public static function apply (target:Object, properties:Object, customActuator:Class = null):GenericActuator {
			
			stop (target, properties);
			
			var actuateClass:Class = customActuator || defaultActuator;
			var actuator:GenericActuator = new actuateClass (target, 0, properties);
			
			actuator.MotionInternal::apply ();
			
			return actuator;
			
		}
		
		
		/**
		 * Creates a new effects tween 
		 * @param	target		The object to tween
		 * @param	duration		The length of the tween in seconds
		 * @param	overwrite		Sets whether previous tweens for the same target and properties will be overwritten (Default is true)
		 * @return		An EffectsOptions instance, which is used to select the kind of effect you would like to apply to the target
		 */
		public static function effects (target:DisplayObject, duration:Number, overwrite:Boolean = true):EffectsOptions {
			
			return new EffectsOptions (target, duration, overwrite);
			
		}
		
		
		private static function getLibrary (target:Object):/*Dictionary*/ Object {
			
			if (!targetLibraries[target]) {
				
				targetLibraries[target] = /*new Dictionary (true);*/ new Object ();
				
			}
			
			return targetLibraries[target];
			
		}
		
		
		/**
		 * Creates a new MotionPath tween
		 * @param	target		The object to tween
		 * @param	duration		The length of the tween in seconds
		 * @param	properties		An object containing a motion path for each property you wish to tween
		 * @param	overwrite		Sets whether previous tweens for the same target and properties will be overwritten (Default is true)
		 * @return		The current actuator instance, which can be used to apply properties like ease, delay, onComplete or onUpdate
		 */
		public static function motionPath (target:Object, duration:Number, properties:Object, overwrite:Boolean = true):GenericActuator {
			
			return tween (target, duration, properties, overwrite, MotionPathActuator);
			
		}
		
		
		/**
		 * Pauses tweens for the specified target objects
		 * @param	... targets		The target objects which will have their tweens paused. Passing no value pauses tweens for all objects
		 */
		public static function pause (... targets:Array):void {
			
			var actuator:GenericActuator;
			var library:/*Dictionary*/ Object;
			
			if (targets.length > 0) {
				
				for each (var target:Object in targets) {
					
					library = getLibrary (target);
					
					for each (actuator in library) {
						
						actuator.MotionInternal::pause ();
						
					}
					
				}
				
			} else {
				
				for each (library in targetLibraries) {
					
					for each (actuator in library) {
						
						actuator.MotionInternal::pause ();
						
					}
					
				}
				
			}
			
		}
		
		
		/**
		 * Resets Actuate by stopping and removing tweens for all objects
		 */
		public static function reset ():void {
			
			var actuator:GenericActuator;
			var library:/*Dictionary*/ Object;
			
			for each (library in targetLibraries) {
				
				for each (actuator in library) {
					
					actuator.MotionInternal::stop (null, false, false);
					
				}
				
			}
			
			targetLibraries = /*new Dictionary (true);*/ new Object ();
			
		}
		
		
		/**
		 * Resumes paused tweens for the specified target objects
		 * @param	... targets		The target objects which will have their tweens resumed. Passing no value resumes tweens for all objects
		 */
		public static function resume (... targets:Array):void {
			
			var actuator:GenericActuator;
			var library:/*Dictionary*/ Object;
			
			if (targets.length > 0) {
				
				for each (var target:Object in targets) {
					
					library = getLibrary (target);
					
					for each (actuator in library) {
						
						actuator.MotionInternal::resume ();
						
					}
					
				}
				
			} else {
				
				for each (library in targetLibraries) {
					
					for each (actuator in library) {
						
						actuator.MotionInternal::resume ();
						
					}
					
				}
				
			}
			
		}
		
		
		/**
		 * Stops all tweens for an individual object
		 * @param	target		The target object which will have its tweens stopped
		 * @param  properties		A string, array or object which contains the properties you wish to stop, like "alpha", [ "x", "y" ] or { alpha: null }. Passing no value removes all tweens for the object (Optional)
		 * @param	complete		If tweens should apply their final target values before stopping. Default is false (Optional) 
		 */
		public static function stop (target:Object, properties:Object = null, complete:Boolean = false):void {
			
			if (target) {
				
				var actuator:GenericActuator;
				var library:/*Dictionary*/ Object = getLibrary (target);
				
				var temp:Object;
				
				if (properties is String) {
					
					temp = new Object ();
					temp[properties] = null;
					properties = temp;
					
				} else if (properties is Array) {
					
					temp = new Object ();
					
					for each (var propertyName:String in properties) {
						
						temp[propertyName] = null;
						
					}
					
					properties = temp;
					
				}
				
				for each (actuator in library) {
					
					actuator.MotionInternal::stop (properties, complete, true);
					
				}
				
			}
			
		}
		
		
		/**
		 * Creates a tween-based timer, which is useful for synchronizing function calls with other animations
		 * @example		<code>Actuate.timer (1).onComplete (trace, "Timer is now complete");</code>
		 * @param	duration		The length of the timer in seconds
		 * @param	customActuator		A custom actuator to use instead of the default (Optional)
		 * @return		The current actuator instance, which can be used to apply properties like onComplete or to gain a reference to the target timer object
		 */
		public static function timer (duration:Number, customActuator:Class = null):GenericActuator {
			
			return tween (new TweenTimer (0), duration, new TweenTimer (1), false, customActuator);
			
		}
		
		
		/**
		 * Creates a new transform tween
		 * @example		<code>Actuate.transform (MyClip, 1).color (0xFF0000);</code>
		 * @param	target		The object to tween
		 * @param	duration		The length of the tween in seconds
		 * @param	overwrite		Sets whether previous tweens for the same target and properties will be overwritten (Default is true)
		 * @return		A TransformOptions instance, which is used to select the kind of transform you would like to apply to the target
		 */
		public static function transform (target:Object, duration:Number = 0, overwrite:Boolean = true):TransformOptions {
			
			return new TransformOptions (target, duration, overwrite);
			
		}
		
		
		/**
		 * Creates a new tween
		 * @example		<code>Actuate.tween (MyClip, 1, { alpha: 1 } ).onComplete (trace, "MyClip is now visible");</code>
		 * @param	target		The object to tween
		 * @param	duration		The length of the tween in seconds
		 * @param	properties		The end values to tween the target to
		 * @param	overwrite			Sets whether previous tweens for the same target and properties will be overwritten (Default is true)
		 * @param	customActuator		A custom actuator to use instead of the default (Optional)
		 * @return		The current actuator instance, which can be used to apply properties like ease, delay, onComplete or onUpdate
		 */ 
		public static function tween (target:Object, duration:Number, properties:Object, overwrite:Boolean = true, customActuator:Class = null):GenericActuator {
			
			if (target) {
				
				if (duration > 0) {
					
					var actuateClass:Class = customActuator || defaultActuator;
					var actuator:GenericActuator = new actuateClass (target, duration, properties);
					
					var library:/*Dictionary*/ Object = getLibrary (actuator.target);
					
					if (overwrite) {
						
						for each (var childActuator:GenericActuator in library) {
							
							childActuator.MotionInternal::stop (actuator.properties, false, false);
							
						}
						
					}
					
					library[actuator] = actuator;
					actuator.MotionInternal::move ();
					
					return actuator;
					
				} else {
					
					return apply (target, properties, customActuator);
					
				}
				
			}
			
			return null;
			
		}
		
		
		MotionInternal static function unload (actuator:GenericActuator):void {
			
			var library:/*Dictionary*/ Object = getLibrary (actuator.target);
			delete library[actuator];
			
		}
		
		
		/**
		 * Creates a new tween that updates a method rather than setting the properties of an object
		 * @example		<code>Actuate.update (trace, 1, ["Value: ", 0], ["", 1]).onComplete (trace, "Finished tracing values between 0 and 1");</code>
		 * @param	target		The method to update		
		 * @param	duration		The length of the tween in seconds
		 * @param	start		The starting parameters of the method call. You may use both numeric and non-numeric values
		 * @param	end		The ending parameters of the method call. You may use both numeric and non-numeric values, but the signature should match the start parameters
		 * @param	overwrite		Sets whether previous tweens for the same target and properties will be overwritten (Default is true)
		 * @return		The current actuator instance, which can be used to apply properties like ease, delay, onComplete or onUpdate
		 */
		public static function update (target:Function, duration:Number, start:Array = null, end:Array = null, overwrite:Boolean = true):GenericActuator {
			
			var properties:Object = { start: start, end: end };
			
			return tween (target, duration, properties, overwrite, MethodActuator);
			
		}
		
		
	}
	
	
}


import com.eclecticdesignstudio.motion.actuators.FilterActuator;
import com.eclecticdesignstudio.motion.actuators.GenericActuator;
import com.eclecticdesignstudio.motion.actuators.TransformActuator;
import com.eclecticdesignstudio.motion.Actuate;
// import flash.display.DisplayObject;
// import flash.filters.BitmapFilter;
// import flash.filters.ColorMatrixFilter;
// import flash.geom.Matrix;
import openfl.display.DisplayObject;
import openfl.filters.BitmapFilter;
import openfl.filters.ColorMatrixFilter;
import openfl.geom.Matrix;


class EffectsOptions {
	
	
	protected var duration:Number;
	protected var overwrite:Boolean;
	protected var target:DisplayObject;
	
	
	public function EffectsOptions (target:DisplayObject, duration:Number, overwrite:Boolean) {
		
		this.target = target;
		this.duration = duration;
		this.overwrite = overwrite;
		
	}
	
	
	/**
	 * Creates a new BitmapFilter tween
	 * @param	reference		A reference to the target's filter, which can be an array index or the class of the filter
	 * @param	properties		The end properties to use for the tween
	 * @return		The current actuator instance, which can be used to apply properties like ease, delay, onComplete or onUpdate
	 */
	public function filter (reference:*, properties:Object):GenericActuator {
		
		properties.filter = reference;
		
		return Actuate.tween (target, duration, properties, overwrite, FilterActuator);
		
	}
	
	
}


class TransformOptions {
	
	
	protected var duration:Number;
	protected var overwrite:Boolean;
	protected var target:Object;
	
	
	public function TransformOptions (target:Object, duration:Number, overwrite:Boolean) {
		
		this.target = target;
		this.duration = duration;
		this.overwrite = overwrite;
		
	}
	
	
	/**
	 * Creates a new ColorTransform tween
	 * @param	color		The color value
	 * @param	strength		The percentage amount of tint to apply (Default is 1)
	 * @param	alpha		The end alpha of the target. If you wish to tween alpha and tint simultaneously, you must do them both as part of the ColorTransform. A value of null will make no change to the alpha of the object (Default is null)
	 * @return		The current actuator instance, which can be used to apply properties like ease, delay, onComplete or onUpdate
	 */
	public function color (value:Number = 0x000000, strength:Number = 1, alpha:* = null):GenericActuator {
		
		var properties:Object = { colorValue: value, colorStrength: strength };
		
		if (alpha is Number) {
			
			properties.colorAlpha = alpha;
			
		}
		
		return Actuate.tween (target, duration, properties, overwrite, TransformActuator);
		
	}
	
	
	/**
	 * Creates a new SoundTransform tween
	 * @param	volume		The end volume for the target, or null if you would like to ignore this property (Default is null)
	 * @param	pan		The end pan for the target, or null if you would like to ignore this property (Default is null)
	 * @return		The current actuator instance, which can be used to apply properties like ease, delay, onComplete or onUpdate
	 */
	public function sound (volume:* = null, pan:* = null):GenericActuator {
		
		var properties:Object = new Object ();
		
		if (volume is Number) {
			
			properties.soundVolume = volume;
			
		}
		
		if (pan is Number) {
			
			properties.soundPan = pan;
			
		}
		
		return Actuate.tween (target, duration, properties, overwrite, TransformActuator);
		
	}
	
	
}


class TweenTimer {
	
	
	public var progress:Number;
	
	
	public function TweenTimer (progress:Number):void {
		
		this.progress = progress;
		
	}
	
	
}