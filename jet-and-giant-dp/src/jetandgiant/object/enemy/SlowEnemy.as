package jetandgiant.object.enemy
{
import com.greensock.TweenMax;

import flash.display.Sprite;

import jetandgiant.Game;

public class SlowEnemy extends Enemy
{
	[Embed(source="/assets.swf", symbol="enemy2")]
	private const ASSET:Class;

	private const SPEED:Number = 5;

	private var hits:uint = 0;

	public function SlowEnemy(game:Game)
	{
		var asset:Sprite = new ASSET();
		super(game, asset);
	}

	override protected function move():void
	{
		x -= SPEED;
		y += Math.sin(x / 50) * 5;
	}

	override public function hit():void
	{
		hits++;
		if(hits == 1)
		{
			TweenMax.to(this, .1, {colorTransform: {color: 0xFF0000, tintAmount: .3}});
		}
		else if(hits == 2)
		{
			remove();
		}
	}
}
}
