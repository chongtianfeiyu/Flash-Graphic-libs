package graphic {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import graphic.utils.rect2d;

	/**
	 * ...
	 * @author locke
	 */
	public class colorText extends Sprite {
		
		private var num:Array = [];
		private var english:Array = [];

		private var Text:Array = new Array();

		private var TextArray:Array = [];

		public function colorText(){
			//init();
		}
		public function set English_Text(value:Array):void
		{
			for (var i:int = 0; i < 26;i++ )
				english[i] = value[i];
		}
		public function set Num_Text(value:Array):void
		{
			for (var i:int = 0; i < 10;i++ )
				num[i] = value[i];
		}
		public function setText(name:String,_str:String, site:rect2d, color:uint = 0):void {
			var col:ColorTransform = new ColorTransform(0.5,0.5,0.5,1,0,0,0,0);
			col.color = color;
			var _tempSprite:Sprite = new Sprite();
			_tempSprite.name = name;
			TextArray.push(_tempSprite);
			for (var i:int = -_str.length / 2; i < _str.length / 2; i++){
				var tempSprite:Sprite = new Sprite();
				var j:int = i + _str.length / 2;
				tempSprite = catchAsSprite(text(_str.slice(j, j + 1)));
				tempSprite.name = _str.slice(j, j + 1);
				tempSprite.width = site.w;
				tempSprite.height = site.h;
				tempSprite.x = Number((site.x) + Number(i - 0.5) * tempSprite.width / 1.8);
				tempSprite.y = site.y;
				tempSprite.transform.colorTransform = col;
				_tempSprite.addChild(tempSprite);
			}
		}

		public function showText(_str:String):void {
			if (getChildByName(_str) == null){
				addChild(searchByName(_str, TextArray));
			}
		}
		
		public function disableText(_str:String):void {
			if (getChildByName(_str) != null){
				removeChild(getChildByName(_str));
			}
		}
		public function get playing():String
		{
			return getChildAt(0).name;
		}
		public function disableAll():void {
			for (var i:int = 0; i < TextArray.length; i++){
				if (getChildByName(TextArray[i].name) != null){
					removeChild(TextArray[i]);
				}
			}
		}

		public function getText(_str:String):Sprite {
			return searchByName(_str, TextArray);
		}

		public function setChild(search:String):void {
			if (search.charCodeAt() - 48 < 10)
				Text[int(search.charCodeAt() - 48)][0] = make(search);
			else
				Text[int(search.charCodeAt() - 65 + 10)][0] = make(search);
		}

		private function searchByName(_str:String, _arr:Array):* {
			for (var i:int = 0; i < _arr.length; i++){
				if (_arr[i].name == _str)
					return _arr[i];
			}
			return null;
		}

		private function text(_string:String):* {
			if (_string.charCodeAt() - 48 < 10)
				return Text[int(_string.charCodeAt() - 48)][0];
			else {
				return Text[int(_string.charCodeAt() - 65 + 10)][0];
			}
		}

		private function colorTranform(color:uint):ColorTransform {
			var r:Number = (color >> 0x10)  ;// 0xff;
			var g:Number = ((color >> 0x8) % 0x100);// / 0xff;
			var b:Number = (color % 0x100);// / 0xff;
			var p:Number = r + g + b;
			var off_r:Number = r / p;
			var off_g:Number = g / p;
			var off_b:Number = b / p;
			return new ColorTransform(1,1,1,1,r,g,b,0);// , 1, off_r, off_g, off_b, 1);
		}

		private function make(str:String):Bitmap {
			//var clip:Bitmap;
			var tempClass:Bitmap;
			if (str.charCodeAt() >= 65 && str.charCodeAt() < 65 + 26){
				tempClass = english[str.charCodeAt() - 65];
			} else if (str.charCodeAt() >= 48 && str.charCodeAt() < 48 + 10){
				tempClass = num[str.charCodeAt() - 48];
			} else {
				return null;
			}
			//clip = tempClass;
			return tempClass;
		}

		private function catchAsSprite(_clip:Bitmap):Sprite {
			var sp:Sprite = new Sprite();
			sp.graphics.beginBitmapFill(_clip.bitmapData);
			sp.graphics.drawRect(0, 0, _clip.width, _clip.height);
			sp.graphics.endFill();
			
			//sp.x = -_clip.width / 2;
			//sp.y = -_clip.height / 2;
			return sp;
		}

		private function cloneMovieClip(_clip:MovieClip):* {
			var tempClass:Class = Object(_clip).constructor;
			var mc:DisplayObject = new tempClass();
			return mc;
		}

		public function init():void {
			for (var i:int = 0; i < 10; i++) {
				if(num!=[])
					Text[i] = [make(String.fromCharCode(48 + i)), String.fromCharCode(48 + i)];
				//Text[i][0]
			}
			for (i = 10; i < 36; i++) {
				if(english!=[])
					Text[i] = [make(String.fromCharCode(65 + (i - 10))), String.fromCharCode(65 + (i - 10))];
			}
		}


	}

}