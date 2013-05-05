package eu.proto.CapsSoccerMobile.gameActors 
{
    import Box2D.Collision.Shapes.b2CircleShape;
    import Box2D.Common.Math.b2Vec2;
    import eu.proto.CapsSoccerMobile.Game;
	import eu.proto.CapsSoccerMobile.sceneBase.BodySprite;
    import eu.proto.CapsSoccerMobile.sceneBase.Scene;
    import flash.geom.Point;
    import flash.geom.Rectangle;
	import starling.display.Image;
    import starling.display.Quad;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.textures.Texture;
	
	/**
	 * Graphical and physical representation of the a cap, with it's own touch interface
	 */
	
	public class Cap extends BodySprite 
	{
		private var image:Image;
		private var texture:Texture;
        private var gizmo:Quad;
		
		public static const KIND_BALL:int = 0;
		public static const KIND_PL:int = 1;
		public static const KIND_DE:int = 2;
		
		private var _kind:int = 0;

        private var force_vector:Point = new Point();
        private var force_application_point:Point = new Point();

        public function get kind():int {
            return _kind;
        }
		
		public function Cap(kind:int = 0) 
		{
			super();
			_kind = kind;
            createImage();
            setupTouch();
            setupShape();
		}

        private function setupShape():void
        {
            shape = new b2CircleShape(45 / Scene.worldScale);
        }

        private function createImage():void
        {
            switch(kind)
            {
                case KIND_PL:
                    texture = Texture.fromTexture(Game.gameTexture, new Rectangle(500, 1548, 500, 500));
                    break;
                case KIND_DE:
                    texture = Texture.fromTexture(Game.gameTexture, new Rectangle(0, 1548, 500, 500));
                    break;
                default:
                    texture = Texture.fromTexture(Game.gameTexture, new Rectangle(1000, 1548, 500, 500));
                    break;
            }

            image = new Image(texture);
            image.width = 100;
            image.height = 100;
            image.x = -50;
            image.y = -50;
            addChild(image);
        }

        private function setupTouch():void
        {
            //don't touch the ball!
            if (kind != KIND_BALL)
            {
                touchable = true;
            }
            else
            {
                touchable = false;
            }


            //targeting gizmo
            gizmo = new Quad(6, 6, 0x00FF00);
            gizmo.y = -3;
            gizmo.pivotX = 3;
            gizmo.alpha = 0;
            addChild(gizmo);

            addEventListener(TouchEvent.TOUCH, onTouch);
        }

        private function resizeGizmo():void
        {
            gizmo.scaleY = Math.min(force_vector.length / 6, 100 / 6) / Scene.displayScale;
            gizmo.scaleX = 1 / Scene.displayScale;
            gizmo.rotation = -rotation + Math.atan2( -force_vector.x, force_vector.y);
            gizmo.alpha = Math.min(force_vector.length / 100, 1);
        }

        private function onTouch(e:TouchEvent):void
        {
            var touch:Touch = e.getTouch(this);
            //the cap is not being touched - zero the force and reset the gizmo
            if (!touch)
            {
                force_vector = new Point();
                resizeGizmo();
                return;
            }

            //temporarily zero the rotation so that we get proper touch location local transform
            var currentRotation:Number = rotation;
            rotation = 0;
            force_vector = touch.getLocation(this);
            force_vector.x *= Scene.displayScale;
            force_vector.y *= Scene.displayScale;
            rotation = currentRotation;

            switch(touch.phase)
            {
                case TouchPhase.BEGAN:
                    //apply the force at cap's center
                    force_application_point = new Point(body.GetWorldCenter().x * Scene.worldScale, body.GetWorldCenter().y * Scene.worldScale);
                    parent.setChildIndex(this, parent.numChildren - 1);
                    break;
                case TouchPhase.MOVED:
                    //update the gizmo
                    resizeGizmo();
                    break;
                case TouchPhase.ENDED:
                    //shoot the cap!
                    body.ApplyImpulse(
                            new b2Vec2( -Math.min(force_vector.x/Scene.worldScale, 100),
                                    -Math.min(force_vector.y/Scene.worldScale, 100)),
                            new b2Vec2(force_application_point.x/Scene.worldScale, force_application_point.y/Scene.worldScale));
                default:
                    //the cap is not being touched - zero the force and reset the gizmo
                    force_vector = new Point();
                    resizeGizmo();
            }

        }

    }

}