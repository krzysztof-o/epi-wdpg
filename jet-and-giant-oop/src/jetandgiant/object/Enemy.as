package jetandgiant.object
{
import flash.events.Event;

import jetandgiant.*;
import jetandgiant.util.DisplayObjectUtil;

public class Enemy extends GameObject
{
	[Embed(source="/assets.swf", symbol="enemy1")]
	private const ENEMY_1:Class;

	private const SPEED:Number = 5 + Math.random() * 10;

	public function Enemy(game:Game)
	{
		super(game);
		addChild(new ENEMY_1());
	}

	override protected function onAddedToStage(event:Event):void
	{
		super.onAddedToStage(event);

		game.enemies.push(this);

		const MARGIN:Number = 100;
		y = MARGIN + Math.random() * (stage.stageHeight - MARGIN * 2);
		x = stage.stageWidth + width;
	}

	override protected function onRemovedFromStage(event:Event):void
	{
		super.onRemovedFromStage(event);

		for(var i:uint = 0; i < game.enemies.length; i++)
		{
			if(game.enemies[i] == this)
			{
				game.enemies.splice(i, 1);
				break;
			}
		}
	}

	override public function update():void
	{
		if(DisplayObjectUtil.isOffTheStage(stage, this))
		{
			remove();
			return;
		}

		x -= SPEED;
	}

}
}
