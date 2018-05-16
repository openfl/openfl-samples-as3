package {
	
	
	import openfl.display.Stage;
	import openfl.utils.AssetLibrary;
	import openfl.utils.AssetManifest;
	import openfl.utils.Assets;
	import piratepig.PiratePig;
	
	
	public class Main {
		
		
		public function Main () {
			
			var manifest:AssetManifest = new AssetManifest ();
			
			for each (var image:String in [ "background_tile.png", "center_bottom.png", "cursor_highlight.png", "cursor.png", "game_bear.png", "game_bunny_02.png", "game_carrot.png", "game_lemon.png", "game_panda.png", "game_piratePig.png", "logo.png"]) {
				
				manifest.addBitmapData ("images/" + image);
				
			}
			
			for each (var sound:String in [ "3", "4", "5", "theme" ]) {
				
				var id:String = "sound" + sound.charAt (0).toUpperCase () + sound.substr (1);
				manifest.addSound ([ "sounds/" + sound + ".ogg", "sounds/" + sound + ".mp3", "sounds/" + sound + ".wav" ], id);
				
			}
			
			manifest.addFont ("Freebooter", "fonts/FreebooterUpdated.ttf");
			
			AssetLibrary.loadFromManifest (manifest).onComplete (function (library:AssetLibrary):void {
				
				Assets.registerLibrary ("default", library);
				
				var stage:Stage = new Stage ();
				document.getElementById ("openfl-content").appendChild (stage.element);
				stage.addChild (new PiratePig ());
				
			}).onError (function (e:Error):void {
				
				trace (e);
				
			});
			
		}
		
		
	}
	
	
}