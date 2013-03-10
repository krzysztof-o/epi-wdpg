package
{
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;

public class MemoryGame extends Sprite
{
    [Embed(source="assets.swf", symbol="background")]
    private const BACKGROUND:Class;

    [Embed(source="assets.swf", symbol="card")]
    private const ASSETS_CLASS:Class;


    [SWF(width=980, height=580, frameRate=30)]
    public function MemoryGame()
    {
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;

        const COLS:int = 4;
        const ROWS:int = 2;

        var background:Sprite = new BACKGROUND();
        addChild(background);
    }
}
}
