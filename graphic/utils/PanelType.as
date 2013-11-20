package graphic.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class PanelType
	{
		public static const FILL_ALPHA:String = "alpha";
		public static const FILL_WINDOW:String = "window";
		
		public function PanelType() { }
		public static function AlphaRectangle(obj:*, rect:Rectangle=null,add:int=1):Rectangle
		{
			var count:int=0;
			var start_x:Number=0, start_y:Number=0, end_x:Number=0, end_y:Number=0,i:int=0,j:int=0;
			var start_checked:Boolean=false;
			var t_bitmapdata:BitmapData = new BitmapData(obj.width, obj.height);
			t_bitmapdata.draw(obj);
			var t_bitmap:Sprite = new Sprite();
			
			if (rect == null)
				rect = new Rectangle(t_bitmapdata.width/10,t_bitmapdata.height/10,t_bitmapdata.width-t_bitmapdata.width/10,t_bitmapdata.height-t_bitmapdata.height/10);
			
			for (i = rect.x; i < rect.width; i+=add )
				for (j = rect.y; j < rect.height; j+=add){
					if (t_bitmapdata.getPixel32(i,j) == 0xffffffff)
					{
						start_x = i;
						start_y = j;
						i = rect.width;
						trace(count);
						break;
					}
					count++;
				}
			trace(count);	
			for (i = rect.width; i > start_x; i -= add )
			{
				for (j = rect.height; j > start_y; j -= add ){
					if (t_bitmapdata.getPixel32(i,j) == 0xffffffff)
					{
						end_x = i;
						end_y = j;
						i = start_x;
						trace(count);
						break;
					}
					count++;
				}
			}
			trace(count);
			
			return new Rectangle(start_x-int(rect.x),start_y-int(rect.y),end_x-start_x,end_y-start_y);
		}
	}
}