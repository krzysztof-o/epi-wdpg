package
{
import flash.display.MovieClip;
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
        const PADDING:int = 5;

        //add background
        var background:Sprite = new BACKGROUND();
        addChild(background);

        //add cards
        for (var i:uint = 0; i < COLS; i++)
        {
            for (var j:uint = 0; j < ROWS; j++)
            {
                var card:MovieClip = new ASSETS_CLASS();
                card.x = PADDING + i * (card.width + PADDING) + card.width / 2;
                card.y = PADDING + j * (card.height + PADDING) + card.height / 2;

                addChild(card);

                //stop on random frame
                var randomFrame:int = 1 + Math.round(Math.random() * card.totalFrames);
                card.gotoAndStop(randomFrame);
            }
        }
    }
}
}
