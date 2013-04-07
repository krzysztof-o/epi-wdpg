package jetandgiant.object.enemy.strategy
{
import flash.display.DisplayObject;

public class SlowMoveStrategy implements IMoveStrategy
{
	private const SPEED:Number = 5;

	public function SlowMoveStrategy()
	{
	}

	public function move(object:DisplayObject):void
	{
		object.x -= SPEED;
		object.y += Math.sin(object.x / 50) * 5;
	}
}
}
