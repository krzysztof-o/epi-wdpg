package eu.proto.CapsSoccerMobile 
{
	import eu.proto.CapsSoccerMobile.gameActors.Stadium;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * Starling display root class
	 */

	public final class Game extends Sprite 
	{		
		public var scene:Stadium;
		
		[Embed(source = "/assets/graphics.png")]
		private static var textureBitmap:Class;
		
		
		//the only texture referenced in the project
		public static var gameTexture:Texture;
		
		public function Game() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void 
		{			
			gameTexture = Texture.fromBitmap(new textureBitmap());
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			//Stadium extends Scene
			scene = new Stadium();
			addChild(scene);			
		}
	}
}