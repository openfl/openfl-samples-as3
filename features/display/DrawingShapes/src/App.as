package {
	
	
	import openfl.display.CapsStyle;
	import openfl.display.Graphics;
	import openfl.display.Sprite;
	import openfl.display.Stage;
	
	
	public class App extends Sprite {
		
		
		public function App () {
			
			super ();
			
			var square:Sprite = new Sprite ();
			square.graphics.beginFill (0x24AFC4);
			square.graphics.drawRect (0, 0, 100, 100);
			square.x = 20;
			square.y = 20;
			addChild (square);
			
			var rectangle:Sprite = new Sprite ();
			rectangle.graphics.beginFill (0x24AFC4);
			rectangle.graphics.drawRect (0, 0, 120, 100);
			rectangle.x = 140;
			rectangle.y = 20;
			addChild (rectangle);
			
			var circle:Sprite = new Sprite ();
			circle.graphics.beginFill (0x24AFC4);
			circle.graphics.drawCircle (50, 50, 50);
			circle.x = 280;
			circle.y = 20;
			addChild (circle);
			
			var ellipse:Sprite = new Sprite ();
			ellipse.graphics.beginFill (0x24AFC4);
			ellipse.graphics.drawEllipse (0, 0, 120, 100);
			ellipse.x = 400;
			ellipse.y = 20;
			addChild (ellipse);
			
			var roundSquare:Sprite = new Sprite ();
			roundSquare.graphics.beginFill (0x24AFC4);
			roundSquare.graphics.drawRoundRect (0, 0, 100, 100, 40, 40);
			roundSquare.x = 540;
			roundSquare.y = 20;
			addChild (roundSquare);
			
			var roundRectangle:Sprite = new Sprite ();
			roundRectangle.graphics.beginFill (0x24AFC4);
			roundRectangle.graphics.drawRoundRect (0, 0, 120, 100, 40, 40);
			roundRectangle.x = 660;
			roundRectangle.y = 20;
			addChild (roundRectangle);
			
			var triangle:Sprite = new Sprite ();
			triangle.graphics.beginFill (0x24AFC4);
			triangle.graphics.moveTo (0, 100);
			triangle.graphics.lineTo (50, 0);
			triangle.graphics.lineTo (100, 100);
			triangle.graphics.lineTo (0, 100);
			triangle.x = 20;
			triangle.y = 150;
			addChild (triangle);
			
			var pentagon:Sprite = new Sprite ();
			pentagon.graphics.beginFill (0x24AFC4);
			drawPolygon (pentagon.graphics, 50, 50, 50, 5);
			pentagon.x = 145;
			pentagon.y = 150;
			addChild (pentagon);
			
			var hexagon:Sprite = new Sprite ();
			hexagon.graphics.beginFill (0x24AFC4);
			drawPolygon (hexagon.graphics, 50, 50, 50, 6);
			hexagon.x = 270;
			hexagon.y = 150;
			addChild (hexagon);
			
			var heptagon:Sprite = new Sprite ();
			heptagon.graphics.beginFill (0x24AFC4);
			drawPolygon (heptagon.graphics, 50, 50, 50, 7);
			heptagon.x = 395;
			heptagon.y = 150;
			addChild (heptagon);
			
			var octogon:Sprite = new Sprite ();
			octogon.graphics.beginFill (0x24AFC4);
			drawPolygon (octogon.graphics, 50, 50, 50, 8);
			octogon.x = 520;
			octogon.y = 150;
			addChild (octogon);
			
			var decagon:Sprite = new Sprite ();
			decagon.graphics.beginFill (0x24AFC4);
			drawPolygon (decagon.graphics, 50, 50, 50, 10);
			decagon.x = 650;
			decagon.y = 150;
			addChild (decagon);
			
			var line:Sprite = new Sprite ();
			line.graphics.lineStyle (10, 0x24AFC4);
			line.graphics.lineTo (755, 0);
			line.x = 20;
			line.y = 280;
			addChild (line);
			
			var curve:Sprite = new Sprite ();
			curve.graphics.lineStyle (10, 0x24AFC4);
			curve.graphics.curveTo (327.5, -50, 755, 0);
			curve.x = 20;
			curve.y = 340;
			addChild (curve);
			
		}
		
		
		private function drawPolygon (graphics:Graphics, x:Number, y:Number, radius:Number, sides:int):void {
			
			var step:Number = (Math.PI * 2) / sides;
			var start:Number = 0.5 * Math.PI;
			
			graphics.moveTo (Math.cos (start) * radius + x, -Math.sin (start) * radius + y);
			
			for (var i:uint = 0; i < sides; i++) {
				
				graphics.lineTo (Math.cos (start + (step * i)) * radius + x, -Math.sin (start + (step * i)) * radius + y);
				
			}
			
		}
		
		
	}


}