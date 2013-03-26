package jetandgiant.object
{
import flash.display.Sprite;
import flash.events.Event;

import jetandgiant.Game;

public class GameObject extends Sprite
{
	protected var game:Game;

	public function GameObject(game:Game)
	{
		this.game = game;
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
		game.removeChild(this);
	}
}
}
