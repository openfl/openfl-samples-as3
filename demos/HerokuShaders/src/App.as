package {
	
	
	import openfl.display.OpenGLRenderer;
	import openfl.display.Sprite;
	import openfl.display.Stage;
	import openfl.events.Event;
	import openfl.events.RenderEvent;
	import openfl.geom.Matrix3D;
	import openfl.geom.Rectangle;
	import openfl.utils.AssetLibrary;
	import openfl.utils.AssetManifest;
	import openfl.utils.Assets;
	import openfl.utils.ByteArray;
	import openfl.Lib;
	
	
	public class App extends Sprite {
		
		
		private static var glFragmentShaders:Array = [ "6286", "6288.1", "6284.1", "6238", "6223.2", "6175", "6162", "6147.1", "6049", "6043.1", "6022", "5891.5", "5805.18", "5812", "5733", "5454.21", "5492", "5359.8", "5398.8", "4278.1" ];
		private static var maxTime:int = 7000;
		
		private var currentIndex:int;
		private var glBackbufferUniform:WebGLUniformLocation;
		private var glBuffer:WebGLBuffer;
		private var glCurrentProgram:WebGLProgram;
		private var glMouseUniform:WebGLUniformLocation;
		private var glPositionAttribute:int;
		private var glResolutionUniform:WebGLUniformLocation;
		private var glSurfaceSizeUniform:WebGLUniformLocation;
		private var glTimeUniform:WebGLUniformLocation;
		private var glVertexPosition:int;
		private var initialized:Boolean;
		private var startTime:int;
		
		
		public function App () {
			
			super ();
			
			glFragmentShaders = randomizeArray (glFragmentShaders);
			currentIndex = 0;
			
			addEventListener (RenderEvent.RENDER_OPENGL, render);
			addEventListener (Event.ENTER_FRAME, enterFrame);
			
		}
		
		
		private function enterFrame (event:Event):void {
			
			invalidate ();
			
		}
		
		
		private function glCompile (gl:WebGLRenderingContext):void {
			
			var program:WebGLProgram = gl.createProgram ();
			var vertex:String = Assets.getText ("assets/heroku.vert");
			
			var fragment:String = "precision mediump float;";
			fragment += Assets.getText ("assets/" + glFragmentShaders[currentIndex] + ".frag");
			
			var vs:WebGLShader = glCreateShader (gl, vertex, gl.VERTEX_SHADER);
			var fs:WebGLShader = glCreateShader (gl, fragment, gl.FRAGMENT_SHADER);
			
			if (vs == null || fs == null) return;
			
			gl.attachShader (program, vs);
			gl.attachShader (program, fs);
			
			gl.deleteShader (vs);
			gl.deleteShader (fs);
			
			gl.linkProgram (program);
			
			if (gl.getProgramParameter (program, gl.LINK_STATUS) == 0) {
				
				trace (gl.getProgramInfoLog (program));
				trace ("VALIDATE_STATUS: " + gl.getProgramParameter (program, gl.VALIDATE_STATUS));
				trace ("ERROR: " + gl.getError ());
				return;
				
			}
			
			if (glCurrentProgram != null) {
				
				gl.deleteProgram (glCurrentProgram);
				
			}
			
			glCurrentProgram = program;
			
			glPositionAttribute = gl.getAttribLocation (glCurrentProgram, "surfacePosAttrib");
			gl.enableVertexAttribArray (glPositionAttribute);
			
			glVertexPosition = gl.getAttribLocation (glCurrentProgram, "position");
			gl.enableVertexAttribArray (glVertexPosition);
			
			glTimeUniform = gl.getUniformLocation (program, "time");
			glMouseUniform = gl.getUniformLocation (program, "mouse");
			glResolutionUniform = gl.getUniformLocation (program, "resolution");
			glBackbufferUniform = gl.getUniformLocation (program, "backglBuffer");
			glSurfaceSizeUniform = gl.getUniformLocation (program, "surfaceSize");
			
			startTime = Lib.getTimer ();
			
		}
		
		
		private function glCreateShader (gl:WebGLRenderingContext, source:String, type:int):WebGLShader {
			
			var shader:WebGLShader = gl.createShader (type);
			gl.shaderSource (shader, source);
			gl.compileShader (shader);
			
			if (gl.getShaderParameter (shader, gl.COMPILE_STATUS) == 0) {
				
				trace (gl.getShaderInfoLog (shader));
				return null;
				
			}
			
			return shader;
			
		}
		
		
		private function glInitialize (gl:WebGLRenderingContext):void {
			
			if (!initialized) {
				
				glBuffer = gl.createBuffer ();
				gl.bindBuffer (gl.ARRAY_BUFFER, glBuffer);
				var glBufferArray:Float32Array = new Float32Array ([ -1.0, -1.0, 1.0, -1.0, -1.0, 1.0, 1.0, -1.0, 1.0, 1.0, -1.0, 1.0 ]);
				gl.bufferData (gl.ARRAY_BUFFER, glBufferArray, gl.STATIC_DRAW);
				gl.bindBuffer (gl.ARRAY_BUFFER, null);
				
				glCompile (gl);
				
				initialized = true;
				
			}
			
		}
		
		
		private function randomizeArray (array:Array):Array {
			
			var arrayCopy:Array = array.concat ();
			var randomArray:Array = new Array ();
			
			while (arrayCopy.length > 0) {
				
				var randomIndex:int = Math.round (Math.random () * (arrayCopy.length - 1));
				randomArray.push (arrayCopy.splice (randomIndex, 1)[0]);
				
			}
			
			return randomArray;
			
		}
		
		
		private function render (event:RenderEvent):void {
			
			var renderer:OpenGLRenderer = event.renderer as OpenGLRenderer;
			var gl:WebGLRenderingContext = renderer.gl;
			
			glInitialize (gl);
			
			if (glCurrentProgram == null) return;
			
			var time:Number = Lib.getTimer () - startTime;
			
			gl.useProgram (glCurrentProgram);
			
			gl.uniform1f (glTimeUniform, time / 1000);
			gl.uniform2f (glMouseUniform, 0.1, 0.1); //gl.uniform2f (glMouseUniform, (stage.mouseX / stage.stageWidth) * 2 - 1, (stage.mouseY / stage.stageHeight) * 2 - 1);
			gl.uniform2f (glResolutionUniform, stage.stageWidth, stage.stageHeight);
			gl.uniform1i (glBackbufferUniform, 0 );
			gl.uniform2f (glSurfaceSizeUniform, stage.stageWidth, stage.stageHeight);
			
			gl.bindBuffer (gl.ARRAY_BUFFER, glBuffer);
			gl.vertexAttribPointer (glPositionAttribute, 2, gl.FLOAT, false, 0, 0);
			gl.vertexAttribPointer (glVertexPosition, 2, gl.FLOAT, false, 0, 0);
			
			gl.clearColor (0, 0, 0, 1);
			gl.clear (gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT );
			gl.drawArrays (gl.TRIANGLES, 0, 6);
			gl.bindBuffer (gl.ARRAY_BUFFER, null);
			
			if (time > maxTime && glFragmentShaders.length > 1) {
				
				currentIndex++;
				
				if (currentIndex > glFragmentShaders.length - 1) {
					
					currentIndex = 0;
					
				}
				
				glCompile (gl);
				
			}
			
		}
		
		
	}
	
	
}