package graphic.utils {
	import flash.geom.Point;

	/**
	 * ...
	 * @author locke
	 */
	public class Formula {

		public function Formula(){

		}
		public static function Distance(p1:*, p2:*):Point
		{
			return new Point(Math.abs(p1.x - p2.x) ,Math.abs(p1.y - p2.y));
		}
		public static function Slope(p1:Point, p2:Point):Number
		{
			return (p2.y - p1.y) / (p2.x-p1.x);
		}
		public static function Percent(a:Number, b:Number):Number {
			return a / b;
		}


		/**
		 *
		 * For Circle
		 *
		 * */
		public static function Angle(theta:Number):Number {
			return theta / Math.PI * 180;
		}

		public static function Theta(angle:Number):Number {
			return angle * Math.PI / 180;
		}

		public static function Radius(x2:Number, y2:Number, x1:Number = 0, y1:Number = 0):Number {
			return Math.sqrt(Math.pow(Math.abs(x2 - x1), 2) + Math.pow(Math.abs(y2 - y1), 2));
		}

		/**
		 * @param	x	x=Target's x - Center's x
		 * @param	y	y=Target's y - Center's y
		 **/
		public static function PointToAngle(x:Number, y:Number):Number {
			var theta:Number = Math.atan((x / y));
			var angle:Number = Math.abs(theta / Math.PI * 180);

			if (y > 0){
				if (x > 0){
					angle = angle;
				} else {
					angle = (360 - angle);
				}
			}
			if (y < 0){
				if (x > 0){
					angle = (180 - angle);

				} else {
					angle = (180 + angle);

				}
			}

			return angle;
		}

	}

}