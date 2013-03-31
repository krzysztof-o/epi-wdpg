package jetandgiant.command
{
import jetandgiant.model.GameModel;

public class GiantHitCommand implements ICommand
{
	private var gameModel:GameModel = GameModel.getInstance();

	public function execute():void
	{
		gameModel.lives.minusLive();
	}
}
}
