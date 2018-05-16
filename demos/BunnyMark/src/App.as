package {
	
	
	import openfl.display.Bitmap;
	import openfl.display.BitmapData;
	import openfl.display.Loader;
	import openfl.display.Sprite;
	import openfl.display.Stage;
	import openfl.display.Tilemap;
	import openfl.display.Tileset;
	import openfl.events.Event;
	import openfl.events.MouseEvent;
	import openfl.net.URLRequest;
	
	
	public class App extends Sprite {
		
		
		private var addingBunnies:Boolean;
		private var bunnies:Array;
		//private var fps:FPS;
		private var gravity:Number;
		private var minX:Number;
		private var minY:Number;
		private var maxX:Number;
		private var maxY:Number;
		private var tilemap:Tilemap;
		private var tileset:Tileset;
		
		
		public function App () {
			
			super ();
			
			bunnies = [];
			
			var loader:Loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event):void {
				start ((loader.content as Bitmap).bitmapData);
			});
			loader.load (new URLRequest ("wabbit_alpha.png"));
			
		}
		
		
		private function start (bitmapData:BitmapData):void {
			
			minX = 0;
			maxX = stage.stageWidth;
			minY = 0;
			maxY = stage.stageHeight;
			gravity = 0.5;
			
			tileset = new Tileset (bitmapData);
			tileset.addRect (bitmapData.rect);
			
			tilemap = new Tilemap (stage.stageWidth, stage.stageHeight, tileset);
			//tilemap = new Tilemap (100, 100, tileset);
			addChild (tilemap);
			
			// fps = new FPS ();
			// addChild (fps);
			
			stage.addEventListener (MouseEvent.MOUSE_DOWN, stage_onMouseDown);
			stage.addEventListener (MouseEvent.MOUSE_UP, stage_onMouseUp);
			stage.addEventListener (Event.ENTER_FRAME, stage_onEnterFrame);
			
			for (var i:uint = 0; i < 10; i++) {
				
				addBunny ();
				
			}
			
		}
		
		
		private function addBunny ():void {
			
			var bunny:Bunny = new Bunny ();
			bunny.x = 0;
			bunny.y = 0;
			bunny.speedX = Math.random () * 5;
			bunny.speedY = (Math.random () * 5) - 2.5;
			bunnies.push (bunny);
			tilemap.addTile (bunny);
			
		}
		
		
		
		
		// Event Handlers
		
		
		
		
		private function stage_onEnterFrame (event:Event):void {
			
			for each (var bunny:Bunny in bunnies) {
				
				bunny.x += bunny.speedX;
				bunny.y += bunny.speedY;
				bunny.speedY += gravity;
				
				if (bunny.x > maxX) {
					
					bunny.speedX = bunny.speedX * -1;
					bunny.x = maxX;
					
				} else if (bunny.x < minX) {
					
					bunny.speedX = bunny.speedX * -1;
					bunny.x = minX;
					
				}
				
				if (bunny.y > maxY) {
					
					bunny.speedY = bunny.speedY * -0.8;
					bunny.y = maxY;
					
					if (Math.random () > 0.5) {
						
						bunny.speedY = bunny.speedY - (3 + Math.random () * 4);
						
					}
					
				} else if (bunny.y < minY) {
					
					bunny.speedY = 0;
					bunny.y = minY;
					
				}
				
			}
			
			if (addingBunnies) {
				
				for (var i:uint = 0; i < 100; i++) {
					
					addBunny ();
					
				}
				
			}
			
		}
		
		
		private function stage_onMouseDown (event:MouseEvent):void {
			
			addingBunnies = true;
			
		}
		
		
		private function stage_onMouseUp (event:MouseEvent):void {
			
			addingBunnies = false;
			trace (bunnies.length + " bunnies");
			
		}
		
		
	}
	
	
}