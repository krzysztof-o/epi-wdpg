package eu.proto.CapsSoccerMobile.gameActors 
{
    import Box2D.Common.Math.b2Vec2;
    import eu.proto.CapsSoccerMobile.Game;
	import eu.proto.CapsSoccerMobile.sceneBase.Scene;
    import flash.geom.Point;
    import flash.geom.Rectangle;
	import starling.display.Image;
	import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.textures.Texture;
	
	/**
	 * Class representing the game board, managing its display, physics, logic and touch interface
	 */
	
	public class Stadium extends Scene 
	{
		private var background:Image;

        public var plCaps:Vector.<Cap> = new Vector.<Cap>();
        public var deCaps:Vector.<Cap> = new Vector.<Cap>();
        public var ballCap:Cap;
		
		public function Stadium()
		{
			super();
		}
		
		override protected function onAdded(e:Event):void
		{
			super.onAdded(e);
			center();
			
			var texture:Texture = Texture.fromTexture(Game.gameTexture, new Rectangle(0, 0, 2048, 1407));
			background = new Image(texture);
            background.addEventListener(TouchEvent.TOUCH, onTouch);
			addChild(background);

            addCaps();
		}

        private function addCaps():void {
            addCap(Cap.KIND_BALL);

            addCap(Cap.KIND_PL);
            addCap(Cap.KIND_PL);
            addCap(Cap.KIND_PL);

            addCap(Cap.KIND_DE);
            addCap(Cap.KIND_DE);
            addCap(Cap.KIND_DE);
        }

        public function addCap(kind:int):void
        {
            var position:b2Vec2 = new b2Vec2(1024 / worldScale, 703.5 / worldScale);
            var angle:Number;
            var radius:Number = 260 / worldScale;
            switch(kind)
            {
                case Cap.KIND_PL:
                    angle = 2 * Math.PI / 3 + (Math.PI / 3) * plCaps.length;
                    position.Add(new b2Vec2(radius * Math.cos(angle), radius * Math.sin(angle)));
                    plCaps.push(new Cap(kind));
                    addChild(plCaps[plCaps.length - 1]);
                    plCaps[plCaps.length - 1].body.SetPosition(position);
                    break;
                case Cap.KIND_DE:
                    angle = Math.PI / 3 - (Math.PI / 3) * deCaps.length;
                    position.Add(new b2Vec2(radius * Math.cos(angle), radius * Math.sin(angle)));
                    deCaps.push(new Cap(kind));
                    addChild(deCaps[deCaps.length - 1]);
                    deCaps[deCaps.length - 1].body.SetPosition(position);
                    break;
                default:
                    ballCap = new Cap(kind);
                    addChild(ballCap);
                    ballCap.body.SetPosition(position);
            }
        }

        private function onTouch(e:TouchEvent):void
        {
            if (e.touches.length == 1)
            {
                var touch:Touch = e.getTouch(stage, TouchPhase.MOVED);
                if (touch)
                {
                    var offset:Point = touch.getMovement(stage);
                    Scene.displayOffset = Scene.displayOffset.add(offset);
                }
            }
            else
            {
                var touches:Vector.<Touch> = e.getTouches(stage);
                if(touches.length > 1)
                {
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
		
		public function center():void
		{ 
			Scene.displayOffset.x = - 1024 * displayScale + stage.stageWidth / 2 + pivotX * displayScale;
			Scene.displayOffset.y = - 703 * displayScale + stage.stageHeight / 2 + pivotY * displayScale;
		}
	}

}