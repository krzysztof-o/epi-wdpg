package jetandgiant
{
import flash.display.Sprite;
import flash.events.Event;

import jetandgiant.model.GameModel;

import jetandgiant.object.*;
import jetandgiant.object.background.Background;
import jetandgiant.object.bullet.Bullet;
import jetandgiant.object.enemy.Enemy;
import jetandgiant.object.enemy.FastEnemy;
import jetandgiant.object.enemy.SlowEnemy;
import jetandgiant.ui.Lives;

public class Game extends Sprite
{
	private var gameModel:GameModel = GameModel.getInstance();

	public function Game()
	{
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}

	private function onAddedToStage(event:Event = null):void
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		gameModel.init();
		gameModel.game = this;

		var background:Background = new Background();
		addChild(background);
		gameModel.background = background;

		var giant:Giant = new Giant();
		addChild(giant);
		gameModel.giant = giant;

		var lives:Lives = new Lives(this);
		lives.x = stage.stageWidth - lives.width;
		lives.y = 0;
		addChild(lives);
		gameModel.lives = lives;

		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}

	private function onEnterFrame(event:Event):void
	{
		gameModel.background.update();
		gameModel.giant.update();
		for each(var bullet:Bullet in gameModel.bullets)
		{
			bullet.update();
		}
		for each(var enemy:Enemy in gameModel.enemies)
		{
			enemy.update();
		}

		if(Math.random() < .018)
		{
			createEnemy();
		}
	}

	private function createEnemy():void
	{
		var newEnemy:Enemy;
		if (Math.random() < .5)
		{
			newEnemy = new FastEnemy();
		}
		else
		{
			newEnemy = new SlowEnemy();
		}
		addChild(newEnemy);
	}
}
}
