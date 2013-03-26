package jetandgiant.object.enemy
{
import flash.utils.getTimer;

import jetandgiant.object.*;

import flash.display.Sprite;
import flash.events.Event;

import jetandgiant.*;
import jetandgiant.object.bullet.Bullet;
import jetandgiant.object.bullet.EnemyBullet;
import jetandgiant.util.DisplayObjectUtil;

public class Enemy extends GameObject
{
	private var lastBulletTime:Number = 0;
	private const BULLET_INTERVAL:Number = 1500;

	public function Enemy(game:Game, asset:Sprite)
	{
		super(game);
		addChild(asset);
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

	public function hit():void
	{
		remove();
	}

	override public function update():void
	{
		if(DisplayObjectUtil.isOffTheStage(stage, this))
		{
			remove();
			return;
		}

		if(game.giant.collisionArea.hitTestObject(this))
		{
			game.lives.minusLive();
			var boom:Boom = new Boom(game, x, y);
			game.addChild(boom);

			remove();
		}
		move();

		if (isReadyForNextBullet())
		{
			lastBulletTime = getTimer();
			var bullet:Bullet = new EnemyBullet(game, x, y);
			game.addChild(bullet);
		}
	}

	protected function move():void
	{
	}

	private function isReadyForNextBullet():Boolean
	{
		return getTimer() > lastBulletTime + BULLET_INTERVAL && Math.random() < .025;
	}
}
}
