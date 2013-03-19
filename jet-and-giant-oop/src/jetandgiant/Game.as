package jetandgiant
{
import flash.display.Sprite;
import flash.events.Event;

import jetandgiant.object.*;
import jetandgiant.object.background.Background;
import jetandgiant.ui.Lives;

public class Game extends Sprite
{
	public var bullets:Vector.<Bullet> = new Vector.<Bullet>();
	public var enemies:Vector.<Enemy> = new Vector.<Enemy>();
	public var lives:Lives;

	private var background:Background;
	private var giant:Giant;

	public function Game()
	{
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}

	private function onAddedToStage(event:Event = null):void
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

		background = new Background();
		addChild(background);

		giant = new Giant(this);
		addChild(giant);

		lives = new Lives();
		lives.x = stage.stageWidth - lives.width;
		lives.y = 0;
		addChild(lives);

		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}

	private function onEnterFrame(event:Event):void
	{
		background.update();
		giant.update();
		for each(var bullet:Bullet in bullets)
		{
			bullet.update();
		}
		for each(var enemy:Enemy in enemies)
		{
			enemy.update();
		}

		if(Math.random() < .025)
		{
			var newEnemy:Enemy = new Enemy(this);
			addChild(newEnemy);
		}
	}
}
}
