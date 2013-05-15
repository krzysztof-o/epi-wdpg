package eu.proto.RoomNavigation {

    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;

    import starling.core.Starling;

    public class RoomNavigation extends Sprite {
        private var starling:Starling;

        //Starling.multitouchEnabled = true;

        public function RoomNavigation() {
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            stage.frameRate = 60;
            stage.color = 0x000000;

            stage.addEventListener(Event.RESIZE, onResize);
        }

        public function onResize(e:Event):void
        {
            removeEventListener(Event.RESIZE, onResize);
            starling = new Starling(Game, stage);
            starling.antiAliasing = 1;
            starling.simulateMultitouch = true;
            starling.start();
        }
    }
}
