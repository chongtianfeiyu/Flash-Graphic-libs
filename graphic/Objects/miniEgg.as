package graphic.Objects 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import graphic.COPY;
	/**
	 * ...
	 * for Mini.swc
	 * @author locke
	 */
	public dynamic class miniEgg extends MovieClip 
	{
		private var picel:Number = 30;
		public var body:b2Body;
		public function miniEgg(w:Number) 
		{
			super();
			var mc:MovieClip = new EGG();
			mc.depth.transform.colorTransform= new ColorTransform(Math.random() * 1, Math.random() * 1, Math.random() * 1);
			var tempbit:MovieClip = COPY.cloneMovieClip(mc, w, w);
			tempbit.height = tempbit.width = w;
			tempbit.x = tempbit.y = -w / 2;
			addChild(tempbit);
		}
		
		public function setPosition(x:Number,y:Number):Boolean{
			return body.SetXForm(new b2Vec2(x/picel,y/picel),0);
		}
		
	}

}