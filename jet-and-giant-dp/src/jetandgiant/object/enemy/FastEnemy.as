package jetandgiant.object.enemy
{

import flash.display.Sprite;

public class FastEnemy extends Enemy
{
	[Embed(source="/assets.swf", symbol="enemy1")]
	private const ASSET:Class;

	private const SPEED:Number = 20;

	public function FastEnemy()
	{
		var asset:Sprite = new ASSET();
		super(asset);
	}

	override protected function move():void
	{
		x -= SPEED;
	}
}
}
