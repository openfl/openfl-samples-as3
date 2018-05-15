package {
	
	
	import openfl.display.Stage;
	
	
	public class Main {
		
		
		public function Main () {
			
			var stage:Stage = new Stage (650, 400, 0xFFFFFF);
			document.body.appendChild (stage.element);
			stage.addChild (new App ());
			
		}
		
		
	}
	
	
}