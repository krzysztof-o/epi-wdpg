package jetandgiant.object
{
import flash.display.Sprite;
import flash.events.Event;

import jetandgiant.model.GameModel;

public class GameObject extends Sprite
{
	protected var gameModel:GameModel = GameModel.getInstance();

	public function GameObject()
	{
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}

	protected function onAddedToStage(event:Event):void
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
	}

	protected function onRemovedFromStage(event:Event):void
	{
		removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
	}

	public function update():void
	{
	}

	public function remove():void
	{
		gameModel.game.removeChild(this);
	}
}
}
