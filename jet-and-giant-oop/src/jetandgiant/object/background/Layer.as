package jetandgiant.object.background
{
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;

public class Layer extends Sprite
{
	private var layerClass:Class;
	private var speed:Number;

	public function Layer(layerClass:Class, speed:Number)
	{
		this.layerClass = layerClass;
		this.speed = speed;

		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}

	private function onAddedToStage(event:Event):void
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

		do
		{
			var image:DisplayObject = new layerClass();
			image.x = width;
			addChild(image);
		}
		while(image.x <= image.width + stage.stageWidth);

	}

	public function update():void
	{
		for(var i:uint = 0; i < numChildren; i++)
		{
			var image:DisplayObject = getChildAt(i);

			if(image.x + image.width < 0)
			{
				image.x += (numChildren - 1) * image.width;
			}
			image.x -= speed;

		}
	}
}
}
