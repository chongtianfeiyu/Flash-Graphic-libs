package graphic {
	import flash.display.Sprite;
	import flash.geom.Point;
	import graphic.utils.rect2d;

	/**
	 * ...
	 * @author locke
	 */
	public class colorNumber extends colorText {
		private var Length:int;
		private var color:uint;
		private var rect:rect2d;
		private var temp_arr:Array = [];
		private var arr:Array = ["one_", "ten_", "hundred_","thousands_","ten_thousands_"];
		public function colorNumber() {
			
		}
		public function init_number(length:int, _rect:rect2d = null,col:uint=0):void
		{
			this.x = _rect.x;
			this.y = _rect.y;
			Length = length;
			rect = _rect;
			color = col;
			init();
			numInit();
		}

		private function numInit():void {
			var i:int = 0;
			
			for (i = 0; i < Length; i++) {
				make(arr[i],new Point((Length-i) * (rect.w*0.6),0));
				temp_arr[i] = arr[i]+"0";
				//arr[i].x = ;
				//addChild(arr[i]);
				showText(temp_arr[i]);
			}
		}

		private function make(str:String,p:Point):void {
			var i:int = 0;// , temp:colorText = new colorText();
			//temp.init();
			for (i = 0; i < 10; i++)
				setText(str+i,i.toString(), new rect2d(p.x, p.y, rect.w, rect.h), color);
			//return temp;
		}
		private function getLength(value:int):int
		{
			var i:int = 0;
			i = value < 10?1:2;
			//i = value < 100?2:3;
			i = value < 1000?3:4;
			
			return i;
		}
		public function Numbers(value:String):void
		{
			var i:int = 0;
			var j:int = value.length;//getLength(parseInt(value));
			var k:int = 10;
			var l:int = parseInt(value);
			for (i=0 ; i < j; i++)
			{
				var str:String = new String(l % k);
				disableText(temp_arr[i]);
				showText(arr[i] + str);
				temp_arr[i] = arr[i] + str;
				l /= 10;
				//k *= 10;
			}
		}
		
	}

}