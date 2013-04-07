package jetandgiant.util
{
import flash.display.DisplayObject;
import flash.display.Stage;

public class DisplayObjectUtil
{

	public static function isOffTheStage(stage:Stage, displayObject:DisplayObject):Boolean
	{
		if(!stage) return false;
		if(displayObject.x + displayObject.width < 0) return true;
		if(displayObject.x - displayObject.width > stage.stageWidth) return true;
		if(displayObject.y + displayObject.height < 0) return true;
		if(displayObject.y - displayObject.height > stage.stageHeight) return true;

		return false;
	}
}
}
