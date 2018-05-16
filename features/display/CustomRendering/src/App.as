package {
	
	
	import openfl.display.BitmapData;
	import openfl.display.CanvasRenderer;
	import openfl.display.DisplayObjectShader;
	import openfl.display.DOMRenderer;
	import openfl.display.OpenGLRenderer;
	import openfl.display.Shader;
	import openfl.display.Sprite;
	import openfl.display.Stage;
	import openfl.events.RenderEvent;
	import openfl.geom.Matrix;
	import openfl.utils.Assets;
	
	
	public class App extends Sprite {
		
		
		private var bitmapData:BitmapData;
		private var domImage:HTMLImageElement;
		private var glBuffer:WebGLBuffer;
		private var glMatrixUniform:WebGLUniformLocation;
		private var glProgram:WebGLProgram;
		private var glShader:Shader;
		private var glTexture:WebGLTexture;
		private var glTextureAttribute:int;
		private var glVertexAttribute:int;
		
		
		public function App () {
			
			super ();
			
			BitmapData.loadFromFile ("assets/openfl.png").onComplete (function (_bitmapData:BitmapData):void {
				
				bitmapData = _bitmapData;
				
				addEventListener (RenderEvent.CLEAR_DOM, clearDOM);
				addEventListener (RenderEvent.RENDER_CANVAS, renderCanvas);
				addEventListener (RenderEvent.RENDER_DOM, renderDOM);
				addEventListener (RenderEvent.RENDER_OPENGL, renderOpenGL);
				
				invalidate ();
				
			}).onError (function (e:Error):void {
				
				trace (e);
				
			});
			
			x = 100;
			y = 100;
			rotation = 6;
			
		}
		
		
		private function clearDOM (event:RenderEvent):void {
			
			var renderer:DOMRenderer = event.renderer as DOMRenderer;
			renderer.clearStyle (domImage);
			
		}
		
		
		private function renderCanvas (event:RenderEvent):void {
			
			var renderer:CanvasRenderer = event.renderer as CanvasRenderer;
			var context:CanvasRenderingContext2D = renderer.context;
			var transform:Matrix = event.objectMatrix;
			
			context.setTransform (transform.a, transform.b, transform.c, transform.d, transform.tx, transform.ty);
			context.drawImage (bitmapData.image.src, 0, 0, bitmapData.width, bitmapData.height);
			
		}
		
		
		private function renderDOM (event:RenderEvent):void {
			
			var renderer:DOMRenderer = event.renderer as DOMRenderer;
			
			if (domImage == null) {
				
				domImage = document.createElement ("img") as HTMLImageElement;
				domImage.src = "assets/openfl.png";
				
			}
			
			renderer.applyStyle (this, domImage);
			
		}
		
		
		private function renderOpenGL (event:RenderEvent):void {
			
			var renderer:OpenGLRenderer = event.renderer as OpenGLRenderer;
			var gl:WebGLRenderingContext = renderer.gl;
			
			if (glShader == null) {
				
				glShader = new DisplayObjectShader ();
				
			}
			
			renderer.setShader (glShader);
			renderer.applyAlpha (1.0);
			renderer.applyColorTransform (event.objectColorTransform);
			renderer.applyBitmapData (bitmapData, event.allowSmoothing);
			renderer.applyMatrix (renderer.getMatrix (event.objectMatrix));
			renderer.updateShader ();
			
			if (glBuffer == null) {
				
				var data:Array = [
					
					bitmapData.width, bitmapData.height, 0, 1, 1,
					0, bitmapData.height, 0, 0, 1,
					bitmapData.width, 0, 0, 1, 0,
					0, 0, 0, 0, 0
					
				];
				
				glBuffer = gl.createBuffer ();
				gl.bindBuffer (gl.ARRAY_BUFFER, glBuffer);
				gl.bufferData (gl.ARRAY_BUFFER, new Float32Array (data), gl.STATIC_DRAW);
				
			} else {
				
				gl.bindBuffer (gl.ARRAY_BUFFER, glBuffer);
				
			}
			
			gl.vertexAttribPointer (glShader.data.openfl_Position.index, 3, gl.FLOAT, false, 5 * 4, 0);
			gl.vertexAttribPointer (glShader.data.openfl_TextureCoord.index, 2, gl.FLOAT, false, 5 * 4, 3 * 4);
			
			gl.drawArrays (gl.TRIANGLE_STRIP, 0, 4);
			gl.bindBuffer (gl.ARRAY_BUFFER, null);
			
		}
		
		
	}
	
	
}