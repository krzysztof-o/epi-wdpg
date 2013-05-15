package eu.proto.RoomNavigation {

    import eu.proto.RoomNavigation.gameActors.Room;

    import feathers.controls.Button;
    import feathers.controls.Header;
    import feathers.controls.Label;
    import feathers.controls.PickerList;
    import feathers.controls.Slider;

    import feathers.controls.ToggleSwitch;
    import feathers.data.ListCollection;
    import feathers.themes.MetalWorksMobileTheme;

    import starling.display.DisplayObject;

    import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
    import starling.textures.TextureAtlas;

    /**
	 * Starling display root class
	 */

	public final class Game extends Sprite 
	{		
		public static var scene:Room;
		
		[Embed(source = "/assets/elements.xml", mimeType="application/octet-stream")]
		private static var elementsDescriptor:Class;

        [Embed(source = "/assets/elements.png")]
        private static var elementsBitmap:Class;

        [Embed(source = "/assets/fourTiles.png")]
        private static var tileBitmap:Class;

        public static var tileTexture:Texture;

        public static var gameAtlas:TextureAtlas;

        public static var toggle:ToggleSwitch = new ToggleSwitch();
        public static var picker:PickerList = new PickerList();
        public static var slider:Slider = new Slider();

		public function Game() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void 
		{
            tileTexture = Texture.fromBitmap(new tileBitmap());
            gameAtlas = new TextureAtlas(Texture.fromBitmap(new elementsBitmap()), XML(new elementsDescriptor()));
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			//Room extends Scene
			scene = new Room();
			addChild(scene);

            var theme:MetalWorksMobileTheme = new MetalWorksMobileTheme(stage);

            var header:Header = new Header();
            header.title = "Room Navigation";
            addChild(header);
            header.width = stage.stageWidth;
            header.titleAlign = Header.TITLE_ALIGN_PREFER_LEFT;

            var label:Label = new Label();
            label.text = "DEBUG";

            label.x = 5;
            label.y = 8;

            addChild(label);

            toggle = new ToggleSwitch();
            toggle.isSelected = true;
            addChild(toggle);
            toggle.x = 100;
            toggle.y = 5;

            toggle.addEventListener(Event.CHANGE, (scene as Room).on_toggle_debug);

            var sliderLabel:Label = new Label();
            sliderLabel.text = "DELAY";

            slider.minimum = 0;
            slider.maximum = 1000;

            header.leftItems = new<DisplayObject>[label, toggle, sliderLabel, slider];


            var pickerLabel:Label = new Label();
            pickerLabel.text = "ACTION";

            picker = new PickerList();

            var tools:ListCollection = new ListCollection(
                    [
                        {text: "Pan and scale"},
                        {text: "Move piece", thumbnail: gameAtlas.getTexture("piece")},
                        {text: "Add carpet", thumbnail: gameAtlas.getTexture("carpet")},
                        {text: "Add dresser", thumbnail: gameAtlas.getTexture("dresser")},
                        {text: "Remove impediment"}
                    ]
            )

            picker.dataProvider = tools;

            picker.listProperties.@itemRendererProperties.labelField = "text";
            picker.listProperties.@itemRendererProperties.iconSourceField = "thumbnail";

            picker.labelField = "text";
            picker.selectedIndex = 1;

            header.rightItems = new<DisplayObject>[pickerLabel, picker];
		}
	}
}