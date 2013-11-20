package graphic.Engine.Utils {
	import flash.display.MovieClip;

	public dynamic class GraphicIsoBox extends IsoObject {
		private var mc:MovieClip;
		public var shadow:Shadow;
		public function GraphicIsoBox(size:Number, gfx:MovieClip, xoffset:Number, yoffset:Number){
			super(size);
			gfx.x = -xoffset;
			gfx.y = -yoffset;
			mc = gfx;
			addChild(gfx);
		}
		public function get MOVIE_CLIP():* {
			return mc;
		}

		public function label(target:String, value:String):void {
			if (mc[target].currentLabel != value)
				mc[target].gotoAndPlay(value);
				
			if (!mc[target].isStoped)
				return;
			mc[target].gotoAndPlay(value);

		}
	}
}