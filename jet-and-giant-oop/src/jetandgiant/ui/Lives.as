package jetandgiant.ui
{
import flash.display.Sprite;

public class Lives extends Sprite
{
	[Embed(source="/assets.swf", symbol="heart")]
	private const HEART:Class;

	private var lives:uint = 5;

	public function Lives()
	{
		for(var i:uint = 0; i < lives; i++)
		{
			var heart:Sprite = new HEART();
			heart.x = i * heart.width;
			addChild(heart);
		}
	}

	public function minusLive():void
	{
		if(lives > 0)
		{
			lives--;
		}

		for(var i:uint = 0; i < numChildren; i++)
		{
			getChildAt(i).alpha = (lives >= i + 1) ? 1 : .1;
		}
	}
}
}
