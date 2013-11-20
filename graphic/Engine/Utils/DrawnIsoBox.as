package graphic.Engine.Utils
{
	import flash.display.Bitmap;
	
	public dynamic class DrawnIsoBox extends DrawnIsoTile
	{
		//private var _alpha:Number = 1;
		
		private var bitmap:Bitmap;
		public var shadow:Shadow;
		public function DrawnIsoBox(size:Number, color:uint, height:Number,_bitmap:Bitmap=null)
		{
			bitmap = _bitmap;
			super(size, color, height);	
		}
		
		override protected function draw():void
		{
			graphics.clear();
			var red:int = _color >> 16;
			var green:int = _color >> 8 & 0xff;
			var blue:int = _color & 0xff;
			
			var leftShadow:uint = (red * .5) << 16 |
								  (green * .5) << 8 |
								  (blue * .5);
			var rightShadow:uint = (red * .75) << 16 |
								   (green * .75) << 8 |
								   (blue * .75);
			
			var h:Number = _height * Y_CORRECT;
			
			if(bitmap!=null){
				// draw top
				graphics.beginBitmapFill(bitmap.bitmapData);
				graphics.lineStyle(0, 0, .5);
				graphics.moveTo(-_size, -h);
				graphics.lineTo(0, -_size * .5 - h);
				graphics.lineTo(_size, -h);
				graphics.lineTo(0, _size * .5  - h);
				graphics.lineTo(-_size, -h);
				graphics.endFill();
				
				// draw left
				graphics.beginBitmapFill(bitmap.bitmapData);
				graphics.lineStyle(0, 0, .5);
				graphics.moveTo(-_size, -h);
				graphics.lineTo(0, _size * .5 - h);
				graphics.lineTo(0, _size * .5);
				graphics.lineTo(-_size, 0);
				graphics.lineTo(-_size, -h);
				graphics.endFill();
				
				// draw right
				graphics.beginBitmapFill(bitmap.bitmapData);
				graphics.lineStyle(0, 0, .5);
				graphics.moveTo(_size, -h);
				graphics.lineTo(0, _size * .5 - h);
				graphics.lineTo(0, _size * .5);
				graphics.lineTo(_size, 0);
				graphics.lineTo(_size, -h);
				graphics.endFill();
				
				_alpha = 0.5;
			}
			// draw top
			
			graphics.beginFill(_color,_alpha);
			graphics.lineStyle(0, 0, .5);
			graphics.moveTo(-_size, -h);
			graphics.lineTo(0, -_size * .5 - h);
			graphics.lineTo(_size, -h);
			graphics.lineTo(0, _size * .5  - h);
			graphics.lineTo(-_size, -h);
			graphics.endFill();
			
			// draw left
			
			graphics.beginFill(leftShadow,_alpha);
			graphics.lineStyle(0, 0, .3);
			graphics.moveTo(-_size, -h);
			graphics.lineTo(0, _size * .5 - h);
			graphics.lineTo(0, _size * .5);
			graphics.lineTo(-_size, 0);
			graphics.lineTo(-_size, -h);
			graphics.endFill();
			
			// draw right
			
			graphics.beginFill(rightShadow,_alpha);
			graphics.lineStyle(0, 0, .5);
			graphics.moveTo(_size, -h);
			graphics.lineTo(0, _size * .5 - h);
			graphics.lineTo(0, _size * .5);
			graphics.lineTo(_size, 0);
			graphics.lineTo(_size, -h);
			graphics.endFill();
			//if (bitmap != null)
			//{
				//var drawIso:GraphicTile = new GraphicTile(this.width,this.height, bitmap);
				//addChild(drawIso);
			//}
		}
		
		
		
	}
}