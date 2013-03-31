package jetandgiant.object.bullet
{
import flash.display.Sprite;

import jetandgiant.object.*;

import flash.events.Event;

import jetandgiant.util.DisplayObjectUtil;

public class Bullet extends GameObject
{
	protected const SPEED:Number = 30;

	public function Bullet(x:Number, y:Number, asset:Sprite)
	{
		super();

		this.x = x;
		this.y = y;

		addChild(asset);
	}

	override protected function onAddedToStage(event:Event):void
	{
		super.onAddedToStage(event);
		gameModel.bullets.push(this);
	}


	override protected function onRemovedFromStage(event:Event):void
	{
		super.onRemovedFromStage(event);
		for(var i:uint = 0; i < gameModel.bullets.length; i++)
		{
			if(gameModel.bullets[i] == this)
			{
				gameModel.bullets.splice(i, 1);
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

		checkCollisions();

		move();
	}

	protected function checkCollisions():void
	{

	}

	protected function move():void
	{

	}
}
}
