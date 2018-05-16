package {
	
	
	import openfl.display.Sprite;
	import openfl.display.Stage;
	import openfl.text.Font;
	import openfl.text.TextField;
	import openfl.text.TextFormat;
	import openfl.utils.AssetLibrary;
	import openfl.utils.AssetManifest;
	
	
	public class App extends Sprite {
		
		
		public function App () {
			
			super ();
			
			var format:TextFormat = new TextFormat ("Katamotz Ikasi", 30, 0x7A0026);
			var textField:TextField = new TextField ();
			
			textField.defaultTextFormat = format;
			textField.embedFonts = true;
			textField.selectable = false;
			
			textField.x = 50;
			textField.y = 50;
			textField.width = 200;
			
			textField.text = "Hello World";
			
			addChild (textField);
			
		}
		
		
	}
	
	
}