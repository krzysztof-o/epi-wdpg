package jetandgiant.object.enemy
{
import com.greensock.TweenMax;

import flash.display.Sprite;

import jetandgiant.object.enemy.strategy.SlowMoveStrategy;

public class SlowEnemy extends Enemy
{
	[Embed(source="/assets.swf", symbol="enemy2")]
	private const ASSET:Class;

	private var hits:uint = 0;

	public function SlowEnemy()
	{
		var asset:Sprite = new ASSET();
		super(asset);
		strategy = new SlowMoveStrategy();
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
