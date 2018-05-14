package {
	
	
	import openfl.display.Stage;
	
	
	public class Entry {
		
		
		public function Entry () {
			
			var stage:Stage = new Stage (550, 400, 0xFFFFFF, App, { renderer: "dom" });
			document.body.appendChild (stage.element);
			
		}
		
		
	}
	
	
}