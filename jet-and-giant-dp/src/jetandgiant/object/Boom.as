package jetandgiant.object
{
import flash.events.Event;
import flash.utils.setTimeout;

import jetandgiant.*;

public class Boom extends GameObject
{

	[Embed(source="/assets.swf", symbol="boom")]
	private const BOOM:Class;

	public function Boom(game:Game, x:Number, y:Number)
	{
		super(game);

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
