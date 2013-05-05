package eu.proto.CapsSoccerMobile.sceneBase 
{
    import Box2D.Collision.Shapes.b2Shape;
    import Box2D.Dynamics.b2Body;
    import Box2D.Dynamics.b2BodyDef;
    import Box2D.Dynamics.b2FixtureDef;
    import starling.display.Sprite;
	
	/**
	 * Base class for a body with both graphical an physical representations, managing its physics' setup and update
	 */
	
	public class BodySprite extends Sprite 
	{
        private var _body:b2Body;

        public function get body():b2Body
        {
            return _body;
        }

        public function set body(value:b2Body):void
        {
            _body = value;
            var fixture:b2FixtureDef = new b2FixtureDef();
            fixture.shape = shape;
            fixture.friction = friction;
            fixture.density = density;
            fixture.restitution = restitution;
            _body.CreateFixture(fixture);
        }

        public var bodyDef:b2BodyDef;
        protected var shape:b2Shape;

        public var friction:Number = 1;
        public var density:Number = 0.01;
        public var restitution:Number = 1;
        public var linearDamping:Number = 2;
        public var angularDamping:Number = 4;
        public var type:uint = b2Body.b2_dynamicBody;

		public function BodySprite()
		{
            super();
            bodyDef = new b2BodyDef();
            bodyDef.type = type;
            bodyDef.linearDamping = linearDamping;
            bodyDef.angularDamping = angularDamping;
		}

        public function update():void
        {
            x = body.GetPosition().x * Scene.worldScale;
            y = body.GetPosition().y * Scene.worldScale;
            rotation = body.GetAngle();
        }
	}

}