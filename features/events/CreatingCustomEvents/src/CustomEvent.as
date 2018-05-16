package {
	
	
	import openfl.events.Event;
	
	
	public class CustomEvent extends Event {
		
		
		public static const TYPED_CUSTOM_EVENT:String = "typedCustomEvent";
		
		public function get customData ():int { return _customData; }
		public function set customData (value:int):void { _customData = value; }
		private var _customData:int;
		
		
		public function CustomEvent (type:String, _customData:int, bubbles:Boolean = false, cancelable:Boolean = false) {
			
			this._customData = _customData;
			
			super (type, bubbles, cancelable);
			
		}
		
		
		public override function clone ():Event {
			
			return new CustomEvent (type, customData, bubbles, cancelable);
			
		}
		
		
		public override function toString ():String {
			
			return "[CustomEvent type=\"" + type + "\" bubbles=" + bubbles + " cancelable=" + cancelable + " eventPhase=" + eventPhase + " customData=" + customData + "]";
			
		}
		
		
	}
	
	
}