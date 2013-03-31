package jetandgiant.model
{
import jetandgiant.Game;
import jetandgiant.object.Giant;
import jetandgiant.object.background.Background;
import jetandgiant.object.bullet.Bullet;
import jetandgiant.object.enemy.Enemy;
import jetandgiant.ui.Lives;

public class GameModel
{
	public var bullets:Vector.<Bullet> = new Vector.<Bullet>();
	public var enemies:Vector.<Enemy> = new Vector.<Enemy>();
	public var background:Background;
	public var lives:Lives;
	public var giant:Giant;
	public var game:Game;


	private static var instance:GameModel;

	public function GameModel()
	{
	}

	public static function getInstance():GameModel
	{
		instance ||= new GameModel();
		return instance;
	}
}
}
