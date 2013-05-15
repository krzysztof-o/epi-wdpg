package eu.proto.RoomNavigation.gameActors
{
    import com.greensock.TweenLite;
    import com.greensock.easing.Bounce;
    import com.greensock.easing.Elastic;

    import eu.proto.RoomNavigation.Game;
    import eu.proto.RoomNavigation.logic.PathfindingDebugLayer;
    import eu.proto.RoomNavigation.sceneBase.PathfinderSprite;
    import eu.proto.RoomNavigation.sceneBase.Impediment;
    import eu.proto.RoomNavigation.sceneBase.Scene;

    import feathers.controls.ToggleSwitch;

    import flash.display.Sprite;

    import flash.geom.Point;

    import starling.display.DisplayObject;
    import starling.display.Image;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;

    /**
	 * Class representing the game board, managing its display, physics, logic and touch interface
	 */
	
	public class Room extends Scene
	{
		private var floor:Image;

        public static const TILE_WIDTH:uint = 110;
        public static const TILE_HEIGHT:uint = 100;

        private var toy:Toy;
		
		public function Room()
		{
			super();
		}
		
		override protected function onAdded(e:Event):void
		{
			super.onAdded(e);
			//center();

            Game.tileTexture.repeat = true;
            floor = new Image(Game.tileTexture);
            floor.setTexCoords(0, new Point(0,0));
            floor.setTexCoords(1, new Point(10,0));
            floor.setTexCoords(2, new Point(0,10));
            floor.setTexCoords(3, new Point(10,10));
            floor.width = TILE_WIDTH * 20;
            floor.height = TILE_HEIGHT * 20;
            floor.addEventListener(TouchEvent.TOUCH, onTouch);
			addChild(floor);

            toy = new Toy();
            toy.addEventListener(PathfinderSprite.INVALIDATE_OFFSET, on_sort_toy_offset);
            addChild(toy);
            toy.positionX = 5;
            toy.positionY = 5;
        }

        private function on_sort_toy_offset(event:Event):void
        {
            setChildIndex(toy, 1);
            for(var i:int = 0; i < numChildren; i++)
            {
                if(getChildAt(i) is Impediment && (getChildAt(i) as Impediment).positionY <= toy.positionY)
                {
                    setChildIndex(toy, i+1);
                }
            }
        }

        private function createImpediment(type:Class, touch:Touch):void
        {
            var x:int = Math.floor(touch.getLocation(this).x/TILE_WIDTH);
            var y:int = Math.floor(touch.getLocation(this).y/TILE_HEIGHT);
            removeImpedimentAt(x, y);
            var impediment:Impediment = new type();
            impediment.positionX = x;
            impediment.positionY = y;
            addChild(impediment);
            TweenLite.from(impediment.image, 0.5, {alpha:0, y:impediment.image.y - 100, ease: Bounce.easeOut});
        }

        public function removeImpedimentAt(x:int, y:int):void
        {
            for(var i:int = 0; i<numChildren; i++)
            {
                var child:DisplayObject = getChildAt(i);
                if(child is Impediment && (child as Impediment).positionX == x && (child as Impediment).positionY == y)
                {
                    removeChildAt(i, true);
                }
            }
        }

        public function hasImpedimentAt(x:int, y:int):Boolean
        {
            if(x < 0)
            {
                x = 0;
            }
            if(x > 19)
            {
                x = 19;
            }
            if(y < 0)
            {
                y = 0;
            }
            if(y > 19)
            {
                y = 19;
            }
            for(var i:int = 0; i<numChildren; i++)
            {
                var child:DisplayObject = getChildAt(i);
                if(child is Impediment && (child as Impediment).positionX == x && (child as Impediment).positionY == y)
                {
                   return true;
                }
            }
            return false;
        }

        private function onTouch(e:TouchEvent):void
        {
            if (e.touches.length == 1)
            {
                var touch:Touch = e.getTouch(stage, TouchPhase.MOVED);
                if (touch)
                {
                    switch(Game.picker.selectedIndex)
                    {

                        case 2:
                            if(!hasImpedimentAt(Math.floor(touch.getLocation(this).x/TILE_WIDTH), Math.floor(touch.getLocation(this).y/TILE_HEIGHT)))
                                createImpediment(Carpet, touch);
                            break;
                        case 3:
                            if(!hasImpedimentAt(Math.floor(touch.getLocation(this).x/TILE_WIDTH), Math.floor(touch.getLocation(this).y/TILE_HEIGHT)))
                                createImpediment(Dresser, touch);
                            break;
                        case 4:
                            removeImpedimentAt(Math.floor(touch.getLocation(this).x/TILE_WIDTH), Math.floor(touch.getLocation(this).y/TILE_HEIGHT));
                            break;
                        default:
                            var offset:Point = touch.getMovement(stage);
                            Scene.displayOffset = Scene.displayOffset.add(offset);

                    }
                }
                touch = e.getTouch(stage, TouchPhase.ENDED);
                if(touch)
                {
                    switch(Game.picker.selectedIndex)
                    {
                        case 1:
                            toy.navigateTo(Math.floor(touch.getLocation(this).x/TILE_WIDTH), Math.floor(touch.getLocation(this).y/TILE_HEIGHT));
                            break;
                        case 2:
                            createImpediment(Carpet, touch);
                            break;
                        case 3:
                            createImpediment(Dresser, touch);
                            break;
                        case 4:
                            removeImpedimentAt(Math.floor(touch.getLocation(this).x/TILE_WIDTH), Math.floor(touch.getLocation(this).y/TILE_HEIGHT));
                    }

                }
            }
            else
            {
                var touches:Vector.<Touch> = e.getTouches(stage);
                if(touches.length > 1)
                {
                    switch(Game.picker.selectedIndex)
                    {

                        case 2:
                            for each(touch in touches)
                                if(!hasImpedimentAt(Math.floor(touch.getLocation(this).x/TILE_WIDTH), Math.floor(touch.getLocation(this).y/TILE_HEIGHT)))
                                    createImpediment(Carpet, touch);
                            break;
                        case 3:
                            for each(touch in touches)
                                if(!hasImpedimentAt(Math.floor(touch.getLocation(this).x/TILE_WIDTH), Math.floor(touch.getLocation(this).y/TILE_HEIGHT)))
                                    createImpediment(Dresser, touch);
                            break;
                        case 4:
                            for each(touch in touches)
                                removeImpedimentAt(Math.floor(touch.getLocation(this).x/TILE_WIDTH), Math.floor(touch.getLocation(this).y/TILE_HEIGHT));
                                break;
                        default:
                            var touchA:Touch = touches[0];
                            var touchB:Touch = touches[1];

                            var currentPosA:Point  = touchA.getLocation(parent);
                            var previousPosA:Point = touchA.getPreviousLocation(parent);
                            var currentPosB:Point  = touchB.getLocation(parent);
                            var previousPosB:Point = touchB.getPreviousLocation(parent);

                            var currentVector:Point  = currentPosA.subtract(currentPosB);
                            var previousVector:Point = previousPosA.subtract(previousPosB);

                            // update pivot point based on previous center
                            var previousLocalA:Point  = touchA.getPreviousLocation(this);
                            var previousLocalB:Point  = touchB.getPreviousLocation(this);
                            pivotX = (previousLocalA.x + previousLocalB.x) * 0.5;
                            pivotY = (previousLocalA.y + previousLocalB.y) * 0.5;

                            // update location based on the current center
                            x = (currentPosA.x + currentPosB.x) * 0.5;
                            y = (currentPosA.y + currentPosB.y) * 0.5;

                            // scale
                            var sizeDiff:Number = currentVector.length / previousVector.length;
                            scaleX *= sizeDiff;
                            scaleY *= sizeDiff;

                            Scene.displayOffset = new Point(x,y);
                            Scene.displayScale *= sizeDiff;

                    }
                }
            }
        }

        public override function addChild(child:DisplayObject):DisplayObject
        {
            if(child is PathfindingDebugLayer || child is Toy)
            {
                addChildAt(child, numChildren);
            }
            else if(child is Impediment)
            {
                for(var i:int = 0; i < numChildren; i++)
                {
                    if(getChildAt(i) is Impediment && (getChildAt(i) as Impediment).positionY < (child as Impediment).positionY)
                    {
                        addChildAt(child, i);
                    }
                    if(getChildAt(i) is PathfinderSprite && (getChildAt(i) as PathfinderSprite).positionY < (child as Impediment).positionY)
                    {
                        addChildAt(child, i);
                    }
                }
                if(!child.parent)
                {
                    addChildAt(child, 1);
                }
            }
            else
            {
                super.addChild(child);
            }

            return child;
        }
		
		public function center():void
		{ 
			Scene.displayOffset.x = - 1024 * displayScale + stage.stageWidth / 2 + pivotX * displayScale;
			Scene.displayOffset.y = - 1024 * displayScale + stage.stageHeight / 2 + pivotY * displayScale;
		}

        public function on_toggle_debug(event:Event):void
        {
            toy.debug = (event.currentTarget as ToggleSwitch).isSelected;
        }
    }

}