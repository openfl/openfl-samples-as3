package {
	
	
	import openfl.display.Sprite;
	import openfl.display.Stage;
	import openfl.events.Event;
	import openfl.utils.getTimer;
	
	
	public class App extends Sprite {
		
		
		private var cacheTime:int;
		private var speed:Number;
		private var sprite:Sprite;
		
		
		public function App () {
			
			super ();
			
			sprite = new Sprite ();
			sprite.graphics.beginFill (0x24AFC4);
			sprite.graphics.drawRect (0, 0, 100, 100);
			sprite.y = 50;
			addChild (sprite);
			
			speed = 0.3;
			cacheTime = getTimer ();
			
			addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
			
		}
		
		
		private function update (deltaTime:int):void {
			
			if (sprite.x + sprite.width >= stage.stageWidth || sprite.x < 0) {
				
				speed *= -1;
				
			}
			
			sprite.x += speed * deltaTime;
			
		}
		
		
		
		
		// Event Handlers
		
		
		
		
		private function this_onEnterFrame (event:Event):void {
			
			var currentTime:Number = getTimer ();
			update (currentTime - cacheTime);
			cacheTime = currentTime;
			
		}
		
		
	}
	
	
}