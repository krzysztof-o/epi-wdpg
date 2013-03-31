package jetandgiant.object.bullet
{
import flash.display.Sprite;

import jetandgiant.object.Boom;
import jetandgiant.object.enemy.Enemy;

public class GiantBullet extends Bullet
{
	[Embed(source="/assets.swf", symbol="bullet")]
	private const BULLET:Class;

	public function GiantBullet(x:Number, y:Number)
	{
		var asset:Sprite = new BULLET();
		super(x, y, asset);
	}

	override protected function move():void
	{
		x += SPEED;
	}

	override protected function checkCollisions():void
	{
		for(var i:uint = 0; i < gameModel.enemies.length; i++)
		{
			var enemy:Enemy = gameModel.enemies[i];
			if(hitTestObject(enemy))
			{
				remove();
				enemy.hit();
				var boom:Boom = new Boom(enemy.x, enemy.y);
				gameModel.game.addChild(boom);

				return;
			}
		}
	}
}
}
