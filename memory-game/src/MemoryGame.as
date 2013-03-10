package
{
import flash.display.Sprite;

public class MemoryGame extends Sprite
{
    [Embed(source="assets.swf", symbol="background")]
    private const BACKGROUND:Class;

    [Embed(source="assets.swf", symbol="card")]
    private const ASSETS_CLASS:Class;

    public function MemoryGame()
    {
        const COLS:int = 4;
        const ROWS:int = 2;

        var background:Sprite = new BACKGROUND();
    }
}
}
