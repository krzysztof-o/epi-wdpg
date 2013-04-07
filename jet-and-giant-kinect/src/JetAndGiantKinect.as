package
{

import com.as3nui.nativeExtensions.air.kinect.Kinect;
import com.as3nui.nativeExtensions.air.kinect.KinectSettings;
import com.as3nui.nativeExtensions.air.kinect.constants.CameraResolution;
import com.as3nui.nativeExtensions.air.kinect.events.CameraImageEvent;
import com.as3nui.nativeExtensions.air.kinect.events.DeviceEvent;

import flash.display.Bitmap;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;

import jetandgiant.Game;
import jetandgiant.model.GameModel;

public class JetAndGiantKinect extends Sprite
{
	private var cameraBitmap:Bitmap;
	private var gameModel:GameModel = GameModel.getInstance();

	[SWF(frameRate=30)]
	public function JetAndGiantKinect()
	{
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;

		stage.stageWidth = 1050;
		stage.stageHeight = 600;

		initKinect();
		initCamera();
	}

	private function initCamera():void
	{
		cameraBitmap = new Bitmap();
		gameModel.kinect.addEventListener(CameraImageEvent.RGB_IMAGE_UPDATE, onCameraUpdate);
		addChild(cameraBitmap);
	}

	private function initKinect():void
	{
		var kinect:Kinect = Kinect.getDevice();
		var settings:KinectSettings = new KinectSettings();
		settings.rgbEnabled = true;
		settings.rgbResolution = CameraResolution.RESOLUTION_160_120;
		kinect.addEventListener(DeviceEvent.STARTED, initGame);
		kinect.start(settings);

		gameModel.kinect = kinect;
	}

	private function onCameraUpdate(event:CameraImageEvent):void
	{
		cameraBitmap.bitmapData = event.imageData;
	}

	private function initGame(event:Event = null):void
	{
		var game:Game = new Game();
		addChildAt(game, 0);
	}
}
}
