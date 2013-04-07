package jetandgiant.object.enemy.strategy
{
import flash.display.DisplayObject;

public class FastMoveStrategy implements IMoveStrategy
{
	private const SPEED:Number = 20;

	public function FastMoveStrategy()
	{
	}

	public function move(object:DisplayObject):void
	{
		object.x -= SPEED;
	}
}
}
