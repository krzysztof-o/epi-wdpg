package jetandgiant.object
{
import flash.geom.Point;

import jetandgiant.*;

import flash.events.Event;
import flash.ui.Keyboard;
import flash.utils.getTimer;

import jetandgiant.util.KeyboardUtil;
import jetandgiant.util.MathUtil;

public class Giant extends GameObject
{
	[Embed(source="/assets.swf", symbol="ship")]
	private const SHIP:Class;

	private const SPEED:Number = 5;
	private const MAX_SPEED:Number = 17;

	private var lastBulletTime:Number = 0;
	private const BULLET_INTERVAL:Number = 400;
	private var speed:Point = new Point();

	public function Giant(game:Game)
	{
		super(game);
		addChild(new SHIP());
	}

	override protected function onAddedToStage(event:Event):void
	{
		super.onAddedToStage(event);

		x = 20 + width / 2;
		y = stage.stageHeight / 2;

		KeyboardUtil.init(stage);
	}

	override public function update():void
	{
		if(KeyboardUtil.isPressed(Keyboard.LEFT))
		{
			speed.x -= SPEED;
		}
		else if(KeyboardUtil.isPressed(Keyboard.RIGHT))
		{
			speed.x += SPEED;
		}

		if(KeyboardUtil.isPressed(Keyboard.UP))
		{
			speed.y -= SPEED;
		}
		else if(KeyboardUtil.isPressed(Keyboard.DOWN))
		{
			speed.y += SPEED;
		}

		speed.x = MathUtil.clamp(speed.x, -MAX_SPEED, MAX_SPEED);
		speed.y = MathUtil.clamp(speed.y, -MAX_SPEED, MAX_SPEED);

		speed.x *= .9;
		speed.y *= .9;

		var dx:Number = x + speed.x;
		var dy:Number = y + speed.y;

		x = MathUtil.clamp(dx, width / 2, stage.stageWidth - width / 2);
		y = MathUtil.clamp(dy, height / 2, stage.stageHeight - height / 2);


		if(KeyboardUtil.isPressed(Keyboard.SPACE) && isReadyForNextBullet())
		{
			shoot();
		}
	}

	private function isReadyForNextBullet():Boolean
	{
		return getTimer() > lastBulletTime + BULLET_INTERVAL;
	}

	private function shoot():void
	{
		lastBulletTime = getTimer();

		var bullet:Bullet = new Bullet(game, x + width / 2, y);
		game.addChild(bullet);
	}
}
}
