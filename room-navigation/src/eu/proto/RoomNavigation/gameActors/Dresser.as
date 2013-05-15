package eu.proto.RoomNavigation.gameActors {
    import eu.proto.RoomNavigation.Game;
    import eu.proto.RoomNavigation.sceneBase.Impediment;

    import starling.display.Image;
    import starling.textures.Texture;

    public class Dresser extends Impediment {

        public function Dresser() {
            super();
            createImage();
            penalty = 1000;
        }

        private function createImage():void
        {
            texture = Game.gameAtlas.getTexture("dresser");
            image = new Image(texture);
            image.x = -55;
            image.y = -95;
            addChild(image);
        }
    }
}
