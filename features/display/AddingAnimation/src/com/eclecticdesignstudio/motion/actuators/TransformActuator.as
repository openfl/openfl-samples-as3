package com.eclecticdesignstudio.motion.actuators {
	
	
	import com.eclecticdesignstudio.motion.Actuate;
	// import flash.display.DisplayObject;
	// import flash.display.Sprite;
	// import flash.events.TimerEvent;
	// import flash.geom.ColorTransform;
	// import flash.media.SoundTransform;
	// import flash.utils.Timer;
	import openfl.display.DisplayObject;
	import openfl.display.Sprite;
	import openfl.events.TimerEvent;
	import openfl.geom.ColorTransform;
	import openfl.media.SoundTransform;
	import openfl.utils.Timer;
	
	use namespace MotionInternal;
	
	
	/**
	 * @author Joshua Granick
	 * @version 1.2
	 */
	public class TransformActuator extends SimpleActuator {
		
		
		protected var endColorTransform:ColorTransform;
		protected var endSoundTransform:SoundTransform;
		protected var tweenColorTransform:ColorTransform;
		protected var tweenSoundTransform:SoundTransform;
		
		
		public function TransformActuator (target:Object, duration:Number, properties:Object) {
			
			super (target, duration, properties);
			
		}
		
		
		MotionInternal override function apply ():void {
			
			initialize ();
			
			if (endColorTransform) {
				
				target.transform.colorTransform = endColorTransform;
				
			}
			
			if (endSoundTransform) {
				
				target.soundTransform = endSoundTransform;
				
			}
			
		}
		
		
		protected override function initialize ():void {
			
			if ("colorValue" in properties && target is DisplayObject) {
				
				initializeColor ();
				
			}
			
			if ("soundVolume" in properties || "soundPan" in properties) {
				
				initializeSound ();
				
			}
			
			detailsLength = propertyDetails.length;
			initialized = true;
			
		}
		
		
		protected function initializeColor ():void {
			
			endColorTransform = new ColorTransform ();
			
			var color:Number = properties.colorValue;
			var strength:Number = properties.colorStrength;
			
			if (strength < 1) {
				
				var multiplier:Number;
				var offset:Number;
				
				if (strength < 0.5) {
					
					multiplier = 1;
					offset = (strength * 2);
					
				} else {
					
					multiplier = 1 - ((strength - 0.5) * 2);
					offset = 1;
					
				}
				
				endColorTransform.redMultiplier = multiplier;
				endColorTransform.greenMultiplier = multiplier;
				endColorTransform.blueMultiplier = multiplier;
				
				endColorTransform.redOffset = offset * ((color >> 16) & 0xFF);
				endColorTransform.greenOffset = offset * ((color >> 8) & 0xFF);
				endColorTransform.blueOffset = offset * (color & 0xFF);
				
			} else {
				
				endColorTransform.color = color;
				
			}
			
			var propertyNames:Array = [ "redMultiplier", "greenMultiplier", "blueMultiplier", "redOffset", "greenOffset", "blueOffset" ];
			
			if ("colorAlpha" in properties) {
				
				endColorTransform.alphaMultiplier = properties.colorAlpha;
				propertyNames.push ("alphaMultiplier");
				
			} else {
				
				endColorTransform.alphaMultiplier = target.alpha;
				
			}
			
			var begin:ColorTransform = target.transform.colorTransform;
			tweenColorTransform = new ColorTransform ();
			
			var details:PropertyDetails;
			var start:Number;
			
			for each (var propertyName:String in propertyNames) {
				
				start = Number (begin[propertyName]);
				details = new PropertyDetails (tweenColorTransform, propertyName, start, Number (endColorTransform[propertyName] - start));
				propertyDetails.push (details);
				
			}
			
		}
		
		
		protected function initializeSound ():void {
			
			var start:SoundTransform = target.soundTransform;
			endSoundTransform = target.soundTransform;
			tweenSoundTransform = new SoundTransform ();
			
			if ("soundVolume" in properties) {
				
				endSoundTransform.volume = properties.soundVolume;
				propertyDetails.push (new PropertyDetails (tweenSoundTransform, "volume", start.volume, endSoundTransform.volume - start.volume));
				
			}
			
			if ("soundPan" in properties) {
				
				endSoundTransform.pan = properties.soundPan;
				propertyDetails.push (new PropertyDetails (tweenSoundTransform, "pan", start.pan, endSoundTransform.pan - start.pan));
				
			}
			
		}
		
		
		MotionInternal override function update (currentTime:Number):void {
			
			super.MotionInternal::update (currentTime);
			
			if (endColorTransform) {
				
				target.transform.colorTransform = tweenColorTransform;
				
			}
			
			if (endSoundTransform) {
				
				target.soundTransform = tweenSoundTransform;
				
			}
			
		}
		
		
	}
	

}