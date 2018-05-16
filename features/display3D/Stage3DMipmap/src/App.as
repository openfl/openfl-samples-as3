package {
	
	
	import openfl.display.Bitmap;
	import openfl.display.BitmapData;
	import openfl.display.Sprite;
	import openfl.display.Stage;
	import openfl.display.StageAlign;
	import openfl.display.StageScaleMode;
	import openfl.display3D.textures.Texture;
	import openfl.display3D.Context3D;
	import openfl.display3D.Context3DBlendFactor;
	import openfl.display3D.Context3DProgramType;
	import openfl.display3D.Context3DTextureFormat;
	import openfl.display3D.Context3DVertexBufferFormat;
	import openfl.display3D.IndexBuffer3D;
	import openfl.display3D.Program3D;
	import openfl.display3D.VertexBuffer3D;
	import openfl.events.Event;
	import openfl.events.KeyboardEvent;
	import openfl.geom.Matrix;
	import openfl.geom.Matrix3D;
	import openfl.geom.Rectangle;
	import openfl.geom.Vector3D;
	import openfl.ui.Keyboard;
	import openfl.utils.AGALMiniAssembler;
	import openfl.utils.Assets;
	import openfl.utils.getTimer;
	import openfl.Vector;
	
	
	public class App extends Sprite {
		
		
		private static var DAMPING:Number = 1.09;
		private static var LINEAR_ACCELERATION:Number = 0.0005;
		private static var MAX_FORWARD_VELOCITY:Number = 0.05;
		private static var MAX_ROTATION_VELOCITY:Number = 0.5;
		private static var ROTATION_ACCELERATION:Number = 0.01;
		
		private var bitmapData:BitmapData;
		private var cameraLinearAcceleration:Number;
		private var cameraLinearVelocity:Vector3D;
		private var cameraRotationAcceleration:Number;
		private var cameraRotationVelocity:Number;
		private var cameraWorldTransform:Matrix3D;
		private var context3D:Context3D;
		private var indexBuffer:IndexBuffer3D; 
		private var program:Program3D;
		private var projectionTransform:PerspectiveMatrix3D;
		private var texture:Texture;
		private var vertexbuffer:VertexBuffer3D;
		private var viewTransform:Matrix3D;
		
		
		public function App () {
			
			super ();
			
			stage.stage3Ds[0].addEventListener (Event.CONTEXT3D_CREATE, stage3D_onContext3DCreate);
			stage.stage3Ds[0].requestContext3D ();
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
			
			stage.addEventListener (KeyboardEvent.KEY_DOWN, stage_onKeyDown);
			stage.addEventListener (KeyboardEvent.KEY_UP, stage_onKeyUp);
			
		}
		
		
		private function calculateUpdatedVelocity (curVelocity:Number, curAcceleration:Number, maxVelocity:Number):Number {
			
			var newVelocity:Number;
			
			if (curAcceleration != 0) {
				
				newVelocity = curVelocity + curAcceleration;
				
				if (newVelocity > maxVelocity) {
					
					newVelocity = maxVelocity;
					
				} else if (newVelocity < -maxVelocity) {
					
					newVelocity = - maxVelocity;
					
				}
				
			} else {
				
				newVelocity = curVelocity / DAMPING;
				
			}
			
			return newVelocity;
			
		}
		
		
		private function initialize ():void {
			
			context3D = stage.stage3Ds[0].context3D;
			
			context3D.configureBackBuffer (550, 400, 1, true);
			
			var vertices:openfl.Vector = openfl.Vector.ofArray ([
				-0.3, -0.3, 0, 0, 0,
				-0.3, 0.3, 0, 0, 1,
				0.3, 0.3, 0, 1, 1,
				0.3, -0.3, 0, 1, 0 ]);
			
			vertexbuffer = context3D.createVertexBuffer (4, 5);
			vertexbuffer.uploadFromVector (vertices, 0, 4);
			
			indexBuffer = context3D.createIndexBuffer (6);
			indexBuffer.uploadFromVector (openfl.Vector.ofArray ([ 0, 1, 2, 2, 3, 0 ]), 0, 6);
			
			texture = context3D.createTexture (bitmapData.width, bitmapData.height, Context3DTextureFormat.BGRA, false);
			uploadTextureWithMipMaps (texture, bitmapData);
			
			var vertexShaderAssembler:AGALMiniAssembler = new AGALMiniAssembler ();
			vertexShaderAssembler.assemble (Context3DProgramType.VERTEX,
				"m44 op, va0, vc0\n" +
				"mov v0, va1"
			);
			
			var fragmentShaderAssembler:AGALMiniAssembler = new AGALMiniAssembler ();
			fragmentShaderAssembler.assemble (Context3DProgramType.FRAGMENT,
				"tex ft1, v0, fs0 <2d,linear,nomip>\n" +
				"mov oc, ft1"
			);
			
			program = context3D.createProgram ();
			program.upload (vertexShaderAssembler.agalcode, fragmentShaderAssembler.agalcode);
			
			cameraWorldTransform = new Matrix3D ();
			cameraWorldTransform.appendTranslation (0, 0, -2);
			viewTransform = new Matrix3D ();
			viewTransform = cameraWorldTransform.clone ();
			viewTransform.invert ();
			
			cameraLinearVelocity = new Vector3D ();
			cameraRotationVelocity = 0;
			
			cameraLinearAcceleration = 0;
			cameraRotationAcceleration = 0;
			
			projectionTransform = new PerspectiveMatrix3D ();
			
			var aspect:Number = 4 / 3;
			var zNear:Number = 0.1;
			var zFar:Number = 1000;
			var fov:Number = 45 * Math.PI / 180;
			
			projectionTransform.perspectiveFieldOfViewLH (fov, aspect, zNear, zFar);
			
		}
		
		
		private function render ():void {
			
			if (context3D == null) {
				
				return;
				
			}
			
			context3D.clear (1, 1, 1, 1);
			context3D.setBlendFactors (Context3DBlendFactor.ONE, Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
			
			context3D.setVertexBufferAt (0, vertexbuffer, 0, Context3DVertexBufferFormat.FLOAT_3);
			context3D.setVertexBufferAt (1, vertexbuffer, 3, Context3DVertexBufferFormat.FLOAT_2);
			
			context3D.setTextureAt (0, texture);
			context3D.setProgram (program);
			
			updateViewMatrix ();
			
			var matrix:Matrix3D = new Matrix3D ();
			matrix.appendRotation (getTimer () / 30, Vector3D.Y_AXIS);
			matrix.appendRotation (getTimer () / 10, Vector3D.X_AXIS);
			matrix.appendTranslation (0, 0, -1);
			matrix.append (viewTransform);
			matrix.append (projectionTransform);
			
			context3D.setProgramConstantsFromMatrix (Context3DProgramType.VERTEX, 0, matrix, true);
			
			context3D.drawTriangles (indexBuffer);
			context3D.present ();
			
		}
		
		
		private function updateViewMatrix ():void {
			
			cameraLinearVelocity.z = calculateUpdatedVelocity (cameraLinearVelocity.z, cameraLinearAcceleration, MAX_FORWARD_VELOCITY);
			cameraRotationVelocity = calculateUpdatedVelocity (cameraRotationVelocity, cameraRotationAcceleration, MAX_ROTATION_VELOCITY); 
			
			cameraWorldTransform.appendRotation (cameraRotationVelocity, Vector3D.Y_AXIS, cameraWorldTransform.position);
			cameraWorldTransform.position = cameraWorldTransform.transformVector (cameraLinearVelocity);
			
			viewTransform.copyFrom (cameraWorldTransform);
			viewTransform.invert ();
			
		}
		
		
		private function uploadTextureWithMipMaps (texture:Texture, originalImage:BitmapData):void {
			
			var mipWidth:int = originalImage.width;
			var mipHeight:int = originalImage.height;
			var mipLevel:int = 0;
			var mipImage:BitmapData = new BitmapData (originalImage.width, originalImage.height);
			var scaleTransform:Matrix = new Matrix ();
			
			while (mipWidth > 0 && mipHeight > 0) {
				
				mipImage.draw (originalImage, scaleTransform, null, null, null, true);
				texture.uploadFromBitmapData (mipImage, mipLevel);
				scaleTransform.scale (0.5, 0.5);
				mipLevel++;
				mipWidth >>= 1;
				mipHeight >>= 1;
				
			}
			
			mipImage.dispose ();
			
		}
		
		
		
		
		// Event Handlers
		
		
		
		
		private function stage_onKeyDown (event:KeyboardEvent):void {
			
			switch (event.keyCode) {
				
				case Keyboard.LEFT:
					
					cameraRotationAcceleration = -ROTATION_ACCELERATION;
					break;
				
				case Keyboard.UP:
					
					cameraLinearAcceleration = LINEAR_ACCELERATION;
					break;
				
				case Keyboard.RIGHT:
					
					cameraRotationAcceleration = ROTATION_ACCELERATION;
					break;
				
				case Keyboard.DOWN:
					
					cameraLinearAcceleration = -LINEAR_ACCELERATION;
					break;
				
			}
			
		}
		
		
		private function stage_onKeyUp (event:KeyboardEvent):void {
			
			switch (event.keyCode) {
				
				case Keyboard.LEFT:
				case Keyboard.RIGHT:
					
					cameraRotationAcceleration = 0;
					break;
				
				case Keyboard.UP:
				case Keyboard.DOWN:
					
					cameraLinearAcceleration = 0;
					break;
				
			}
			
		}
		
		
		private function stage3D_onContext3DCreate (event:Event):void {
			
			BitmapData.loadFromFile ("checkers.png").onComplete (function (_bitmapData:BitmapData):void {
				
				bitmapData = _bitmapData;
				
				initialize ();
				
			}).onError (function (e:Error):void {
				
				trace (e);
				
			});
			
		}
		
		
		private function this_onEnterFrame (event:Event):void {
			
			render ();
			
		}
		
		
	}
	
	
}