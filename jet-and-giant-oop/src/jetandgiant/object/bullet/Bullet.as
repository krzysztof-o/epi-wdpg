package jetandgiant.object.bullet
{
import flash.display.Sprite;

import jetandgiant.object.*;

import flash.events.Event;

import jetandgiant.*;
import jetandgiant.util.DisplayObjectUtil;

public class Bullet extends GameObject
{
	protected const SPEED:Number = 30;

	public function Bullet(game:Game, x:Number, y:Number, asset:Sprite)
	{
		super(game);

		this.x = x;
		this.y = y;

		addChild(asset);
	}

	override protected function onAddedToStage(event:Event):void
	{
		super.onAddedToStage(event);
		game.bullets.push(this);
	}


	override protected function onRemovedFromStage(event:Event):void
	{
		super.onRemovedFromStage(event);
		for(var i:uint = 0; i < game.bullets.length; i++)
		{
			if(game.bullets[i] == this)
			{
				game.bullets.splice(i, 1);
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
