package
{
import com.greensock.TweenMax;
import com.greensock.easing.Sine;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.MouseEvent;
import flash.geom.PerspectiveProjection;
import flash.geom.Point;
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

    private var block:Boolean = false;


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
                card.addEventListener(MouseEvent.MOUSE_OVER, onCardOver);
                card.addEventListener(MouseEvent.MOUSE_OUT, onCardOut);

                var nr:int = i + j * COLS;
                types[card] = randomTypes[nr];

                var perspectiveProjection:PerspectiveProjection = new PerspectiveProjection();
                perspectiveProjection.projectionCenter = new Point(card.x, card.y);
                card.transform.perspectiveProjection = perspectiveProjection;
            }
        }
    }

    private function onCardOver(event:MouseEvent):void
    {
        if(block) return;
        if(event.target == lastCard) return;
        TweenMax.to(event.target, .25, {scaleX: 1.1, scaleY: 1.1, ease: Sine.easeOut});
    }

    private function onCardOut(event:MouseEvent):void
    {
        if(block) return;
        if(event.target == lastCard) return;
        TweenMax.to(event.target, .25, {scaleX: 1, scaleY: 1, ease: Sine.easeOut});
    }

    private function randomSort(a:*, b:*):Number
    {
        return (Math.random() < 0.5) ? 1 : -1;
    }

    private function onCardClick(event:MouseEvent):void
    {
        if(block) return;
        if(event.target == lastCard) return;

        var card:MovieClip = event.target as MovieClip;

        TweenMax.to(card, .5, {scaleX: 1, scaleY: 1, rotationY: 180, ease: Sine.easeInOut, onUpdate: checkCardSide, onUpdateParams: [card]});

        if(phase == SECOND_CARD)
        {
            block = true;
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
            TweenMax.to(cardA, .5, {alpha: 0, scaleX: 0, scaleY: 0, onComplete: removeChild, onCompleteParams: [cardA]});
            TweenMax.to(cardB, .5, {alpha: 0, scaleX: 0, scaleY: 0, onComplete: removeChild, onCompleteParams: [cardB]});
        }
        else
        {
            TweenMax.to(cardA, .5, {rotationY: 0, ease: Sine.easeInOut, onUpdate: checkCardSide, onUpdateParams: [cardA]});
            TweenMax.to(cardB, .5, {rotationY: 0, ease: Sine.easeInOut, onUpdate: checkCardSide, onUpdateParams: [cardB]});
        }
        setTimeout(unblock, 500);
    }

    private function unblock():void
    {
        lastCard = null;
        block = false;
    }

    private function checkCardSide(card:MovieClip):void
    {
        if(card.rotationY < 90)
        {
            card.gotoAndStop(1);
            card.scaleX = 1;
        }
        else
        {
            card.gotoAndStop(types[card] + 2);
            card.scaleX = -1;
        }
    }
}
}
