package eu.proto.RoomNavigation.sceneBase {
    import eu.proto.RoomNavigation.gameActors.*;

    import starling.display.Image;
    import starling.display.Sprite;
    import starling.textures.Texture;

    public class Impediment extends Sprite {

        public var penalty:uint = 0;
        public var widthInNodes:uint = 1;
        public var heightInNodes:uint = 1;

        public var image:Image;
        protected var texture:Texture;

        public function set positionX(value:uint):void
        {
            if(value < 0)
            {
                value = 0;
            }
            if(value > 19)
            {
                value = 19;
            }
            x = Room.TILE_WIDTH/2 + Room.TILE_WIDTH * value;
        }

        public function get positionX():uint
        {
            return x/Room.TILE_WIDTH - 0.5;
        }

        public function set positionY(value:uint):void
        {
            if(value < 0)
            {
                value = 0;
            }
            if(value > 19)
            {
                value = 19;
            }
            y = Room.TILE_HEIGHT/2 + Room.TILE_HEIGHT * value;
        }

        public function get positionY():uint
        {
            return Math.round(y/Room.TILE_HEIGHT - 0.5);
        }

        public function Impediment() {
            super();
            touchable = false;
        }
    }
}
