package graphic.Objects 
{
	import flash.display.SimpleButton;
	import flash.display.MovieClip;
	import flash.filters.BevelFilter;
	import flash.filters.BlurFilter;
	import flash.text.TextField;
	import graphic.Mouse;
	import graphic.utils.Type;
	import graphic.utils.Modifiers;
	/**
	 * ...
	 * for InputInterface.swc
	 * @author locke
	 */
	public dynamic class Key extends MovieClip {
		private var _text:num_button;
		private var trigger:Function;
		public function Key(num:String="0",size:int = 0,_trigger:Function=null){
			_text = new num_button();
			_text.height = _text.width = size;
			text = num;
			addChild(_text);
			_text.buttonMode = true;
			Mouse.add(_text, Type.MOUSE_OVER, {alpha:0.5});
			Mouse.add(_text, Type.MOUSE_OUT, { alpha:1 ,Modifiers:{mod:Modifiers.CUSTOM,data:play1}} );
			Mouse.add(_text, Type.MOUSE_DOWN, {Modifiers:{mod:Modifiers.CUSTOM,data:play2}});
			Mouse.add(_text, Type.MOUSE_UP, {Modifiers:{mod:Modifiers.CUSTOM,data:play1}});
			//Mouse.Package(_text, Mouse.PackageType.BUTTON_CLASSIC);
			if (_trigger != null) {
				trigger = _trigger;
				Mouse.add(_text, Type.CLICK, {Modifiers:{mod:Modifiers.CUSTOM,data:input } } );
			}
		}
		private function play1(e:*= null):void
		{
			_text.gotoAndStop(1);
		}
		private function play2(e:*= null):void
		{
			_text.gotoAndStop(2);
		}
		private function input():void
		{
			if (trigger.length == 1)
				trigger(text);
			else trigger();
		}
		public function set text(value:String):void {
			_text.num.text = value;
		}
		public function get text():String {
			return _text.num.text;
		}
	}

}