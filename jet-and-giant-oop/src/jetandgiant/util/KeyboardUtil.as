package jetandgiant.util
{
import flash.display.Stage;
import flash.events.KeyboardEvent;
import flash.utils.Dictionary;

public class KeyboardUtil
{
	private static var keyPressed:Dictionary = new Dictionary();

	public static function init(stage:Stage):void
	{
		stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
	}

	private static function onKeyDown(event:KeyboardEvent):void
	{
		keyPressed[event.keyCode] = true;
	}

	private static function onKeyUp(event:KeyboardEvent):void
	{
		delete keyPressed[event.keyCode];
	}

	public static function isPressed(keyCode:uint):Boolean
	{
		return keyPressed[keyCode];
	}
}
}
