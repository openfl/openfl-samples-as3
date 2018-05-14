package {
	
	
	import openfl.display.Stage;
	import openfl.utils.AssetLibrary;
	import openfl.utils.AssetManifest;
	import openfl.utils.Assets;
	
	
	public class Entry {
		
		
		public function Entry () {
			
			var manifest:AssetManifest = new AssetManifest ();
			manifest.addBitmapData ("assets/openfl.png");
			
			AssetLibrary.loadFromManifest (manifest).onComplete (function (library:AssetLibrary):void {
				
				Assets.registerLibrary ("default", library);
				
				var stage:Stage = new Stage (670, 400, 0xFFFFFF, App);
				document.body.appendChild (stage.element);
				
			}).onError (function (e:Error):void {
				
				trace (e);
				
			});
			
		}
		
		
	}
	
	
}