package {
	
	
	import openfl.display.Sprite;
	import openfl.display.Stage;
	import openfl.events.Event;
	import com.example.CustomEvent;
	
	
	public class App extends Sprite {
		
		
		public function App () {
			
			super ();
			
			addEventListener ("simpleCustomEvent", this_onSimpleCustomEvent);
			addEventListener (CustomEvent.TYPED_CUSTOM_EVENT, this_onTypedCustomEvent);
			
			dispatchEvent (new Event ("simpleCustomEvent"));
			dispatchEvent (new CustomEvent (CustomEvent.TYPED_CUSTOM_EVENT, 100));
			
		}
		
		
		
		
		// Event Handlers
		
		
		
		
		private function this_onSimpleCustomEvent (event:Event):void {
			
			trace (event);
			
		}
		
		
		private function this_onTypedCustomEvent (event:CustomEvent):void {
			
			trace (event);
			
		}
		
		
	}
	
	
}