package {
	
	
	import openfl.display.MovieClip;
	import openfl.display.Sprite;
	import openfl.display.Stage;
	import openfl.events.Event;
	import openfl.utils.AssetLibrary;
	
	
	public class App extends Sprite {
		
		
		private var columnOffsetHeight:Number;
		private var headerOffsetWidth:Number;
		private var layout:MovieClip;
		
		
		public function App () {
			
			super ();
			
			AssetLibrary.loadFromFile ("layout.bundle").onComplete (function (library:AssetLibrary):void {
				
				layout = library.getMovieClip ("Layout");
				addChild (layout);
				
				columnOffsetHeight = (layout.Column.height - layout.height);
				headerOffsetWidth = (layout.Header.width - layout.width);
				
				resize ();
				stage.addEventListener (Event.RESIZE, resize);
				
			});
			
		}
		
		
		private function resize (event:Event = null):void {
			
			var background:MovieClip = layout.Background as MovieClip;
			var column:MovieClip = layout.Column as MovieClip;
			var header:MovieClip = layout.Header as MovieClip;
			
			background.width = stage.stageWidth;
			background.height = stage.stageHeight;
			
			var columnHeight:Number = stage.stageHeight + columnOffsetHeight;
			column.height = (columnHeight > 0 ? columnHeight : 0);
			
			var headerWidth:Number = stage.stageWidth + headerOffsetWidth;
			header.width = (headerWidth > 0 ? headerWidth : 0);
			
		}
		
		
	}
	
	
}