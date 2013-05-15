package feathers.examples.trainTimes.screens
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.PanelScreen;
	import feathers.controls.Screen;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	import feathers.examples.trainTimes.model.TimeData;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	import starling.display.DisplayObject;

	import starling.events.Event;

	[Event(name="complete",type="starling.events.Event")]

	public class TimesScreen extends PanelScreen
	{
		public static const CHILD_NAME_TIMES_LIST:String = "timesList";

		private static const NORTH_TIMES:Vector.<TimeData> = new <TimeData>
		[
			new TimeData(281, new Date(2013, 2, 6, 13, 5), new Date(2013, 2, 6, 13, 19)),
			new TimeData(281, new Date(2013, 2, 6, 14, 5), new Date(2013, 2, 6, 14, 19)),
			new TimeData(281, new Date(2013, 2, 6, 15, 5), new Date(2013, 2, 6, 15, 19)),
			new TimeData(281, new Date(2013, 2, 6, 16, 5), new Date(2013, 2, 6, 16, 19)),
			new TimeData(281, new Date(2013, 2, 6, 17, 5), new Date(2013, 2, 6, 17, 21)),
			new TimeData(281, new Date(2013, 2, 6, 17, 35), new Date(2013, 2, 6, 17, 51)),
			new TimeData(281, new Date(2013, 2, 6, 18, 5), new Date(2013, 2, 6, 18, 21)),
			new TimeData(281, new Date(2013, 2, 6, 18, 35), new Date(2013, 2, 6, 18, 51)),
			new TimeData(281, new Date(2013, 2, 6, 19, 5), new Date(2013, 2, 6, 19, 21)),
			new TimeData(281, new Date(2013, 2, 6, 20, 1), new Date(2013, 2, 6, 20, 12)),
			new TimeData(281, new Date(2013, 2, 6, 20, 41), new Date(2013, 2, 6, 20, 52)),
			new TimeData(281, new Date(2013, 2, 6, 21, 41), new Date(2013, 2, 6, 21, 52)),
			new TimeData(281, new Date(2013, 2, 6, 22, 41), new Date(2013, 2, 6, 22, 52)),
			new TimeData(281, new Date(2013, 2, 6, 23, 41), new Date(2013, 2, 6, 23, 52)),
		];

		public function TimesScreen()
		{
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}

		private var _backButton:Button;
		private var _list:List;

		protected function initializeHandler(event:Event):void
		{
			this.layout = new AnchorLayout();

			this._list = new List();
			this._list.nameList.add(CHILD_NAME_TIMES_LIST);
			this._list.dataProvider = new ListCollection(NORTH_TIMES);
			this._list.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			this._list.itemRendererProperties.labelFunction = list_labelFunction;
			this.addChild(this._list);

			this._backButton = new Button();
			this._backButton.addEventListener(Event.TRIGGERED, backButton_triggeredHandler);

			this.headerProperties.title = "Schedule";
			this.headerProperties.leftItems = new <DisplayObject>
			[
				this._backButton
			];

			this.backButtonHandler = this.onBackButton;
		}

		private function list_labelFunction(item:TimeData):String
		{
			const departureTime:Date = item.departureTime;
			const arrivalTime:Date = item.arrivalTime;
			const duration:int = (arrivalTime.getTime() - departureTime.getTime()) / 1000 / 60;
			return this.formatTimeAsString(departureTime) + "\t" + this.formatTimeAsString(arrivalTime) + "\t" +
				item.trainNumber + "\t" + duration + "mins";
		}

		private function formatTimeAsString(time:Date):String
		{
			const hours:Number = time.hours;
			const isAM:Boolean = hours < 12;
			const hoursAsString:String = ((isAM ? hours : (hours - 12)) + 1).toString();
			const minutes:Number = time.minutes;
			const minutesAsString:String = minutes < 10 ? "0" + minutes : minutes.toString();
			return hoursAsString + ":" + minutesAsString + (isAM ? "am" : "pm");
		}

		private function onBackButton():void
		{
			this.dispatchEventWith(Event.COMPLETE);
		}

		private function backButton_triggeredHandler(event:Event):void
		{
			this.onBackButton();
		}
	}
}
