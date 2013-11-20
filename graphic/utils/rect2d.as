package graphic.utils {
	import flash.geom.Point;

	/**
	 * ...
	 * @author locke
	 */
	public class rect2d extends Point {
		public var w:Number = 0;
		public var h:Number = 0;

		public function rect2d(_x:int=0, _y:int=0, _w:int=0, _h:int=0){
			x = _x;
			y = _y;
			w = _w;
			h = _h;
		}
	}

}