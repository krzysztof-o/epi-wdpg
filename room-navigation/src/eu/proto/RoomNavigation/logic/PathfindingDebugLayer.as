package eu.proto.RoomNavigation.logic {
    import eu.proto.RoomNavigation.Game;
    import eu.proto.RoomNavigation.sceneBase.NodeDebugSprite;

    import flash.utils.Dictionary;
    import flash.utils.clearTimeout;
    import flash.utils.setTimeout;

    import starling.display.Sprite;
    import starling.events.Event;

    public class PathfindingDebugLayer extends Sprite {

        private var delayCounter:int = 0;
        private var timeouts:Vector.<uint> = new Vector.<uint>();

        private var nodeDebugSprites:Dictionary = new Dictionary();

        public function PathfindingDebugLayer() {
            super();
        }

        public function reset():void
        {
            nodeDebugSprites = new Dictionary();
            while(numChildren > 0)
            {
                getChildAt(0).dispose();
                removeChildAt(0);
            }
            delayCounter = 0;
            while(timeouts.length > 0)
            {
                clearTimeout(timeouts.pop());
            }
        }

        public function on_node_cost_changed(event:Event):void
        {
            if(!nodeDebugSprites[(event.currentTarget as Node).x+","+(event.currentTarget as Node).y])
            {
                nodeDebugSprites[(event.currentTarget as Node).x+","+(event.currentTarget as Node).y] = new NodeDebugSprite(event.data as Node);
                timeouts.push(setTimeout(addChild, Game.slider.value * delayCounter, nodeDebugSprites[(event.currentTarget as Node).x+","+(event.currentTarget as Node).y]));
            }
            else
            {
                timeouts.push(setTimeout(nodeDebugSprites[(event.currentTarget as Node).x+","+(event.currentTarget as Node).y].update, Game.slider.value * delayCounter, event.data as Node));
            }
            delayCounter++;
        }
    }
}
