package jetandgiant.object.bullet
{
import flash.display.Sprite;
import flash.events.Event;

import jetandgiant.object.Boom;
import jetandgiant.object.enemy.Enemy;

public class GiantBullet extends Bullet
{
	[Embed(source="/assets.swf", symbol="bullet")]
	private const BULLET:Class;

	public function GiantBullet()
	{
		var asset:Sprite = new BULLET();
		super(asset);
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

	override protected function onRemovedFromStage(event:Event):void
	{
		gameModel.giantBulletsPool.returnObject(this);
		super.onRemovedFromStage(event);
	}
}
}
