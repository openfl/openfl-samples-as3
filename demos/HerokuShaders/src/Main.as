package {
	
	
	import openfl.display.Stage;
	import openfl.utils.AssetLibrary;
	import openfl.utils.AssetManifest;
	import openfl.utils.Assets;
	
	
	public class Main {
		
		
		public function Main () {
			
			var glFragmentShaders:Array = [ "6286", "6288.1", "6284.1", "6238", "6223.2", "6175", "6162", "6147.1", "6049", "6043.1", "6022", "5891.5", "5805.18", "5812", "5733", "5454.21", "5492", "5359.8", "5398.8", "4278.1" ];
			
			var manifest:AssetManifest = new AssetManifest ();
			manifest.addText ("assets/heroku.vert");
			
			for each (var shader:String in glFragmentShaders) {
				
				manifest.addText ("assets/" + shader + ".frag");
				
			}
			
			AssetLibrary.loadFromManifest (manifest).onComplete (function (library:AssetLibrary):void {
				
				Assets.registerLibrary ("default", library);
				
				var stage:Stage = new Stage (550, 400, 0xFFFFFF, App);
				document.body.appendChild (stage.element);
				
			}).onError (function (e:Error):void {
				
				trace (e);
				
			});
			
		}
		
		
	}
	
	
}