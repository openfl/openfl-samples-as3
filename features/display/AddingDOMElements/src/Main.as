package {
	
	
	import openfl.display.Stage;
	
	
	public class Main {
		
		
		public function Main () {
			
			var stage:Stage = new Stage (550, 400, 0xFFFFFF, App, { renderer: "dom" });
			document.body.appendChild (stage.element);
			
		}
		
		
	}
	
	
}