package eu.proto.CapsSoccerMobile.gameActors 
{
	import eu.proto.CapsSoccerMobile.Game;
	import eu.proto.CapsSoccerMobile.sceneBase.BodySprite;
	import flash.geom.Rectangle;
	import starling.display.Image;
	import starling.textures.Texture;
	
	/**
	 * Graphical and physical representation of the a cap, with it's own touch interface
	 */
	
	public class Cap extends BodySprite 
	{
		private var image:Image;
		private var texture:Texture;
		
		public static const KIND_BALL:int = 0;
		public static const KIND_PL:int = 1;
		public static const KIND_DE:int = 2;
		
		private var _kind:int = 0;

        public function get kind():int {
            return _kind;
        }
		
		public function Cap(kind:int = 0) 
		{
			super();
			_kind = kind;
            createImage();
		}

        private function createImage():void
        {
            switch(kind)
            {
                case KIND_PL:
                    texture = Texture.fromTexture(Game.gameTexture, new Rectangle(500, 1548, 500, 500));
                    break;
                case KIND_DE:
                    texture = Texture.fromTexture(Game.gameTexture, new Rectangle(0, 1548, 500, 500));
                    break;
                default:
                    texture = Texture.fromTexture(Game.gameTexture, new Rectangle(1000, 1548, 500, 500));
                    break;
            }

            image = new Image(texture);
            image.width = 100;
            image.height = 100;
            image.x = -50;
            image.y = -50;
            addChild(image);
        }


    }

}