package eu.proto.CapsSoccerMobile.sceneBase 
{
	import flash.geom.Point;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	
	/**
	 * Base class for the game scene, taking care of physics recalculation
	 */
	
	public class Scene extends Sprite 
	{
		public static var displayScale:Number = 1;
		public static var displayOffset:Point = new Point();
		
		public function Scene():void
		{
			addEventListener(EnterFrameEvent.ENTER_FRAME, onFrame);
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}

		protected function onAdded(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
		}

		protected function onFrame(e:EnterFrameEvent):void
		{
			scaleX = Scene.displayScale;
			scaleY = Scene.displayScale;

			x = displayOffset.x;
			y = displayOffset.y;
		}
	}

}