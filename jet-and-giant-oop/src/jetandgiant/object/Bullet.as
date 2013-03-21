package jetandgiant.object
{
import flash.events.Event;

import jetandgiant.*;
import jetandgiant.object.enemy.Enemy;
import jetandgiant.util.DisplayObjectUtil;

public class Bullet extends GameObject
{
	[Embed(source="/assets.swf", symbol="bullet")]
	private const BULLET:Class;

	private const SPEED:Number = 30;

	public function Bullet(game:Game, x:Number, y:Number)
	{
		super(game);

		this.x = x;
		this.y = y;

		addChild(new BULLET());
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

		for(var i:uint = 0; i < game.enemies.length; i++)
		{
			var enemy:Enemy = game.enemies[i];
			if(hitTestObject(enemy))
			{
				remove();
				enemy.hit();
				var boom:Boom = new Boom(game, enemy.x, enemy.y);
				game.addChild(boom);

				return;
			}
		}

		x += SPEED;
	}
}
}
