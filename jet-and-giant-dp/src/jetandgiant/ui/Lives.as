package jetandgiant.ui
{
import com.greensock.TweenMax;

import flash.display.Sprite;

import jetandgiant.Game;

public class Lives extends Sprite
{

	[Embed(source="/assets.swf", symbol="heart")]
	private const HEART:Class;

	private var lives:int = 5;
	private var game:Game;

	public function Lives(game:Game)
	{
		this.game = game;
		for(var i:uint = 0; i < lives; i++)
		{
			var heart:Sprite = new HEART();
			heart.x = i * heart.width;
			addChild(heart);
		}
	}

	public function minusLive():void
	{
		lives--;

		if(lives > 0)
		{
			TweenMax.to(game, 0, {colorTransform:{tint:0xFF0000, tintAmount:0.2}});
			TweenMax.to(game, .25, {colorTransform: {tint: 0xFF0000, tintAmount: 0}});
		}
		else
		{
			TweenMax.to(game, .2, {colorTransform:{tint:0xFF0000, tintAmount:0.5}});
		}

		for(var i:uint = 0; i < numChildren; i++)
		{
			getChildAt(i).alpha = (lives >= i + 1) ? 1 : .1;
		}
	}
}
}
