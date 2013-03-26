package
{

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;

import jetandgiant.Game;

public class JetAndGiantDP extends Sprite
{

	[SWF(width=1050, height=600, frameRate=30)]
	public function JetAndGiantDP()
	{
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;

		var game:Game = new Game();
		addChild(game);
	}
}
}
