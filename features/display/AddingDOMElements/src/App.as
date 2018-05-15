package {
	
	
	import openfl.display.Bitmap;
	import openfl.display.BitmapData;
	import openfl.display.DOMElement;
	import openfl.display.Sprite;
	
	
	public class App extends Sprite {
		
		
		public function App () {
			
			super ();
			
			BitmapData.loadFromFile ("openfl.png").onComplete (function (bitmapData:BitmapData):void {
				
				var bitmap:Bitmap = new Bitmap (bitmapData);
				addChild (bitmap);
				
				var div:HTMLDivElement = document.createElement ("div") as HTMLDivElement;
				div.style.fontFamily = "sans-serif";
				div.style.overflow = "auto";
				div.style.height = "100px";
				div.style.width = "400px";
				div.spellcheck = false;
				div.contentEditable = "true";
				
				div.innerText = "Ego sum via, et veritas, et vita. Nemo venit ad Patrem, nisi per me. Si cognovissetis me, et Patrem meum utique cognovissetis: et amodo cognoscetis eum, et vidistis eum. Dicit ei Philippus: Domine, ostende nobis Patrem, et sufficit nobis. Dicit ei Jesus: Tanto tempore vobiscum sum, et non cognovistis me? Philippe, qui videt me, videt et Patrem. Quomodo tu dicis: Ostende nobis Patrem? Non creditis quia ego in Patre, et Pater in me est? Verba quæ ego loquor vobis, a meipso non loquor. Pater autem in me manens, ipse fecit opera. Non creditis quia ego in Patre, et Pater in me est? Alioquin propter opera ipsa credite. Amen, amen dico vobis, qui credit in me, opera quæ ego facio, et ipse faciet, et majora horum faciet: quia ego ad Patrem vado. Et quodcumque petieritis Patrem in nomine meo, hoc faciam: ut glorificetur Pater in Filio. Si quid petieritis me in nomine meo, hoc faciam. Si diligitis me, mandata mea servate: et ego rogabo Patrem, et alium Paraclitum dabit vobis, ut maneat vobiscum in æternum, Spiritum veritatis, quem mundus non potest accipere, quia non videt eum, nec scit eum: vos autem cognoscetis eum, quia apud vos manebit, et in vobis erit. Non relinquam vos orphanos: veniam ad vos.";
				
				var domSprite:DOMElement = new DOMElement (div);
				domSprite.alpha = 0.5;
				domSprite.x = 40;
				domSprite.y = 100;
				domSprite.rotation = 8;
				addChild (domSprite);
				
				var sprite:Sprite = new Sprite ();
				sprite.graphics.beginFill (0x777777);
				sprite.graphics.drawCircle (50, 50, 50);
				sprite.x = 250;
				sprite.y = 160;
				addChild (sprite);
				
			}).onError (function (e:Error):void { trace (e); });
			
		}
		
		
	}
	
	
}