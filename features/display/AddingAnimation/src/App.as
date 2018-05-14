package {
	
	
	import com.eclecticdesignstudio.motion.easing.Elastic;
	import com.eclecticdesignstudio.motion.Actuate;
	import openfl.display.Bitmap;
	import openfl.display.BitmapData;
	import openfl.display.Sprite;
	import openfl.display.Stage;
	import openfl.utils.AssetLibrary;
	import openfl.utils.AssetManifest;
	import openfl.utils.Assets;
	
	
	public class App extends Sprite {
		
		
		public function App () {
			
			super ();
			
			var bitmap:Bitmap = new Bitmap (Assets.getBitmapData ("assets/openfl.png"));
			bitmap.x = -bitmap.width / 2;
			bitmap.y = -bitmap.height / 2;
			bitmap.smoothing = true;
			
			var container:Sprite = new Sprite ();
			container.addChild (bitmap);
			container.alpha = 0;
			container.scaleX = 0;
			container.scaleY = 0;
			container.x = stage.stageWidth / 2;
			container.y = stage.stageHeight / 2;
			
			addChild (container);
			
			Actuate.tween (container, 3, { alpha: 1 } );
			Actuate.tween (container, 6, { scaleX: 1, scaleY: 1 } ).delay (0.4).ease (Elastic.easeOut);
			
		}
		
		
	}
	
	
}