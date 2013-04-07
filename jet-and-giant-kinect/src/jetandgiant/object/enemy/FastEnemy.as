package jetandgiant.object.enemy
{

import flash.display.Sprite;

import jetandgiant.object.enemy.strategy.FastMoveStrategy;

public class FastEnemy extends Enemy
{
	[Embed(source="/assets.swf", symbol="enemy1")]
	private const ASSET:Class;


	public function FastEnemy()
	{
		var asset:Sprite = new ASSET();
		super(asset);

		strategy = new FastMoveStrategy();
	}
}
}
