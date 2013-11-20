package graphic.Objects 
{
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.filters.BevelFilter;
	import flash.filters.BlurFilter;
	import graphic.Mouse;
	import graphic.utils.Type;
	import graphic.utils.Modifiers;
	import graphic.Converter;

	/**
	 * ...
	 * for InputInterface.swc
	 * @author locke
	 */
	public class NumberKeyboard extends MovieClip {
		private var _interface:keyboard_panel;
		private var _text:Array = [];
		private var answer:String;
		private var trigger:Function;

		public function NumberKeyboard(_trigger:Function = null, target:* = null) {
			
			_interface = new keyboard_panel();
			//_interface.width = 128;
			//_interface.height = 160;
			addChild(_interface);
			//_interface.addEventListener(MouseEvent.MOUSE_DOWN, _stratDrag);
			//_interface.addEventListener(MouseEvent.MOUSE_UP, _stopDrag);
			var temp:Key;
			for (var i:int = 0, j:int = 0; i < 12; i++){
				if (i < 10){
					temp = new Key(((i + 1) % 10).toString(), 32, add);
					temp.x = 116 + (34 * ((i % 3) - 3));
				} else if (i == 10){
					temp = new Key("←", 32, sub);
					temp.x = 116 + (34 * ((i % 3) - 3));
				} else {
					temp = new Key("CE", 32, clr);
					temp.x = 116 + (34 * ((i % 3) - 3));
				}

				temp.y = 12 + j * 32;
				j = (i + 1) % 3 == 0 ? j + 1 : j;
				_interface.addChild(temp);

			}
			trigger = _trigger;
			if (target != null)
				target.addEventListener(KeyboardEvent.KEY_UP, push);
		}

		private function push(e:KeyboardEvent):void {
			text = e.currentTarget.text;
		}

		public function add(value:String = null):void {
			_text.push(value);
			if (trigger != null)
				trigger();
		}

		public function set text(value:String):void {
			if (parseInt(value) == 0){
				_text = [];
				_text.push("0");
				return;
			}
			_text = Converter.String2Array(value);
		}

		public function get text():String {
			var temp:String = parseInt(Converter.Array2String(_text)).toString();
			if (_text.length == 0||temp=="NaN")
				return "0";
			else
				return temp;
		}

		private function sub():void {
			_text.pop();
			if (_text.length == 0)
				_text.push("0");
			if (trigger != null)
				trigger();
		}

		private function clr():void {
			text = "0";
			if (trigger != null)
				trigger();
		}

		private function _stratDrag(e:MouseEvent):void {
			if (e.target.parent is num_button)
				return;
				e.currentTarget.parent.startDrag();
				trace(e.target.parent);
		}

		private function _stopDrag(e:MouseEvent):void {
			if (e.target.parent is num_button)
				return;
				e.currentTarget.parent.stopDrag();
		}

	}

}