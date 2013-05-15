package feathers.examples.trainTimes.screens
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.data.ListCollection;
	import feathers.examples.trainTimes.model.StationData;

	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	import starling.animation.Transitions;

	import starling.animation.Tween;

	import starling.core.Starling;

	import starling.display.DisplayObject;
	import starling.events.Event;

	[Event(name="complete",type="starling.events.Event")]

	public class StationScreen extends Screen
	{
		public static const CHILD_NAME_STATION_LIST:String = "stationList";

		public function StationScreen()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}

		public var selectedDepartureStation:StationData;
		public var selectedDestinationStation:StationData;

		private var _departureHeader:Header;
		private var _destinationHeader:Header;
		private var _backButton:Button;
		private var _stationList:List;

		private var _headerTween:Tween;

		override protected function initialize():void
		{
			this._stationList = new List();
			this._stationList.nameList.add(CHILD_NAME_STATION_LIST);
			this._stationList.dataProvider = new ListCollection(
			[
				new StationData("Ten Stone Road"),
				new StationData("Birch Grove"),
				new StationData("East Elm Court"),
				new StationData("Oakheart Hills"),
				new StationData("Timber Ridge"),
				new StationData("Old Mine Heights"),
				new StationData("Granite Estates"),
			])
			this._stationList.itemRendererProperties.confirmCallback = stationList_onConfirm;
			this._stationList.itemRendererProperties.isInDestinationPhase = false;
			this.addChild(this._stationList);

			this._backButton = new Button();
			this._backButton.visible = false;
			this._backButton.addEventListener(Event.TRIGGERED, backButton_triggeredHandler);

			this._departureHeader = new Header();
			this._departureHeader.title = "Choose Departure Station";
			this.addChild(this._departureHeader);

			this._destinationHeader = new Header();
			this._destinationHeader.title = "Choose Destination Station";
			this._destinationHeader.leftItems = new <DisplayObject>
			[
				this._backButton
			];
			this.addChild(this._destinationHeader);
		}

		override protected function draw():void
		{
			this._departureHeader.width = this.actualWidth;
			this._destinationHeader.width = this.actualWidth;

			var currentHeader:Header;
			if(this.selectedDepartureStation)
			{
				currentHeader = this._destinationHeader;
				this._destinationHeader.x = 0;
				this._destinationHeader.visible = true;
				this._departureHeader.x = this.actualWidth;
				this._departureHeader.visible = false;
			}
			else
			{
				currentHeader = this._departureHeader;
				this._destinationHeader.x = -this.actualWidth;
				this._destinationHeader.visible = false;
				this._departureHeader.x = 0;
				this._departureHeader.visible = true;
			}

			currentHeader.validate();
			this._stationList.y = currentHeader.height;
			this._stationList.width = this.actualWidth;
			this._stationList.height = this.actualHeight - this._stationList.y;
		}

		private function onBackButton():void
		{
			this.selectedDepartureStation.isDepartingFromHere = false;
			const index:int = this._stationList.dataProvider.getItemIndex(this.selectedDepartureStation);
			this._stationList.dataProvider.updateItemAt(index);
			this._stationList.selectedItem = this.selectedDepartureStation;
			this.selectedDepartureStation = null;
			this._backButton.visible = false;
			this._departureHeader.title = "Choose Departure Station";
			this._stationList.itemRendererProperties.isInDestinationPhase = false;

			this._departureHeader.visible = true;
			if(this._headerTween)
			{
				Starling.juggler.remove(this._headerTween);
				this._headerTween = null;
			}
			this._headerTween = new Tween(this._departureHeader, 0.4, Transitions.EASE_OUT);
			this._headerTween.animate("x", 0);
			this._headerTween.onUpdate = headerTween_onUpdate;
			this._headerTween.onComplete = headerTween_onDestinationHideComplete;
			Starling.juggler.add(this._headerTween);
		}

		private function stationList_onConfirm():void
		{
			if(this.selectedDepartureStation)
			{
				this.selectedDestinationStation = StationData(this._stationList.selectedItem);
				this.dispatchEventWith(Event.COMPLETE);
				return;
			}
			this.selectedDepartureStation = StationData(this._stationList.selectedItem);
			this.selectedDepartureStation.isDepartingFromHere = true;

			this._departureHeader.title = "Choose Destination Station";
			this._backButton.visible = true;

			this._stationList.selectedIndex = -1;
			this._stationList.itemRendererProperties.isInDestinationPhase = true;

			this._destinationHeader.visible = true;
			if(this._headerTween)
			{
				Starling.juggler.remove(this._headerTween);
				this._headerTween = null;
			}
			this._headerTween = new Tween(this._departureHeader, 0.4, Transitions.EASE_OUT);
			this._headerTween.animate("x", this.actualWidth);
			this._headerTween.onUpdate = headerTween_onUpdate;
			this._headerTween.onComplete = headerTween_onDestinationShowComplete;
			Starling.juggler.add(this._headerTween);
		}

		private function headerTween_onUpdate():void
		{
			this._destinationHeader.x = this._departureHeader.x - this.actualWidth;
		}

		private function headerTween_onDestinationShowComplete():void
		{
			this._departureHeader.visible = false;
			this._headerTween = null;
		}

		private function headerTween_onDestinationHideComplete():void
		{
			this._destinationHeader.visible = false;
			this._headerTween = null;
		}

		private function addedToStageHandler(event:Event):void
		{
			Starling.current.nativeStage.addEventListener(KeyboardEvent.KEY_DOWN, nativeStage_keyDownHandler, false, 0, true);
		}

		private function removedFromStageHandler(event:Event):void
		{
			Starling.current.nativeStage.removeEventListener(KeyboardEvent.KEY_DOWN, nativeStage_keyDownHandler);
		}

		private function backButton_triggeredHandler(event:Event):void
		{
			this.onBackButton();
		}

		private function nativeStage_keyDownHandler(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.BACK && this.selectedDepartureStation)
			{
				event.preventDefault();
				this.onBackButton();
			}
		}
	}
}
