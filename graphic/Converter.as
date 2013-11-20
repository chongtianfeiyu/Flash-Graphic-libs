package graphic {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import com.adobe.images.PNGEncoder;
	import flash.net.URLRequestMethod;
	import flash.system.System;
	import com.adobe.serialization.json.JSON;

	/**
	 * ...
	 * @author locke
	 */
	public class Converter {
		public function Converter(){

		}

		public static function AutoZeros(maxChar:int, value:int,conect:Boolean=false):String {

			var hex:int = 10, count:int = maxChar;
			while (value % hex != value){
				hex *= 10;
				count--;
				if (count == 0){
					break;
				}
			}
			var text:String = "";
			for (var i:int = 0; i < count; i++){
				text += "0";
			}
			return (!conect)?text:text+String(value);
		}
		public static function AutoZeros_float(maxChar:int, value:Number,conect:Boolean=false):String {

			var hex:int = 10^maxChar, count:int = maxChar;
			while (value % hex != value){
				hex *= 10;
				count--;
				if (count == 0){
					break;
				}
			}
			var text:String = "";
			for (var i:int = 0; i < count; i++){
				text += "0";
			}
			return (!conect)?text:text+String(value);
		}

		public static function String2Array(str:String):Array {
			return str.split('');
		}

		public static function Array2String(arr:Array, start:* = null, stop:* = null):String {
			var str:String = "";
			if (start is String)
				var _start:int = start != null ? seachString(start, arr) + 1 : 0;
			else
				_start = start != null ? start : 0;
			if (stop is String)
				var _stop:int = stop != null ? seachString(stop, arr) : arr.length;
			else
				_stop = stop != null ? stop : arr.length;
			for (var i:int = _start; i < _stop; i++){
				if (arr[i] != '\n')
					str += arr[i];
			}
			return str;
		}

		public static function OutputFile(url:String, obj:*):void {

			var byte:ByteArray = new ByteArray();

			byte.writeUTFBytes(JSON.encode(obj));
			outFile(url, byte);
		}

		public static function Sprite2PNG(url:String, spr:Sprite):void {
			var bit:BitmapData = new BitmapData(spr.width, spr.height);
			bit.draw(spr);
			var byte:ByteArray = PNGEncoder.encode(bit);
			outFile(url, byte);
		}

		public static function seachString(tar:String, arr:Array):int {
			var temp:Array = [];
			var compare:Array = [];
			if (tar.length > 1){
				temp = tar.split("");
				for (var i:int = 0; i < arr.length; i++){
					if (arr[i] == temp[temp.length - 1]){
						if (i >= temp.length - 1){
							for (var j:int = i - (temp.length - 1); j < i; j++)
								if (arr[j] != temp[j])
									break;
						}
						if (j == i)
							return i;
					}

				}

			} else {
				for (i = 0; i < arr.length; i++){
					if (arr[i] == tar)
						return i;
				}
			}
			return i;
		}

		private static function outFile(url:String, data:ByteArray):void {
			System.gc();
			var uLoader:URLLoader = new URLLoader();
			var uReq:URLRequest = new URLRequest(url);
			uReq.data = data;
			uReq.method = URLRequestMethod.POST;
			uReq.contentType = "text/plain";
			uLoader.load(uReq);
		}
	}

}