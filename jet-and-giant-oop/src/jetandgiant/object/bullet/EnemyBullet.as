package jetandgiant.object.bullet
{
import flash.display.Sprite;

import jetandgiant.Game;
import jetandgiant.object.Boom;

public class EnemyBullet extends Bullet
{
	[Embed(source="/assets.swf", symbol="bullet")]
	private const BULLET:Class;

	public function EnemyBullet(game:Game, x:Number, y:Number)
	{
		var asset:Sprite = new BULLET();
		asset.scaleX = -.5;
		asset.scaleY = .5;
		super(game, x, y, asset);
	}

	override protected function move():void
	{
		x -= SPEED;
	}

	override protected function checkCollisions():void
	{
		if(game.giant.collisionArea.hitTestObject(this))
		{
			remove();
			game.lives.minusLive();
			var boom:Boom = new Boom(game, game.giant.x, game.giant.y);
			game.addChild(boom);
		}
	}
}
}
