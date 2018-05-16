package {
	
	
	import openfl.display.Bitmap;
	import openfl.display.Sprite;
	import openfl.display.Stage;
	import openfl.events.Event;
	import openfl.events.KeyboardEvent;
	import openfl.ui.Keyboard;
	import openfl.utils.AssetLibrary;
	import openfl.utils.AssetManifest;
	import openfl.utils.Assets;
	
	
	public class App extends Sprite {
		
		
		private var Logo:Sprite;
		
		private var movingDown:Boolean;
		private var movingLeft:Boolean;
		private var movingRight:Boolean;
		private var movingUp:Boolean;
		
		
		public function App () {
			
			super ();
			
			Logo = new Sprite ();
			Logo.addChild (new Bitmap (Assets.getBitmapData ("assets/openfl.png")));
			Logo.x = 100;
			Logo.y = 100;
			Logo.buttonMode = true;
			addChild (Logo);
			
			stage.addEventListener (KeyboardEvent.KEY_DOWN, stage_onKeyDown);
			stage.addEventListener (KeyboardEvent.KEY_UP, stage_onKeyUp);
			stage.addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
			
		}
		
		
		
		
		// Event Handlers
		
		
		
		
		private function stage_onKeyDown (event:KeyboardEvent):void {
			
			var preventDefault:Boolean = true;
			
			switch (event.keyCode) {
				
				case Keyboard.DOWN: movingDown = true; break;
				case Keyboard.LEFT: movingLeft = true; break;
				case Keyboard.RIGHT: movingRight = true; break;
				case Keyboard.UP: movingUp = true; break;
				default: preventDefault = false; break;
				
			}
			
			if (preventDefault) event.preventDefault ();
			
		}
		
		
		private function stage_onKeyUp (event:KeyboardEvent):void {
			
			var preventDefault:Boolean = true;
			
			switch (event.keyCode) {
				
				case Keyboard.DOWN: movingDown = false; break;
				case Keyboard.LEFT: movingLeft = false; break;
				case Keyboard.RIGHT: movingRight = false; break;
				case Keyboard.UP: movingUp = false; break;
				default: preventDefault = false; break;
				
			}
			
			if (preventDefault) event.preventDefault ();
			
		}
		
		
		private function this_onEnterFrame (event:Event):void {
			
			if (movingDown) {
				
				Logo.y += 5;
				
			}
			
			if (movingLeft) {
				
				Logo.x -= 5;
				
			}
			
			if (movingRight) {
				
				Logo.x += 5;
				
			}
			
			if (movingUp) {
				
				Logo.y -= 5;
				
			}
			
		}
		
		
	}
	
	
}