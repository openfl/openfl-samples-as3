package {
	
	
	import openfl.display.Sprite;
	import openfl.display.Stage;
	import openfl.display3D.Context3D;
	import openfl.display3D.Context3DBlendFactor;
	import openfl.display3D.Context3DProgramType;
	import openfl.display3D.Context3DVertexBufferFormat;
	import openfl.display3D.IndexBuffer3D;
	import openfl.display3D.Program3D;
	import openfl.display3D.VertexBuffer3D;
	import openfl.events.Event;
	import openfl.geom.Matrix3D;
	import openfl.geom.Rectangle;
	import openfl.geom.Vector3D;
	import openfl.utils.AGALMiniAssembler;
	import openfl.utils.ByteArray;
	import openfl.utils.getTimer;
	import openfl.Vector;
	
	
	public class App extends Sprite {
		
		
		private var context3D:Context3D;
		private var program:Program3D;
		private var vertexBuffer:VertexBuffer3D;
		private var indexBuffer:IndexBuffer3D;
		
		
		public function App () {
			
			super ();
			
			stage.stage3Ds[0].addEventListener (Event.CONTEXT3D_CREATE, init);
			stage.stage3Ds[0].requestContext3D ();
			
		}
		
		
		private function init (e:Event):void {
			
			context3D = stage.stage3Ds[0].context3D;
			context3D.configureBackBuffer (stage.stageWidth, stage.stageHeight, 1, true);
			
			context3D.setBlendFactors (Context3DBlendFactor.ONE, Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
			
			var vertices:openfl.Vector = openfl.Vector.ofArray ([
				-0.3, -0.3, 0, 1, 0, 0,
				-0.3, 0.3, 0, 0, 1, 0,
				0.3, 0.3, 0, 0, 0, 1 ]);
			
			vertexBuffer = context3D.createVertexBuffer (3, 6);
			vertexBuffer.uploadFromVector (vertices, 0, 3);
			
			var indices:openfl.Vector = openfl.Vector.ofArray ([ 0, 1, 2 ]);
			
			indexBuffer = context3D.createIndexBuffer (3);
			indexBuffer.uploadFromVector (indices, 0, 3);
			
			var assembler:AGALMiniAssembler = new AGALMiniAssembler ();
			
			var vertexShader:ByteArray = assembler.assemble (Context3DProgramType.VERTEX,
				"m44 op, va0, vc0\n" +
				"mov v0, va1"
			);
			
			var fragmentShader:ByteArray = assembler.assemble (Context3DProgramType.FRAGMENT,
				"mov oc, v0"
			);
			
			program = context3D.createProgram ();
			program.upload (vertexShader, fragmentShader);
			
			addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
			
		}
		
		
		
		
	 	// Event Handlers
		
		
		
		
		private function this_onEnterFrame (event:Event):void {
			
			if (context3D == null) {
				
				return;
				
			}
			
			context3D.clear (1, 1, 1, 1);
			
			context3D.setProgram (program);
			context3D.setVertexBufferAt (0, vertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_3);
			context3D.setVertexBufferAt (1, vertexBuffer, 3, Context3DVertexBufferFormat.FLOAT_3);
			
			var m:Matrix3D = new Matrix3D ();
			m.appendRotation (getTimer () / 40, Vector3D.Z_AXIS);
			context3D.setProgramConstantsFromMatrix (Context3DProgramType.VERTEX, 0, m, true);
			
			context3D.drawTriangles (indexBuffer);
			
			context3D.present ();
			
		}
		
		
	}
	
	
}