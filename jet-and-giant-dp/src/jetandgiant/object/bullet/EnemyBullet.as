package jetandgiant.object.bullet
{
import flash.display.Sprite;
import flash.events.Event;

import jetandgiant.object.Boom;
import jetandgiant.object.Giant;

public class EnemyBullet extends Bullet
{
	[Embed(source="/assets.swf", symbol="bullet")]
	private const BULLET:Class;

	public function EnemyBullet()
	{
		var asset:Sprite = new BULLET();
		asset.scaleX = -.5;
		asset.scaleY = .5;
		super(asset);
	}

	override protected function move():void
	{
		x -= SPEED;
	}

	override protected function checkCollisions():void
	{
		if(gameModel.giant.collisionArea.hitTestObject(this))
		{
			dispatchEvent(new Event(Giant.GIANT_HIT, true));
			var boom:Boom = new Boom(gameModel.giant.x, gameModel.giant.y);
			gameModel.game.addChild(boom);

			remove();
		}
	}

	override protected function onRemovedFromStage(event:Event):void
	{
		gameModel.enemyBulletsPool.returnObject(this);
		super.onRemovedFromStage(event);
	}
}
}
