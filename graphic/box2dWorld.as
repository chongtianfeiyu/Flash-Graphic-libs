package graphic {
	import Box2D.Dynamics.*;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import graphic.utils.bodyUtil;
	import graphic.utils.HitPoint;
	import graphic.utils.rect2d;

	import Box2D.Collision.*;

	import Box2D.Collision.Shapes.*;

	import Box2D.Common.Math.*;

	/**
	 * ...
	 * @author locke
	 */
	public class box2dWorld extends Sprite {
		public var m_iterations:int = 10;
		public var m_timeStep:Number = 1.0 / 12.0;
		private var world:b2AABB = new b2AABB();
		private var global:b2World;
		private var body:b2Body;
		private var picel:Number = 30;

		//private var top:Number, bottom:Number, left:Number, right:Number;
		public function box2dWorld(){
			world.lowerBound.Set(-100, -100);
			world.upperBound.Set(100, 100);
			var gravity:b2Vec2 = new b2Vec2(0, 4.5);
			global = new b2World(world, gravity, true);
		}

		public function creatBox(target:*):bodyUtil {

			var temp:* = target;

			var rotation:Number = temp.rotation * (Math.PI / 180);
			temp.rotation = 0;
			var rect:rect2d = new rect2d(temp.x, temp.y, temp.width / 2, temp.height / 2);
			var bodyDef:b2BodyDef;

			var boxDef:b2PolygonDef;

			bodyDef = new b2BodyDef();
			bodyDef.userData = temp;
			bodyDef.position.Set(rect.x / picel, rect.y / picel);
			bodyDef.angle = rotation;

			boxDef = new b2PolygonDef();

			boxDef.SetAsBox(rect.w / picel, rect.h / picel);

			//boxDef.SetAsOrientedBox
			
			boxDef.friction = 0.3;
			

			boxDef.density = 0;

			body = global.CreateBody(bodyDef);

			body.CreateShape(boxDef);
			
			body.SetMassFromShapes();
			return new bodyUtil(body,bodyDef, boxDef);
			//body.m_userData.rotation = body.GetAngle() * (180 / Math.PI);
		}

		public function creatCircle(sprite:MovieClip):void {
			var bodyDef:b2BodyDef;

			var circleDef:b2CircleDef;

			bodyDef = new b2BodyDef();

			circleDef = new b2CircleDef();

			bodyDef.position.Set(sprite.x / picel, sprite.y / picel);

			circleDef.radius = (sprite.width / 2) / picel;

			circleDef.density = 1;

			circleDef.friction = 0.3;

			circleDef.restitution = 0.8;

			bodyDef.userData = sprite;

			body = global.CreateBody(bodyDef);
			sprite['body'] = body;
			body.CreateShape(circleDef);

			body.SetMassFromShapes();
		}

		public function move():void {
			global.Step(m_timeStep, m_iterations);

			for (var bb:b2Body = global.m_bodyList; bb; bb = bb.m_next){
				if (bb.m_userData is MovieClip && !bb.IsSleeping()) {
					//if(bb.m_userData is ballPoint)
					//	trace(bb.GetAngularVelocity());
					bb.m_userData.x = bb.GetPosition().x * 30;

					bb.m_userData.y = bb.GetPosition().y * 30;

					bb.m_userData.rotation = bb.GetAngle() * (180 / Math.PI);
				}
			}
		}

		public function shake():void {
			global.Step(m_timeStep, m_iterations);

			for (var bb:b2Body = global.m_bodyList; bb; bb = bb.m_next){
				if (bb.m_userData is MovieClip && !bb.IsSleeping()){
					var x:int = bb.GetXForm().position.x * 30 + (-12 + Math.random() * 24);
					var y:int = bb.GetXForm().position.y * 30 + (-8 + Math.random() * 16);
					bb.SetXForm(new b2Vec2(x / picel, y / picel), bb.GetAngle());

					bb.m_userData.rotation = bb.GetAngle() * (180 / Math.PI);
				}
			}
		}

	}

}