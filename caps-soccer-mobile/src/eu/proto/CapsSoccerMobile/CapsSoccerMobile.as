package eu.proto.CapsSoccerMobile
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	/**
	 * Application entry point
	 */
	
	public class CapsSoccerMobile extends Sprite
	{
		public function CapsSoccerMobile():void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
            stage.frameRate = 60;
		}
	}	
}