package eu.proto.RoomNavigation.sceneBase
{
    import com.greensock.TimelineLite;
    import com.greensock.TweenLite;

    import eu.proto.RoomNavigation.gameActors.Room;
    import eu.proto.RoomNavigation.logic.Node;
    import eu.proto.RoomNavigation.logic.PathfindingLogic;

    import flash.geom.Point;

    import starling.display.Sprite;
    import starling.events.Event;

    public class PathfinderSprite extends Sprite
	{
        public static var INVALIDATE_OFFSET:String = "invalidateOffset";
        public var pathfindingLogic:PathfindingLogic = new PathfindingLogic();
        private var timeline:TimelineLite = new TimelineLite();

        public function set positionX(value:uint):void
        {
            x = Room.TILE_WIDTH/2 + Room.TILE_WIDTH * value;
        }

        public function get positionX():uint
        {
            return x/Room.TILE_WIDTH - 0.5;
        }

        public function set positionY(value:uint):void
        {
            y = Room.TILE_HEIGHT/2 + Room.TILE_HEIGHT * value;
        }

        public function get positionY():uint
        {
            return Math.round(y/Room.TILE_HEIGHT - 0.5);
        }

        private var _lastPositionX:uint;
        private var _lastPositionY:uint;

        public override function set y(value:Number):void
        {
            _lastPositionY = positionY;
            super.y = value;
            if(_lastPositionX != positionY)
            {
                dispatchEventWith(INVALIDATE_OFFSET);
            }
        }

		public function PathfinderSprite()
		{
            super();
            addEventListener(Event.ADDED_TO_STAGE, on_added);
		}

        private function on_added(event:Event):void {
            if(!pathfindingLogic.debugLayer.parent)
            {
                parent.addChild(pathfindingLogic.debugLayer);
            }
        }

        public function set debug(value:Boolean):void {
            if(value)
            {
                parent.addChild(pathfindingLogic.debugLayer);
            }
            else
            {
                parent.removeChild(pathfindingLogic.debugLayer);
            }
        }

        public function navigateTo(xTarget, yTarget):void
        {
            var path:Vector.<Node> = pathfindingLogic.findPath(Math.floor(x/Room.TILE_WIDTH), Math.floor(y/Room.TILE_HEIGHT), xTarget, yTarget, parent as Scene);
            var last_position:Point = new Point((x - Room.TILE_WIDTH/2) / Room.TILE_WIDTH, (y - Room.TILE_HEIGHT/2) / Room.TILE_HEIGHT);

            if(timeline.currentProgress > 0)
            {
                timeline.stop();
            }
            timeline = new TimelineLite();
            for each(var node:Node in path)
            {
                timeline.append(TweenLite.to(this, 0.03 * (node.penalty + 10 * Math.sqrt(Math.pow(node.x - last_position.x, 2) + Math.pow(node.y - last_position.y, 2))),
                        {x:Room.TILE_WIDTH/2 + Room.TILE_WIDTH * node.x, y:Room.TILE_HEIGHT/2 + Room.TILE_HEIGHT * node.y}));
                last_position.x = node.x;
                last_position.y = node.y;
            }
            timeline.play();
        }
	}

}