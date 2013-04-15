package eu.proto.CapsSoccerMobile
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import starling.core.Starling;
	
	/**
	 * Application entry point
	 */
	
	public class CapsSoccerMobile extends Sprite
	{
		private var starling:Starling;
		public function CapsSoccerMobile():void
		{
            //uncomment following line before building for mobile
            //Starling.multitouchEnabled = true;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
            stage.frameRate = 60;
			
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