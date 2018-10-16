package {
	
	
	import motion.Actuate;
	import openfl.display.Sprite;
	import openfl.display.Stage;
	import openfl.events.AsyncErrorEvent;
	import openfl.events.MouseEvent;
	import openfl.events.NetStatusEvent;
	import openfl.media.Video;
	import openfl.net.NetConnection;
	import openfl.net.NetStream;
	
	
	public class App extends Sprite {
		
		
		private var netStream:NetStream;
		private var overlay:Sprite;
		private var video:Video;
		
		
		public function App () {
			
			super ();
			
			video = new Video ();
			addChild (video);
			
			var netConnection:NetConnection = new NetConnection ();
			netConnection.connect (null);
			
			netStream = new NetStream (netConnection);
			netStream.client = { onMetaData: client_onMetaData };
			netStream.addEventListener (AsyncErrorEvent.ASYNC_ERROR, netStream_onAsyncError); 
			
			overlay = new Sprite ();
			overlay.graphics.beginFill (0, 0.5);
			overlay.graphics.drawRect (0, 0, 560, 320);
			overlay.addEventListener (MouseEvent.MOUSE_DOWN, overlay_onMouseDown);
			addChild (overlay);
			
			netConnection.addEventListener (NetStatusEvent.NET_STATUS, netConnection_onNetStatus);
			
		}
		
		
		private function client_onMetaData (metaData:Object):void {
			
			video.attachNetStream (netStream);
			
			video.width = video.videoWidth;
			video.height = video.videoHeight;
			
		}
		
		
		private function netStream_onAsyncError (event:AsyncErrorEvent):void {
			
			trace ("Error loading video");
			
		}
		
		
		private function netConnection_onNetStatus (event:NetStatusEvent):void {
			
			if (event.info.code == "NetStream.Play.Complete") {
				
				Actuate.tween (overlay, 1, { alpha: 1 });
				
			}
			
		}
		
		
		private function overlay_onMouseDown (event:MouseEvent):void {
			
			Actuate.tween (overlay, 2, { alpha: 0 });
			netStream.play ("assets/example.mp4");
			
		}
		
		
	}
	
	
}