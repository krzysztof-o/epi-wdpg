package eu.proto.RoomNavigation.logic {
    import de.polygonal.ds.Heapable;

    import eu.proto.RoomNavigation.Game;
    import eu.proto.RoomNavigation.gameActors.Room;

    import starling.events.EventDispatcher;

    public class Node extends EventDispatcher implements Heapable
    {
        public var position:uint;

        public function get value():uint {
            return heuristic + _cost;
        }

        private var _cost:uint = 0;

        public function get cost():uint {
            return _cost;
        }

        public function set cost(value:uint):void {
            _cost = value;
            if(hasEventListener(PathfindingLogic.EVENT_NODE_DATA_CHANGED))
            {
                var copy:Node = new Node(x, y);
                copy.cost = cost;
                copy.closed = closed;
                copy.heuristic = heuristic;
                copy.parent = parent;
                this.dispatchEventWith(PathfindingLogic.EVENT_NODE_DATA_CHANGED, true, copy);
            }
        }

        private var _closed:Boolean = false;

        public function get closed():Boolean {
            return _closed;
        }

        public function set closed(value:Boolean):void {
            _closed = value;
            if(hasEventListener(PathfindingLogic.EVENT_NODE_DATA_CHANGED))
            {
                var copy:Node = new Node(x, y);
                copy.cost = cost;
                copy.closed = closed;
                copy.heuristic = heuristic;
                copy.parent = parent;
                this.dispatchEventWith(PathfindingLogic.EVENT_NODE_DATA_CHANGED, true, copy);
            }
        }

        public var heuristic:uint = 0;

        public var penalty:uint = 0;

        public var parent:Node = null;

        public var x:int = 0;
        public var y:int = 0;

        public function Node(x:int, y:int)
        {
            this.x = x;
            this.y = y;
        }

        public function compare(other:Object):int
        {
            if(other.value > this.value)
            {
                return 1;
            }
            else if (other.value < this.value)
            {
                return -1
            }
            return 0;
        }
    }
}
