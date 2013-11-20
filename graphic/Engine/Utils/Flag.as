package graphic.Engine.Utils {
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.filters.BlurFilter;

	public dynamic class Flag extends MovieClip{
		private var _parent:IsoObject;
		private var filter:BlurFilter;
		public var shadow:DrawnIsoTile;
		private var _cellSize:Number;
		public var flag:MovieClip; 
		private var pos:Point3D;
		private var disable:Boolean = false;
		public function Flag(_target:IsoObject, bitmap:Bitmap, size:Number, w:Number, h:Number) {
			_parent=_target;
			_cellSize = size;
			var bit:Bitmap = bitmap;
			bit.x = -bit.width / 2;
			bit.y = -bit.height;
			flag = new MovieClip();
			flag.addChild(bit);
			flag.alpha = .8;
			flag.width = w;
			flag.height = h;
			flag.scaleX = 0.2;
			shadow= new DrawnIsoTile(size/ 2, 0);
			shadow.alpha = .5;
			filter = new BlurFilter();

			shadow.filters = [filter];

			updateFlag();
			shadow.y = pos.y + 6;
		}
		
		private function updateFlag(gravity:Number=0):void {
			
			pos = new Point3D(_parent.position.x, _parent.position.y, _parent.position.z);
			pos.y = pos.y - (_cellSize + 5 + gravity);
			flag.x = IsoUtils.isoToScreen(pos).x;
			flag.y = IsoUtils.isoToScreen(pos).y;

			shadow.x = pos.x;
			shadow.z = pos.z;
			shadow.y = pos.y + (5 + gravity);
			filter.blurX = filter.blurY = -pos.y * .35;
			shadow.filters = [filter];
		}
		public function set enable(value:Boolean):void
		{
			if (value == false){
				flag.y = 1000;
				shadow.y = 500;
			}
			disable = !(value);
			flag.alpha = !disable?0.5:0;
			shadow.alpha = !disable?0.5:0;
		}
		public function get enable():Boolean
		{
			return !disable;
		}
		public function set target(value:IsoObject):void
		{
			_parent = value;
		}
		public function show(gravity:Number=0):void
		{
			if(!disable)
				updateFlag(gravity);
		}
	}
}