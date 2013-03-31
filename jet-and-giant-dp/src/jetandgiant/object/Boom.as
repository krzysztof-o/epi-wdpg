package jetandgiant.object
{
import flash.events.Event;
import flash.utils.setTimeout;

public class Boom extends GameObject
{

	[Embed(source="/assets.swf", symbol="boom")]
	private const BOOM:Class;

	public function Boom(x:Number, y:Number)
	{
		super();

		addChild(new BOOM());
		this.x = x;
		this.y = y;
	}

	override protected function onAddedToStage(event:Event):void
	{
		super.onAddedToStage(event);

		setTimeout(remove, 200);
	}
}
}
