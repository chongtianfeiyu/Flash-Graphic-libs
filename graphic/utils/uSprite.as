package graphic.utils {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import graphic.Engine.Utils.Point3D;

	/**
	 * ...
	 * @author locke
	 */
	public class uSprite extends Sprite {
		private var _rect:Rect3D = new Rect3D();
		private var _rotation:Point3D = new Point3D();
		private var _scale:Point3D = new Point3D();
		private var __rotation:Number;

		public function uSprite(){
			super();
		}

		/* POINT */
		public function get position():Point3D {
			return new Point3D(_rect.x, _rect.y, _rect.z);
		}

		public function set position(value:Point3D):void {
			_rect = new Rect3D(value.x, value.y, value.z);
			super.x = value.x;
			super.y = value.y;
			super.z = value.z;
		}

		override public function get x():Number {
			return _rect.x;
		}

		override public function set x(value:Number):void {
			super.x = _rect.x = value;
		}

		override public function get y():Number {
			return _rect.y;
		}

		override public function set y(value:Number):void {
			super.y = _rect.y = value;
		}

		override public function get z():Number {
			return _rect.z;
		}

		override public function set z(value:Number):void {
			super.z = _rect.z = value;
		}

		/* Width and Height */
		override public function get width():Number {
			return super.width;
		}

		override public function set width(value:Number):void {
			_rect.width = super.width = value;
		}

		override public function get height():Number {
			return super.height;
		}

		override public function set height(value:Number):void {
			_rect.height = super.height = value;
		}

		override public function get alpha():Number {
			return super.alpha;
		}

		override public function set alpha(value:Number):void {
			_rect.alpha = super.alpha = value;
		}

		override public function get rotation():Number {
			return super.rotation;
		}

		override public function set rotation(value:Number):void {
			__rotation = super.rotation = value;
		}

		override public function get rotationX():Number {
			return super.rotationX;
		}

		override public function set rotationX(value:Number):void {
			_rotation.x = super.rotationX = value;
		}

		override public function get rotationY():Number {
			return super.rotationY;
		}

		override public function set rotationY(value:Number):void {
			_rotation.y = super.rotationY = value;
		}

		override public function get rotationZ():Number {
			return super.rotationZ;
		}

		override public function set rotationZ(value:Number):void {
			_rotation.z = super.rotationZ = value;
		}

		override public function get scaleX():Number {
			return super.scaleX;
		}

		override public function set scaleX(value:Number):void {
			_scale.x = super.scaleX = value;
		}

		override public function get scaleY():Number {
			return super.scaleY;
		}

		override public function set scaleY(value:Number):void {
			_scale.y = super.scaleY = value;
		}

		override public function get scaleZ():Number {
			return super.scaleZ;
		}

		override public function set scaleZ(value:Number):void {
			_scale.z = super.scaleZ = value;
		}

	}

}