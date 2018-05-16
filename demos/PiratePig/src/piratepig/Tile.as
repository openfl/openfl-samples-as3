package piratepig {
	
	
	import motion.easing.Quad;
	import motion.Actuate;
	import openfl.display.Bitmap;
	import openfl.display.Sprite;
	import openfl.utils.Assets;
	
	
	public class Tile extends Sprite {
		
		
		public function get column ():int { return _column; }
		public function set column (value:int):void { _column = value; }
		
		public function get moving ():Boolean { return _moving; }
		public function set moving (value:Boolean):void { _moving = value; }
		
		public function get removed ():Boolean { return _removed; }
		public function set removed (value:Boolean):void { _removed = value; }
		
		public function get row ():int { return _row; }
		public function set row (value:int):void { _row = value; }
		
		public function get type ():int { return _type; }
		public function set type (value:int):void { _type = value; }
		
		private var _column:int;
		private var _moving:Boolean;
		private var _removed:Boolean;
		private var _row:int;
		private var _type:int;
		
		
		public function Tile (imagePath:String) {
			
			super ();
			
			var image:Bitmap = new Bitmap (Assets.getBitmapData (imagePath));
			image.smoothing = true;
			addChild (image);
			
			mouseChildren = false;
			buttonMode = true;
			
			graphics.beginFill (0x000000, 0);
			graphics.drawRect (-5, -5, 66, 66);
			
		}
		
		
		public function initialize ():void {
			
			moving = false;
			removed = false;
			
			mouseEnabled = true;
			buttonMode = true;
			
			scaleX = 1;
			scaleY = 1;
			alpha = 1;
			
		}
		
		
		public function moveTo (duration:Number, targetX:Number, targetY:Number):void {
			
			moving = true;
			
			Actuate.tween (this, duration, { x: targetX, y: targetY } ).ease (Quad.easeOut).onComplete (this_onMoveToComplete);
			
		}
		
		
		public function remove (animate:Boolean = true):void {
			
			if (!removed) {
				
				if (animate) {
					
					mouseEnabled = false;
					buttonMode = false;
					
					parent.addChildAt (this, 0);
					Actuate.tween (this, 0.6, { alpha: 0, scaleX: 2, scaleY: 2, x: x - width / 2, y: y - height / 2 } ).onComplete (this_onRemoveComplete);
					
				} else {
					
					this_onRemoveComplete ();
					
				}
				
			}
			
			removed = true;
			
		}
		
		
		
		
		// Event Handlers
		
		
		
		
		private function this_onMoveToComplete ():void {
			
			moving = false;
			
		}
		
		
		private function this_onRemoveComplete ():void {
			
			parent.removeChild (this);
			
		}
		
		
	}
	
	
}