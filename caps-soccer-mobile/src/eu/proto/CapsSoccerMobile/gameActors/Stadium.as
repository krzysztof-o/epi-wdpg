package eu.proto.CapsSoccerMobile.gameActors 
{
	import eu.proto.CapsSoccerMobile.Game;
	import eu.proto.CapsSoccerMobile.sceneBase.Scene;
	import flash.geom.Rectangle;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * Class representing the game board, managing its display, physics, logic and touch interface
	 */
	
	public class Stadium extends Scene 
	{
		private var background:Image;
		
		public function Stadium()
		{
			super();
		}
		
		override protected function onAdded(e:Event):void
		{
			super.onAdded(e);
			center();
			
			var texture:Texture = Texture.fromTexture(Game.gameTexture, new Rectangle(0, 0, 2048, 1407));
			background = new Image(texture);
			addChild(background);
		}
		
		public function center():void
		{ 
			Scene.displayOffset.x = - 1024 * displayScale + stage.stageWidth / 2 + pivotX * displayScale;
			Scene.displayOffset.y = - 703 * displayScale + stage.stageHeight / 2 + pivotY * displayScale;
		}
	}

}