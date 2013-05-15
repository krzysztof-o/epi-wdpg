package eu.proto.RoomNavigation.gameActors {
    import eu.proto.RoomNavigation.Game;
    import eu.proto.RoomNavigation.sceneBase.Impediment;

    import starling.display.Image;
    import starling.textures.Texture;

    public class Carpet extends Impediment {

        public function Carpet() {
            super();
            createImage();
            penalty = 100;
        }

        private function createImage():void
        {
            texture = Game.gameAtlas.getTexture("carpet");
            image = new Image(texture);
            image.x = -55;
            image.y = -60;
            addChild(image);
        }
    }
}
