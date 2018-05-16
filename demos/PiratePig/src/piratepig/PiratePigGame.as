package piratepig {
	
	
	import motion.easing.Quad;
	import motion.Actuate;
	import openfl.display.Bitmap;
	import openfl.display.Sprite;
	import openfl.events.Event;
	import openfl.events.MouseEvent;
	import openfl.filters.BlurFilter;
	import openfl.filters.DropShadowFilter;
	import openfl.geom.Point;
	import openfl.media.Sound;
	import openfl.text.Font;
	import openfl.text.TextField;
	import openfl.text.TextFormat;
	import openfl.text.TextFormatAlign;
	import openfl.utils.Assets;
	import openfl.Lib;
	
	// #if (!flash || enable_gamepad_support)
	import openfl.events.GameInputEvent;
	import openfl.ui.GameInput;
	import openfl.ui.GameInputDevice;
	import openfl.ui.GameInputControl;
	// #end
	
	
	public class PiratePigGame extends Sprite {
		
		
		private static var NUM_COLUMNS:uint = 8;
		private static var NUM_ROWS:uint = 8;
		
		private static var tileImages:Array = [ "images/game_bear.png", "images/game_bunny_02.png", "images/game_carrot.png", "images/game_lemon.png", "images/game_panda.png", "images/game_piratePig.png" ];
		
		private var Background:Sprite;
		private var Cursor:Bitmap;
		private var CursorHighlight:Bitmap;
		private var IntroSound:Sound;
		private var Logo:Bitmap;
		private var Score:TextField;
		private var Sound3:Sound;
		private var Sound4:Sound;
		private var Sound5:Sound;
		private var TileContainer:Sprite;
		
		public function get currentScale ():Number { return _currentScale; }
		public function set currentScale (value:Number):void { _currentScale = value; }
		
		public function get currentScore ():Number { return _currentScore; }
		public function set currentScore (value:Number):void { _currentScale = value; }
		
		private var _currentScale:Number;
		private var _currentScore:int;
		
		private var cacheMouse:Point;
		private var cursorPosition:Point;
		private var gamepads:Array;
		private var needToCheckMatches:Boolean;
		private var selectedTile:Tile;
		private var tiles:Array;
		private var usedTiles:Array;
		
		// #if (!flash || enable_gamepad_support)
		private var gameInput:GameInput;
		// #end
		
		
		public function PiratePigGame () {
			
			super ();
			
			initialize ();
			construct ();
			
			newGame ();
			
		}
		
		
		private function addTile (row:int, column:int, animate:Boolean = true):void {
			
			var tile:Tile = null;
			var type:uint = Math.round (Math.random () * (tileImages.length - 1));
			
			for each (var usedTile:Tile in usedTiles) {
				
				if (usedTile.removed && usedTile.parent == null && usedTile.type == type) {
					
					tile = usedTile;
					
				}
				
			}
			
			if (tile == null) {
				
				tile = new Tile (tileImages[type]);
				
			}
			
			tile.initialize ();
			
			tile.type = type;
			tile.row = row;
			tile.column = column;
			tiles[row][column] = tile;
			
			var position:Point = getPosition (row, column);
			
			if (animate) {
				
				var firstPosition:Point = getPosition (-1, column);
				
				tile.alpha = 0;
				tile.x = firstPosition.x;
				tile.y = firstPosition.y;
				
				tile.moveTo (0.15 * (row + 1), position.x, position.y);
				Actuate.tween (tile, 0.3, { alpha: 1 } ).delay (0.15 * (row - 2)).ease (Quad.easeOut);
				
			} else {
				
				tile.x = position.x;
				tile.y = position.y;
				
			}
			
			TileContainer.addChild (tile);
			needToCheckMatches = true;
			
		}
		
		
		private function construct ():void {
			
			Logo.smoothing = true;
			addChild (Logo);
			
			var font:Font = Assets.getFont ("fonts/FreebooterUpdated.ttf");
			var defaultFormat:TextFormat = new TextFormat (font.fontName, 60, 0x000000);
			defaultFormat.align = TextFormatAlign.RIGHT;
			
			var contentWidth:Number = 75 * NUM_COLUMNS;
			
			Score.x = contentWidth - 200;
			Score.width = 200;
			Score.y = 12;
			Score.selectable = false;
			Score.defaultTextFormat = defaultFormat;
			
			//Score.filters = [ new BlurFilter (1.5, 1.5), new DropShadowFilter (1, 45, 0, 0.2, 5, 5) ];
			
			Score.embedFonts = true;
			addChild (Score);
			
			Background.y = 85;
			Background.graphics.beginFill (0xFFFFFF, 0.4);
			Background.graphics.drawRect (0, 0, contentWidth, 75 * NUM_ROWS);
			
			//Background.filters = [ new BlurFilter (10, 10) ];
			addChild (Background);
			
			TileContainer.x = 14;
			TileContainer.y = Background.y + 14;
			TileContainer.addEventListener (MouseEvent.MOUSE_DOWN, TileContainer_onMouseDown);
			Lib.current.stage.addEventListener (MouseEvent.MOUSE_UP, stage_onMouseUp);
			addChild (TileContainer);
			
			IntroSound = Assets.getSound ("soundTheme");
			Sound3 = Assets.getSound ("sound3");
			Sound4 = Assets.getSound ("sound4");
			Sound5 = Assets.getSound ("sound5");
			
			Cursor.x = TileContainer.x;
			Cursor.y = TileContainer.y;
			CursorHighlight.x = Cursor.x;
			CursorHighlight.y = Cursor.y;
			
			Cursor.visible = false;
			CursorHighlight.visible = false;
			
			addChild (Cursor);
			addChild (CursorHighlight);
			
			// #if (!flash || enable_gamepad_support)
			gameInput = new GameInput ();
			gameInput.addEventListener (GameInputEvent.DEVICE_ADDED, gameInput_onDeviceAdded);
			gameInput.addEventListener (GameInputEvent.DEVICE_REMOVED, gameInput_onDeviceRemoved);
			// #end
			
		}
		
		
		private function dropTiles ():void {
			
			for (var column:uint = 0; column < NUM_COLUMNS; column++) {
				
				var spaces:uint = 0;
				
				for (var row:uint = 0; row < NUM_ROWS; row++) {
					
					var index:uint = (NUM_ROWS - 1) - row;
					var tile:Tile = tiles[index][column];
					
					if (tile == null) {
						
						spaces++;
						
					} else {
						
						if (spaces > 0) {
							
							var position:Point = getPosition (index + spaces, column);
							tile.moveTo (0.15 * spaces, position.x,position.y);
							
							tile.row = index + spaces;
							tiles[index + spaces][column] = tile;
							tiles[index][column] = null;
							
							needToCheckMatches = true;
							
						}
						
					}
					
				}
				
				for (var i:uint = 0; i < spaces; i++) {
					
					row = (spaces - 1) - i;
					addTile (row, column);
					
				}
				
			}
			
		}
		
		
		private function findMatches (byRow:Boolean, accumulateScore:Boolean = true):Array {
			
			var matchedTiles:Array = new Array ();
			
			var max:int;
			var secondMax:int;
			
			if (byRow) {
				
				max = NUM_ROWS;
				secondMax = NUM_COLUMNS;
				
			} else {
				
				max = NUM_COLUMNS;
				secondMax = NUM_ROWS;
				
			}
			
			for (var index:uint = 0; index < max; index++) {
				
				var matches:uint = 0;
				var foundTiles:Array = new Array ();
				var previousType:int = -1;
				
				for (var secondIndex:uint = 0; secondIndex < secondMax; secondIndex++) {
					
					var tile:Tile;
					
					if (byRow) {
						
						tile = tiles[index][secondIndex];
						
					} else {
						
						tile = tiles[secondIndex][index];
						
					}
					
					if (tile != null && !tile.moving) {
						
						if (previousType == -1) {
							
							previousType = tile.type;
							foundTiles.push (tile);
							continue;
							
						} else if (tile.type == previousType) {
							
							foundTiles.push (tile);
							matches++;
							
						}
						
					}
					
					if (tile == null || tile.moving || tile.type != previousType || secondIndex == secondMax - 1) {
						
						if (matches >= 2 && previousType != -1) {
							
							if (accumulateScore) {
								
								if (matches > 3) {
									
									Sound5.play ();
									
								} else if (matches > 2) {
									
									Sound4.play ();
									
								} else {
									
									Sound3.play ();
									
								}
								
								_currentScore += Math.pow (matches, 2) * 50;
								
							}
							
							matchedTiles = matchedTiles.concat (foundTiles);
							
						}
						
						matches = 0;
						foundTiles = new Array ();
						
						if (tile == null || tile.moving) {
							
							needToCheckMatches = true;
							previousType = -1;
							
						} else {
							
							previousType = tile.type;
							foundTiles.push (tile);
							
						}
						
					}
					
				}
				
			}
			
			return matchedTiles;
			
		}
		
		
		private function getPosition (row:int, column:int):Point {
			
			return new Point (column * (57 + 16), row * (57 + 16));
			
		}
		
		
		private function initialize ():void {
			
			_currentScale = 1;
			_currentScore = 0;
			
			tiles = new Array ();
			usedTiles = new Array ();
			gamepads = new Array ();
			
			for (var row:uint = 0; row < NUM_ROWS; row++) {
				
				tiles[row] = new Array ();
				
				for (var column:uint = 0; column < NUM_COLUMNS; column++) {
					
					tiles[row][column] = null;
					
				}
				
			}
			
			Background = new Sprite ();
			Logo = new Bitmap (Assets.getBitmapData ("images/logo.png"));
			Score = new TextField ();
			TileContainer = new Sprite ();
			Cursor = new Bitmap (Assets.getBitmapData ("images/cursor.png"));
			CursorHighlight = new Bitmap (Assets.getBitmapData ("images/cursor_highlight.png"));
			
		}
		
		
		private function moveCursor (x:int, y:int, aPressed:Boolean):void {
			
			if (cursorPosition == null) cursorPosition = new Point();
			
			var oldTile:Tile = tiles[cursorPosition.y][cursorPosition.x];
			
			cursorPosition.x += x;
			cursorPosition.y += y;
			
			if (cursorPosition.y > tiles.length - 1) cursorPosition.y = tiles.length - 1;
			if (cursorPosition.x > tiles[0].length - 1) cursorPosition.x = tiles[0].length - 1;
			if (cursorPosition.y < 0) cursorPosition.y = 0;
			if (cursorPosition.x < 0) cursorPosition.x = 0;
			
			var tile:Tile = tiles[cursorPosition.y][cursorPosition.x];
			
			if (tile != null) {
				
				Cursor.x = TileContainer.x + tile.x;
				Cursor.y = TileContainer.y + tile.y;
				CursorHighlight.x = Cursor.x;
				CursorHighlight.y = Cursor.y;
				
				if (aPressed && oldTile != tile && oldTile != null) {
					
					swapTile (oldTile, cursorPosition.y, cursorPosition.x);
					
				}
				
			}
			
		}
		
		
		public function newGame ():void {
			
			_currentScore = 0;
			Score.text = "0";
			
			for (var row:uint = 0; row < NUM_ROWS; row++) {
				
				for (var column:uint = 0; column < NUM_COLUMNS; column++) {
					
					removeTile (row, column, false);
					
				}
				
			}
			
			for (row = 0; row < NUM_ROWS; row++) {
				
				for (column = 0; column < NUM_COLUMNS; column++) {
					
					addTile (row, column, false);
					
				}
				
			}
			
			IntroSound.play ();
			
			removeEventListener (Event.ENTER_FRAME, this_onEnterFrame);
			addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
			
		}
		
		
		public function removeTile (row:int, column:int, animate:Boolean = true):void {
			
			var tile:Tile = tiles[row][column];
			
			if (tile != null) {
				
				tile.remove (animate);
				usedTiles.push (tile);
				
			}
			
			tiles[row][column] = null;
			
		}
		
		
		public function resize (newWidth:int, newHeight:int):void {
			
			var maxWidth:Number = newWidth * 0.90;
			var maxHeight:Number = newHeight * 0.86;
			
			_currentScale = 1;
			scaleX = 1;
			scaleY = 1;
			
			var currentWidth:Number = width;
			var currentHeight:Number = height;
			
			if (currentWidth > maxWidth || currentHeight > maxHeight) {
				
				var maxScaleX:Number = maxWidth / currentWidth;
				var maxScaleY:Number = maxHeight / currentHeight;
				
				if (maxScaleX < maxScaleY) {
					
					_currentScale = maxScaleX;
					
				} else {
					
					_currentScale = maxScaleY;
					
				}
				
				scaleX = _currentScale;
				scaleY = _currentScale;
				
			}
			
			x = newWidth / 2 - (currentWidth * _currentScale) / 2;
			
		}
		
		
		private function swapTile (tile:Tile, targetRow:int, targetColumn:int):void {
			
			if (targetColumn >= 0 && targetColumn < NUM_COLUMNS && targetRow >= 0 && targetRow < NUM_ROWS) {
				
				var targetTile:Tile = tiles[targetRow][targetColumn];
				
				if (targetTile != null && !targetTile.moving) {
					
					tiles[targetRow][targetColumn] = tile;
					tiles[tile.row][tile.column] = targetTile;
					
					if (findMatches (true, false).length > 0 || findMatches (false, false).length > 0) {
						
						targetTile.row = tile.row;
						targetTile.column = tile.column;
						tile.row = targetRow;
						tile.column = targetColumn;
						var targetTilePosition:Point = getPosition (targetTile.row, targetTile.column);
						var tilePosition:Point = getPosition (tile.row, tile.column);
						
						targetTile.moveTo (0.3, targetTilePosition.x, targetTilePosition.y);
						tile.moveTo (0.3, tilePosition.x, tilePosition.y);
						
						needToCheckMatches = true;
						
					} else {
						
						tiles[targetRow][targetColumn] = targetTile;
						tiles[tile.row][tile.column] = tile;
						
					}
					
				}
				
			}
			
		}
		
		
		private function updateGamepadInput ():void {
			
		// 	#if (!flash || enable_gamepad_support)
			
			for each (var gamepad:GamepadWrapper in gamepads) {
				
				gamepad.update ();
				
			}
			
			if (gamepads.length > 0) {
				
				var aPressed:Boolean = gamepads[0].a.pressed;
				
				if (gamepads[0].up.justPressed) {
					
					moveCursor (0, -1, aPressed);
					
				} else if (gamepads[0].down.justPressed) {
					
					moveCursor(0, 1, aPressed);
					
				} else if (gamepads[0].left.justPressed) {
					
					moveCursor( -1, 0, aPressed);
					
				} else if (gamepads[0].right.justPressed) {
					
					moveCursor(1, 0, aPressed);
					
				}
				
				Cursor.visible = !aPressed;
				CursorHighlight.visible = aPressed;
				
			} else {
				
				Cursor.visible = false;
				CursorHighlight.visible = false;
				
			}
			
		// 	#end
			
		}
		
		
		
		
		// Event Handlers
		
		
		
		
		
		// #if (!flash || enable_gamepad_support)
		
		private function gameInput_onDeviceAdded (event:GameInputEvent):void {
			
			var device:GameInputDevice = event.device;
			device.enabled = true;
			
			gamepads.push (new GamepadWrapper (device));
			
		}
		
		
		private function gameInput_onDeviceRemoved (event:GameInputEvent):void {
			
			var device:GameInputDevice = event.device;
			device.enabled = false;
			
			for (var i:uint = 0; i < gamepads.length; i++) {
				
				var gamepad:GamepadWrapper = gamepads[i];
				
				if (gamepad.device == device) {
					
					gamepad.destroy ();
					gamepads.removeAt (i);
					return;
					
				}
				
			}
			
		}
		
		// #end
		
		
		private function stage_onMouseUp (event:MouseEvent):void {
			
			if (cacheMouse != null && selectedTile != null && !selectedTile.moving) {
				
				var differenceX:Number = event.stageX - cacheMouse.x;
				var differenceY:Number = event.stageY - cacheMouse.y;
				
				if (Math.abs (differenceX) > 10 || Math.abs (differenceY) > 10) {
					
					var swapToRow:uint = selectedTile.row;
					var swapToColumn:uint = selectedTile.column;
					
					if (Math.abs (differenceX) > Math.abs (differenceY)) {
						
						if (differenceX < 0) {
							
							swapToColumn --;
							
						} else {
							
							swapToColumn ++;
							
						}
						
					} else {
						
						if (differenceY < 0) {
							
							swapToRow --;
							
						} else {
							
							swapToRow ++;
							
						}
						
					}
					
					swapTile (selectedTile, swapToRow, swapToColumn);
					
				}
				
			}
			
			selectedTile = null;
			cacheMouse = null;
			
		}
		
		
		private function this_onEnterFrame (event:Event):void {
			
			updateGamepadInput ();
			
			if (needToCheckMatches) {
				
				var matchedTiles:Array = new Array ();
				
				matchedTiles = matchedTiles.concat (findMatches (true));
				matchedTiles = matchedTiles.concat (findMatches (false));
				
				for each (var tile:Tile in matchedTiles) {
					
					removeTile (tile.row, tile.column);
					
				}
				
				if (matchedTiles.length > 0) {
					
					Score.text = String (_currentScore);
					dropTiles ();
					
				}
				
			}
			
		}
		
		
		private function TileContainer_onMouseDown (event:MouseEvent):void {
			
			if (event.target is Tile) {
				
				selectedTile = event.target as Tile;
				cacheMouse = new Point (event.stageX, event.stageY);
				
			} else {
				
				cacheMouse = null;
				selectedTile = null;
				
			}
			
		}
		
		
	}
	
	
}
