package eu.proto.RoomNavigation.gameActors
{
	import eu.proto.RoomNavigation.Game;
	import eu.proto.RoomNavigation.sceneBase.PathfinderSprite;
    import flash.geom.Rectangle;
	import starling.display.Image;
    import starling.textures.Texture;
	
	public class Toy extends PathfinderSprite
	{
		private var image:Image;
		private var texture:Texture;
		
		public function Toy()
		{
			super();
            createImage();
        }

        private function createImage():void
        {
            texture = Game.gameAtlas.getTexture("piece");

            image = new Image(texture);
            image.x = -56;
            image.y = -60;
            addChild(image);
        }
    }

}