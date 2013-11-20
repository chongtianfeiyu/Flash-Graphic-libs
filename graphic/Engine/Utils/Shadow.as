package graphic.Engine.Utils {
	import flash.display.Bitmap;
	import flash.filters.BlurFilter;

	public dynamic class Shadow extends DrawnIsoTile {
		private var _parent:*;
		private var filter:BlurFilter;
		public function Shadow(parent:*, size:Number, color:uint, height:Number){
			super(size, color, height);
			_parent = parent;
			_parent.shadow = this;
			filter= new BlurFilter();
			filter.blurX = filter.blurY = -parentes.y * .25;
			this.x = parentes.x;
			this.z = parentes.z;
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
			this.x = parentes.x;
			this.z = parentes.z;
			filter.blurX = filter.blurY = -parentes.y * .25;
			this.filters = [filter];
		}
	}
}