package jetandgiant.object
{
import com.as3nui.nativeExtensions.air.kinect.data.SkeletonJoint;
import com.as3nui.nativeExtensions.air.kinect.data.User;
import com.as3nui.nativeExtensions.air.kinect.events.UserEvent;

import flash.display.Sprite;
import flash.geom.Point;

import flash.events.Event;
import flash.ui.Keyboard;
import flash.utils.getTimer;

import jetandgiant.object.bullet.Bullet;

import jetandgiant.util.KeyboardUtil;
import jetandgiant.util.MathUtil;

public class Giant extends GameObject
{
	public static const GIANT_HIT:String = "GIANT_HIT";

	[Embed(source="/assets.swf", symbol="ship")]
	private const SHIP:Class;

	private const SPEED:Number = 5;
	private const MAX_SPEED:Number = 17;

	private var lastBulletTime:Number = 0;
	private const BULLET_INTERVAL:Number = 400;
	private var speed:Point = new Point();

	public var collisionArea:Sprite;
	private var user:User;

	public function Giant()
	{
		super();
		addChild(new SHIP());
		collisionArea = new Sprite();
		collisionArea.graphics.beginFill(0, 0);
		collisionArea.graphics.drawRect(-width * 1/3, -height * 1/3, width * 2/3, height * 4/7);
		collisionArea.graphics.endFill();
		addChild(collisionArea);
	}

	override protected function onAddedToStage(event:Event):void
	{
		super.onAddedToStage(event);

		x = 20 + width / 2;
		y = stage.stageHeight / 2;

		KeyboardUtil.init(stage);
		gameModel.kinect.addEventListener(UserEvent.USERS_ADDED, onUserAdded);
	}

	private function onUserAdded(event:UserEvent):void
	{
		user = event.users[0];
	}

	override public function update():void
	{
		if(!user) return;

		var leftHandPosition:Point = user.getJointByName(SkeletonJoint.LEFT_HAND).position.depthRelative;

		x = MathUtil.clamp(leftHandPosition.x * stage.stageWidth, 0, stage.stageWidth);
		y = MathUtil.clamp(leftHandPosition.y * stage.stageHeight, 0, stage.stageHeight);


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

		var bullet:Bullet = gameModel.giantBulletsPool.getObject();
		bullet.x = x + width / 2;
		bullet.y = y;
		gameModel.game.addChild(bullet);
	}
}
}
