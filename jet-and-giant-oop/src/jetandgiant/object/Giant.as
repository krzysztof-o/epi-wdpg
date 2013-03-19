package jetandgiant.object
{
import jetandgiant.*;

import flash.events.Event;
import flash.ui.Keyboard;
import flash.utils.getTimer;

import jetandgiant.object.Bullet;
import jetandgiant.object.GameObject;
import jetandgiant.util.KeyboardUtil;
import jetandgiant.util.MathUtil;

public class Giant extends GameObject
{
	[Embed(source="/assets.swf", symbol="ship")]
	private const SHIP:Class;

	private const SPEED:Number = 20;

	private var lastBulletTime:Number = 0;
	private const BULLET_INTERVAL:Number = 400;

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
		var dy:Number = y;
		if(KeyboardUtil.isPressed(Keyboard.UP))
		{
			dy -= SPEED;
		}
		else if(KeyboardUtil.isPressed(Keyboard.DOWN))
		{
			dy += SPEED;
		}
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
