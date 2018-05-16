package piratepig {
	
	
	import openfl.ui.GameInputControl;
	import openfl.ui.GameInputDevice;
	
	
	public class GamepadWrapper {
		
		
		public function get a ():ButtonState { return _a; }
		public function set a (value:ButtonState):void { _a = value; }
		
		public function get b ():ButtonState { return _b; }
		public function set b (value:ButtonState):void { _b = value; }
		
		public function get down ():ButtonState { return _down; }
		public function set down (value:ButtonState):void { _down = value; }
		
		public function get device ():GameInputDevice { return _device; }
		public function set device (value:GameInputDevice):void { _device = value; }
		
		public function get left ():ButtonState { return _left; }
		public function set left (value:ButtonState):void { _left = value; }
		
		public function get right ():ButtonState { return _right; }
		public function set right (value:ButtonState):void { _right = value; }
		
		public function get up ():ButtonState { return _up; }
		public function set up (value:ButtonState):void { _up = value; }
		
		public function get x ():ButtonState { return _x; }
		public function set x (value:ButtonState):void { _x = value; }
		
		public function get y ():ButtonState { return _y; }
		public function set y (value:ButtonState):void { _y = value; }
		
		private var _a:ButtonState;
		private var _b:ButtonState;
		private var _down:ButtonState;
		private var _device:GameInputDevice;
		private var _left:ButtonState;
		private var _right:ButtonState;
		private var _up:ButtonState;
		private var _x:ButtonState;
		private var _y:ButtonState;
		
		
		public function GamepadWrapper (device:GameInputDevice) {
			
			this.device = device;
			
			up = new ButtonState ();
			down = new ButtonState ();
			left = new ButtonState ();
			right = new ButtonState ();
			
			a = new ButtonState ();
			b = new ButtonState ();
			x = new ButtonState ();
			y = new ButtonState ();
			
		}
		
		
		public function destroy ():void {
			
			device = null;
			
		}
		
		
		public function update ():void {
			
			for (var i:uint = 0; i < device.numControls; i++) {
				
				var control:GameInputControl = device.getControlAt (i);
				
				var state:ButtonState = null;
				
				switch (control.id) {
					
					case "BUTTON_11": state = up; break;
					case "BUTTON_12": state = down; break;
					case "BUTTON_13": state = left; break;
					case "BUTTON_14": state = right; break;
					case "BUTTON_0": state = a; break;
					case "BUTTON_1": state = b; break;
					case "BUTTON_2": state = x; break;
					case "BUTTON_3": state = y; break;
					
				}
				
				if (state != null) {
					
					if (control.value <= 0) {
						
						state.release ();
						
					} else {
						
						state.press ();
					}
					
				}
				
			}
			
		}
		
	}
	
	
}


internal class ButtonState {
	
	
	public function get pressed ():Boolean { return _pressed; }
	public function set pressed (value:Boolean):void { _pressed = value; }
	
	public function get justPressed ():Boolean { return _justPressed; }
	public function set justPressed (value:Boolean):void { _justPressed = value; }
	
	public function get justReleased ():Boolean { return _justReleased; }
	public function set justReleased (value:Boolean):void { _justReleased = value; }
	
	private var _pressed:Boolean;
	private var _justPressed:Boolean;
	private var _justReleased:Boolean;
	
	
	public function ButtonState () {
		
		pressed = false;
		justPressed = false;
		justReleased = false;
		
	}
	
	
	public function press ():void {
		
		if (!pressed) {
			
			justPressed = true;
			
		} else {
			
			justPressed = false;
			
		}
		
		pressed = true;
		justReleased = false;
		
	}
	
	
	public function release ():void {
		
		if (pressed) {
			
			justReleased = true;
			
		} else {
			
			justReleased = false;
			
		}
		
		pressed = false;
		justPressed = false;
		
	}
	
	
	public function update ():void {
		
		justPressed = false;
		justReleased = false;
		
	}
	
	
}