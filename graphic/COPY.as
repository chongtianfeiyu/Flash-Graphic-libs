package graphic {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.utils.ByteArray;

	/**
	 * ...
	 * @author locke
	 */
	public class COPY {

		public function COPY(){

		}

		public static function clone(_obj:Object = null):Object {
			var buffer:ByteArray = new ByteArray();
			buffer.writeObject(_obj);
			buffer.position = 0;
			return buffer.readObject();
		}

		public static function cloneMovieClip(_obj:*,width:Number=-1,height:Number=-1):MovieClip {
			var bit:BitmapData = new BitmapData(_obj.width, _obj.height, true, 0x00000000);
			bit.draw(_obj);
			var bitmap:Bitmap = new Bitmap(bit);
			var temp_mc:MovieClip = new MovieClip();
			temp_mc.addChild(bitmap);
			if(bitmap.width!=-1)
				bitmap.width = width;
			if(bitmap.height!=-1)
				bitmap.height = height;
			return temp_mc;
		}
		public static function toBitmap(_obj:*,width:Number=-1,height:Number=-1):Bitmap {
			var bit:BitmapData = new BitmapData(_obj.width, _obj.height, true, 0x00000000);
			bit.draw(_obj);
			var bitmap:Bitmap = new Bitmap(bit);
			var temp_mc:MovieClip = new MovieClip();
			temp_mc.addChild(bitmap);
			if(bitmap.width!=-1)
				bitmap.width = width;
			if(bitmap.height!=-1)
				bitmap.height = height;
			bit = new BitmapData(temp_mc.width, temp_mc.height,true,0x00000000);
			bit.draw(temp_mc);
			bitmap = new Bitmap(bit);
			return bitmap;
		}
		public static function toBitmapCenter(_obj:*, center:Number, width:Number = -1, height:Number = -1):Bitmap {
			var obj:MovieClip = new MovieClip();
			obj.addChild(_obj);
			_obj.x = _obj.y = center;
			var bit:BitmapData = new BitmapData(width, height, true, 0x00000000);
			
			bit.draw(obj);
			var bitmap:Bitmap = new Bitmap(bit);
			var temp_mc:MovieClip = new MovieClip();
			temp_mc.addChild(bitmap);
			bit = new BitmapData(temp_mc.width, temp_mc.height,true,0x00000000);
			bit.draw(temp_mc);
			bitmap = new Bitmap(bit);
			return bitmap;
		}

	}

}