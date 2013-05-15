package eu.proto.RoomNavigation.logic {
    import de.polygonal.ds.Heap;

    import eu.proto.RoomNavigation.sceneBase.Impediment;

    import eu.proto.RoomNavigation.sceneBase.Scene;

    public class PathfindingLogic {

        public static const EVENT_NODE_DATA_CHANGED:String = "nodeCostChanged";
        public var nodes:Vector.<Vector.<Node>> = new Vector.<Vector.<Node>>();
        private var openList:Heap = new Heap();
        private var closedList:Vector.<Node> = new Vector.<Node>();

        public var debugLayer:PathfindingDebugLayer = new PathfindingDebugLayer();

        public function PathfindingLogic() {

        }

        public function findPath(startX:int, startY:int, endX:int, endY:int, room:Scene):Vector.<Node>
        {
            debugLayer.reset();

            for(var i:int = 0; i<20; i++)
            {
                nodes[i] = new Vector.<Node>();
                for(var j:int = 0; j<20; j++)
                {
                    nodes[i].push(new Node(i,j));
                    nodes[i][j].addEventListener(EVENT_NODE_DATA_CHANGED, debugLayer.on_node_cost_changed);
                }
            }



            var impediments:Vector.<Impediment> = room.get_impediments();

            for each(var impediment:Impediment in impediments)
            {
                for(i = impediment.positionX; i< impediment.positionX + impediment.widthInNodes; i++)
                {
                    for(j = impediment.positionY; j< impediment.positionY + impediment.heightInNodes; j++)
                    {
                        if(impediment.penalty > nodes[i][j].penalty)
                        {
                            nodes[i][j].penalty = impediment.penalty;
                        }
                    }
                }
            }

            openList.clear(true);
            closedList.splice(0, closedList.length);
            openList.add(nodes[startX][startY]);

            do
            {
                var currentNode:Node = openList.pop() as Node;
                closedList.push(currentNode);
                currentNode.closed = true;
                if(currentNode.x == endX && currentNode.y == endY)
                {
                    break;
                }
                for(i = -1; i <= 1; i++)
                {
                    for(j = -1; j <= 1; j++)
                    {
                        if(!checkNeighbor(currentNode, i, j, endX, endY))
                        {
                            continue;
                        }
                    }
                }
            } while(!openList.isEmpty())

            var path:Vector.<Node> = new Vector.<Node>();

            path.push(nodes[endX][endY]);
            if(path[path.length -1].parent == null)
            {
                return new Vector.<Node>();
            }
            do
            {
                path.push(path[path.length -1].parent);
            }
            while(path[path.length -1].parent != null);

            return path.reverse();
        }

        private function checkNeighbor(currentNode:Node, i:int, j:int, endX:int, endY:int):Boolean
        {
            if((i != 0 || j != 0) && currentNode.x + i >= 0 && currentNode.y + j >= 0 && currentNode.x + i < 20 && currentNode.y + j < 20)
            {
                var neighborNode:Node = nodes[currentNode.x + i][currentNode.y + j];
                if (closedList.indexOf(neighborNode) >= 0 || neighborNode.penalty >= 1000)
                {
                    return false;
                }
                if(!openList.contains(neighborNode))
                {
                    neighborNode.parent = currentNode;
                    neighborNode.heuristic = calculateHeuristic(neighborNode.x, neighborNode.y, endX, endY);
                    neighborNode.cost = currentNode.cost + ((i == 0 || j == 0)?10:14) + neighborNode.penalty;
                    openList.add(neighborNode);
                }
                else
                {
                    var new_cost:uint = currentNode.cost + ((i == 0 || j == 0)?10:14) + neighborNode.penalty;
                    if(neighborNode.cost > new_cost)
                    {
                        neighborNode.parent = currentNode;
                        neighborNode.cost = new_cost;
                        openList.change(neighborNode, 1);
                    }
                }
            }
            return true;
        }

        public function calculateHeuristic(startX:int, startY:int, endX:int, endY:int):int
        {
            return (Math.abs(startX - endX) + Math.abs(startY - endY)) * 10;
        }
    }
}
