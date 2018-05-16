package {
	
	
	import openfl.display.BitmapData;
	import openfl.display.Sprite;
	import openfl.display.Tile;
	import openfl.display.Tilemap;
	import openfl.display.Tileset;
	import openfl.geom.Rectangle;
	import openfl.utils.Assets;
	
	
	public class App extends Sprite {
		
		
		public function App () {
			
			super ();
			
			/**
			 * "Various Creatures" by GrafxKid is licensed under CC BY 3.0
			 * (https://opengameart.org/content/various-creatures)
			 * (https://creativecommons.org/licenses/by/3.0/)
			 */
			var bitmapData:BitmapData = Assets.getBitmapData ("assets/tileset.png");
			var tileset:Tileset = new Tileset (bitmapData);
			
			var gumdropID:int = tileset.addRect (new Rectangle (0, 0, 32, 32));
			var balloonID:int = tileset.addRect (new Rectangle (0, 64, 32, 32));
			var robotID:int = tileset.addRect (new Rectangle (0, 96, 32, 32));
			var compyID:int = tileset.addRect (new Rectangle (0, 224, 32, 32));
			
			var tilemap:Tilemap = new Tilemap (stage.stageWidth, stage.stageHeight, tileset);
			tilemap.smoothing = false;
			tilemap.scaleX = 4;
			tilemap.scaleY = 4;
			addChild (tilemap);
			
			var gumdrop:Tile = new Tile (gumdropID);
			gumdrop.x = 12;
			gumdrop.y = 48;
			tilemap.addTile (gumdrop);
			
			var balloon:Tile = new Tile (balloonID);
			balloon.x = 60;
			balloon.y = 48;
			tilemap.addTile (balloon);
			
			var robot:Tile = new Tile (robotID);
			robot.x = 108;
			robot.y = 48;
			tilemap.addTile (robot);
			
			var compy:Tile = new Tile (compyID);
			compy.x = 156;
			compy.y = 48;
			tilemap.addTile (compy);
			
		}
		
		
	}
	
	
}