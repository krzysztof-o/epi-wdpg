package eu.proto.CapsSoccerMobile.gameActors 
{
	import eu.proto.CapsSoccerMobile.Game;
	import eu.proto.CapsSoccerMobile.sceneBase.Scene;

import flash.geom.Point;
import flash.geom.Rectangle;
	import starling.display.Image;
	import starling.events.Event;
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
            var position:Point = new Point(1024, 703.5);
            var angle:Number;
            var radius:Number = 260;
            switch(kind)
            {
                case Cap.KIND_PL:
                    angle = 2 * Math.PI / 3 + (Math.PI / 3) * plCaps.length;
                    position = position.add(new Point(radius * Math.cos(angle), radius * Math.sin(angle)));
                    plCaps.push(new Cap(kind));
                    addChild(plCaps[plCaps.length - 1]);
                    plCaps[plCaps.length - 1].x = position.x;
                    plCaps[plCaps.length - 1].y = position.y;
                    break;
                case Cap.KIND_DE:
                    angle = Math.PI / 3 - (Math.PI / 3) * deCaps.length;
                    position = position.add(new Point(radius * Math.cos(angle), radius * Math.sin(angle)));
                    deCaps.push(new Cap(kind));
                    addChild(deCaps[deCaps.length - 1]);
                    deCaps[deCaps.length - 1].x = position.x;
                    deCaps[deCaps.length - 1].y = position.y;
                    break;
                default:
                    ballCap = new Cap(kind);
                    addChild(ballCap);
                    ballCap.x = position.x;
                    ballCap.y = position.y;
            }
        }
		
		public function center():void
		{ 
			Scene.displayOffset.x = - 1024 * displayScale + stage.stageWidth / 2 + pivotX * displayScale;
			Scene.displayOffset.y = - 703 * displayScale + stage.stageHeight / 2 + pivotY * displayScale;
		}
	}

}