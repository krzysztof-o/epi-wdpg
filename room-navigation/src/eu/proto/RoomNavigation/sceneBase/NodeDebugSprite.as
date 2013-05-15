package eu.proto.RoomNavigation.sceneBase
{
    import com.greensock.TweenLite;
    import com.greensock.TweenLite;
    import com.greensock.easing.Back;
    import com.greensock.easing.Cubic;

    import eu.proto.RoomNavigation.gameActors.Room;
    import eu.proto.RoomNavigation.logic.Node;

    import flash.utils.clearTimeout;

    import flash.utils.setTimeout;

    import starling.display.Shape;

    import starling.display.Sprite;
    import starling.events.Event;
    import starling.text.TextField;

    public class NodeDebugSprite extends Sprite
    {
        private var costTF:TextField;
        private var heuristicTF:TextField;
        private var valueTF:TextField;

        public var node:Node;

        public var frame:Shape;
        public var arrow:Shape;

        public function NodeDebugSprite(node:Node)
        {
            super();
            this.touchable = false;
            this.node = node;
            this.x = Room.TILE_WIDTH/2 + Room.TILE_WIDTH * node.x;
            this.y = Room.TILE_HEIGHT/2 + Room.TILE_HEIGHT * node.y;
            this.pivotX = Room.TILE_WIDTH/2;
            this.pivotY = Room.TILE_HEIGHT/2;
            addEventListener(Event.ADDED_TO_STAGE, on_added);
        }

        private function on_added(event:Event):void
        {
            frame = new Shape();
            frame.graphics.lineStyle(2,0xFFFFFF);
            frame.graphics.drawRect(1.5, 1.5, 107, 97);
            addChild(frame);

            arrow = new Shape();
            arrow.pivotX = 0;
            arrow.pivotY = 1.5;
            arrow.x = 55;
            arrow.y = 49;

            if(node.parent)
            {
                arrow.graphics.beginFill(0xFFFF00, 1);
                arrow.graphics.drawRect(0, -1.5, 45, 3);
                arrow.graphics.endFill();
                addChild(arrow);
                arrow.rotation = Math.atan2(node.parent.y - node.y, node.parent.x - node.x);
            }

            costTF = new TextField(50, 30, node.cost.toString(), "Arial", 20, 0xFFFFFF, true);
            addChild(costTF);

            heuristicTF = new TextField(50, 30, node.heuristic.toString(), "Arial", 20, 0xFFFFFF, true);
            heuristicTF.x = 55;
            addChild(heuristicTF);

            valueTF = new TextField(50, 30, node.value.toString(), "Arial", 20, 0xFFFFFF, true);
            valueTF.y = 70;
            addChild(valueTF);
            TweenLite.from(this, 0.2, {alpha:0, scaleX:0.7, scaleY:0.7, ease:Back.easeOut});
        }

        public function update(node:Node):void
        {
            this.node = null;
            this.node = node;
            if(!parent || !parent.parent)
            {
                return;
            }

            costTF.text = node.cost.toString();
            heuristicTF.text = node.heuristic.toString();
            valueTF.text = node.value.toString();

            if(node.parent)
            {
                TweenLite.to(arrow, 0.3, {rotation: Math.atan2(node.parent.y - node.y, node.parent.x - node.x), ease:Back.easeInOut});
            }

            if(node.closed)
            {
                TweenLite.killTweensOf(this, true);
                TweenLite.from(this, 0.2, {alpha:0, ease:Cubic.easeOut, scaleX: 1.3, scaleY:1.3});
                frame.graphics.clear();
                frame.graphics.lineStyle(2,0x00FF00);
                frame.graphics.beginFill(0x00FF00, 0.5);
                frame.graphics.drawRect(1.5, 1.5, 107, 97);
                frame.graphics.endFill();
            }
        }
    }
}
