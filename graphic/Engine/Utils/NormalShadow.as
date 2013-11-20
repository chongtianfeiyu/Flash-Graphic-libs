package graphic.Engine.Utils {
	import flash.display.Bitmap;
	import flash.filters.BlurFilter;
	import flash.geom.Point;

	public dynamic class NormalShadow extends DrawnIsoTile {
		private var _parent:*;
		private var filter:BlurFilter;
		private var point:Point3D ;
		public function NormalShadow(parent:*, size:Number, color:uint, height:Number){
			super(size, color, height);
			_parent = parent;
			point=IsoUtils.screenToIso(new Point(parentes.x, parentes.y));
			//_parent.shadow = this;
			filter= new BlurFilter();
			filter.blurX = filter.blurY = -point.y * .25;
			this.x = point.x;
			this.z = point.z;
			this.alpha = 0.5;
			this.filters = [filter];
		}

		public function set parentes(value:*):void {
			if(value!=null)
				value.shadow = this;
			_parent = value;
		}

		public function get parentes():* {
			return _parent;
		}
		
		public function show():void
		{
			if (parentes == null){
				this.alpha = 0;
				return;
			}
			
			this.x = point.x;
			this.z = point.z;
			filter.blurX = filter.blurY = -point.y * .25;
			this.filters = [filter];
		}
	}
}