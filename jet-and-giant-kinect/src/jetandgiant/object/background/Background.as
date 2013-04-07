package jetandgiant.object.background
{
import flash.display.Sprite;

public class Background extends Sprite
{

	[Embed(source="/assets.swf", symbol="background_clouds")]
	private const BACKGROUND_CLOUDS:Class;

	[Embed(source="/assets.swf", symbol="background_fog")]
	private const BACKGROUND_FOG:Class;

	[Embed(source="/assets.swf", symbol="background_stars")]
	private const BACKGROUND_STARS:Class;

	[Embed(source="/assets.swf", symbol="background_planets")]
	private const BACKGROUND_PLANETS:Class;

	[Embed(source="/assets.swf", symbol="background_ground")]
	private const BACKGROUND_GROUND:Class;

	public function Background()
	{
		super();

		addLayer(BACKGROUND_CLOUDS, 5);
		addLayer(BACKGROUND_FOG, 10);
		addLayer(BACKGROUND_STARS, 15);
		addLayer(BACKGROUND_PLANETS, 20);
		addLayer(BACKGROUND_GROUND, 25);
	}

	public function addLayer(layerClass:Class, speed:Number):void
	{
		var layer:Layer = new Layer(layerClass, speed);
		addChild(layer);
	}

	public function update():void
	{
		for(var i:uint = 0; i < numChildren; i++)
		{
			var layer:Layer = getChildAt(i) as Layer;
			layer.update();
		}
	}
}
}
