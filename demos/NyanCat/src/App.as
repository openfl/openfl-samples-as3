package {
	
	
	import openfl.display.MovieClip;
	import openfl.display.Sprite;
	import openfl.utils.AssetLibrary;
	
	
	public class App extends Sprite {
		
		
		public function App () {
			
			super ();
			
			AssetLibrary.loadFromFile ("assets/library.bundle").onComplete (function (library:AssetLibrary):void {
				
				var cat:MovieClip = library.getMovieClip ("NyanCatAnimation");
				addChild (cat);
				
			}).onError (function (e:Error):void { trace (e); });
			
		}
		
		
	}
	
	
}