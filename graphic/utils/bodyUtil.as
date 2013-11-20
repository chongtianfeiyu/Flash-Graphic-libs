package graphic.utils 
{
	import Box2D.Collision.Shapes.b2PolygonDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	/**
	 * ...
	 * @author Locke locke12456@gmail.com
	 */
	public class bodyUtil 
	{
		public var body:b2Body;
		public var bodyDef:b2BodyDef;
		public var boxDef:b2PolygonDef;
		public function bodyUtil(Body:b2Body,BodyDef:b2BodyDef, BoxDef:b2PolygonDef)
		{
			body = Body;
			bodyDef = BodyDef;
			boxDef = BoxDef;
		}
		
	}

}