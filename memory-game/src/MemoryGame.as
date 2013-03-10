package
{
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.MouseEvent;
import flash.utils.Dictionary;
import flash.utils.setTimeout;

public class MemoryGame extends Sprite
{
    [Embed(source="assets.swf", symbol="background")]
    private const BACKGROUND:Class;

    [Embed(source="assets.swf", symbol="card")]
    private const ASSETS_CLASS:Class;


    private var types:Dictionary = new Dictionary();
    private var lastCard:MovieClip;

    private const FIRST_CARD:int = 1;
    private const SECOND_CARD:int = 2;
    private var phase:int = FIRST_CARD;


    [SWF(width=980, height=580, frameRate=30)]
    public function MemoryGame()
    {
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;

        const COLS:int = 4;
        const ROWS:int = 2;
        const PADDING:int = 5;
        const TOTAL_CARD_TYPES:int = 4;

        //add background
        var background:Sprite = new BACKGROUND();
        addChild(background);

        //rand card types
        var randomTypes:Array = [];
        for (var k:uint = 0; k < TOTAL_CARD_TYPES; k++)
        {
            randomTypes.push(k);
            randomTypes.push(k);
        }
        randomTypes.sort(randomSort);

        //add cards
        for (var i:uint = 0; i < COLS; i++)
        {
            for (var j:uint = 0; j < ROWS; j++)
            {
                var card:MovieClip = new ASSETS_CLASS();
                card.x = PADDING + i * (card.width + PADDING) + card.width / 2;
                card.y = PADDING + j * (card.height + PADDING) + card.height / 2;

                addChild(card);

                card.gotoAndStop(1);
                card.addEventListener(MouseEvent.CLICK, onCardClick);

                types[card] = randomTypes[i + j * COLS];
            }
        }
    }

    private function randomSort(a:*, b:*):Number
    {
        return (Math.random() < 0.5) ? 1 : -1;
    }

    private function onCardClick(event:MouseEvent):void
    {
        var card:MovieClip = event.target as MovieClip;

        card.gotoAndStop(types[card] + 2);

        if(phase == SECOND_CARD)
        {
            setTimeout(flipCard, 1000, card, lastCard);
        }

        lastCard = card;

        if(phase == FIRST_CARD)
        {
            phase = SECOND_CARD;
        }
        else
        {
            phase = FIRST_CARD;
        }
    }

    private function flipCard(cardA:MovieClip, cardB:MovieClip):void
    {
        if(types[cardA] == types[cardB])
        {
            removeChild(cardA);
            removeChild(cardB);
        }
        else
        {
            cardA.gotoAndStop(1);
            cardB.gotoAndStop(1);
        }
    }
}
}
