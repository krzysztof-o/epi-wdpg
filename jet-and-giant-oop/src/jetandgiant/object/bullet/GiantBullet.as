package jetandgiant.object.bullet
{
import flash.display.Sprite;

import jetandgiant.Game;
import jetandgiant.object.Boom;
import jetandgiant.object.enemy.Enemy;

public class GiantBullet extends Bullet
{
	[Embed(source="/assets.swf", symbol="bullet")]
	private const BULLET:Class;

	public function GiantBullet(game:Game, x:Number, y:Number)
	{
		var asset:Sprite = new BULLET();
		super(game, x, y, asset);
	}

	override protected function move():void
	{
		x += SPEED;
	}

	override protected function checkCollisions():void
	{
		for(var i:uint = 0; i < game.enemies.length; i++)
		{
			var enemy:Enemy = game.enemies[i];
			if(hitTestObject(enemy))
			{
				remove();
				enemy.hit();
				var boom:Boom = new Boom(game, enemy.x, enemy.y);
				game.addChild(boom);

				return;
			}
		}
	}
}
}
