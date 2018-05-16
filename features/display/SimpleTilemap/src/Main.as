package {
	
	
	import openfl.display.Stage;
	import openfl.utils.AssetLibrary;
	import openfl.utils.AssetManifest;
	import openfl.utils.Assets;
	
	
	public class Main {
		
		
		public function Main () {
			
			var manifest:AssetManifest = new AssetManifest ();
			manifest.addBitmapData ("assets/tileset.png");
			
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