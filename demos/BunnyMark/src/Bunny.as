package {
	
	
	import openfl.display.Tile;
	
	
	public class Bunny extends Tile {
		
		
		public function get speedX ():Number { return _speedX; }
		public function set speedX (value:Number):void { _speedX = value; }
		public function get speedY ():Number { return _speedY; }
		public function set speedY (value:Number):void { _speedY = value; }
		
		private var _speedX:Number = 0;
		private var _speedY:Number = 0;
		
		
		public function Bunny () {
			
			super (0);
			
		}
		
		
	}
	
	
}