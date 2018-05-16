package {
	
	
	import openfl.display.Bitmap;
	import openfl.display.Loader;
	import openfl.display.Sprite;
	import openfl.events.Event;
	import openfl.net.URLRequest;
	
	
	public class App extends Sprite {
		
		
		public function App () {
			
			super ();
			
			var loader:Loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, loader_onComplete);
			loader.load (new URLRequest ("openfl.png"));
			
		}
		
		
		
		
		// Event Handlers
		
		
		
		
		private function loader_onComplete (event:Event):void {
			
			var bitmap:Bitmap = event.target.loader.content as Bitmap;
			bitmap.x = (stage.stageWidth - bitmap.width) / 2;
			bitmap.y = (stage.stageHeight - bitmap.height) / 2;
			stage.addChild (bitmap);
			
		}
		
		
	}
	
	
}