package graphic.utils {
	import graphic.Engine.Utils.Point3D;

	public class Rect3D {
		private var _x:Number;
		private var _y:Number;
		private var _z:Number;
		private var _width:Number = 0;
		private var _height:Number = 0;
		private var _alpha:Number = 0;

		public function Rect3D(x:Number = 0, y:Number = 0, z:Number = 0, width:Number = 0, height:Number = 0, alpha:Number = 1){
			this.x = x;
			this.y = y;
			this.z = z;
			this.width = width;
			this.height = height;
			this.alpha = alpha;
		}

		public function get x():Number {
			return this._x;
		}

		public function set x(value:Number):void {
			this._x = value;
		}

		public function get y():Number {
			return this._y;
		}

		public function set y(value:Number):void {
			this._y = value;
		}

		public function get z():Number {
			return this._z;
		}

		public function set z(value:Number):void {
			this._z = value;
		}

		/* Width and Height */
		public function get width():Number {
			return this._width;
		}

		public function set width(value:Number):void {
			this._width = value;
		}

		public function get height():Number {
			return this._height;
		}

		public function set height(value:Number):void {
			this._height = value;
		}

		public function get alpha():Number {
			return this._alpha;
		}

		public function set alpha(value:Number):void {
			this._alpha = value;
		}
	}
}