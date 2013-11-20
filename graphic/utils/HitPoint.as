package graphic.utils 
{
	import Box2D.Collision.Shapes.b2PolygonDef;
	import Box2D.Dynamics.b2Body;

	import Box2D.Dynamics.b2BodyDef;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Locke locke12456@gmail.com
	 */
	public dynamic class HitPoint extends MovieClip
	{
		private var Dynamic:Boolean = false;

		private var friction:Number = 0.3;
		private var restitution:Number = 0.8;
		private var body:b2Body;
		private var bodyDef:b2BodyDef;
		private var boxDef:b2PolygonDef;
		public function HitPoint() 
		{

		}
		public function Rotation():void
		{
			body.SetXForm(body.GetPosition(), body.GetAngle()+.02);
		}
		public function set Body(value:bodyUtil):void
		{
			body = value.body;
			bodyDef = value.bodyDef;
			boxDef = value.boxDef;
		}
		public function set Friction(value:Number):void
		{
			friction = value;
			body.m_shapeList.m_friction = value;
		}
		public function set Restitution(value:Number):void
		{
			restitution = value;
			body.m_shapeList.m_restitution= value;
			//trace(boxDef.restitution);
		}
		public function set isDynamic(value:Boolean):void
		{
			Dynamic = value;
			
		}
		public function get isDynamic():Boolean
		{
			return Dynamic;
		}
		
		public function isHited(value:Boolean):void
		{
			
		}
	}

}