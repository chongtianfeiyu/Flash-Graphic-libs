package graphic.Objects {
	import flash.display.MovieClip;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filters.BevelFilter;
	import flash.filters.BlurFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import graphic.Mouse;
	import graphic.utils.Type;
	import graphic.utils.Modifiers;

	/**
	 * ...
	 * for InputInterface.swc
	 * @author locke
	 */
	public class Input extends MovieClip {
		private var _interface:AnswerInput;

		public function Input(w:Number = 0, h:Number = 0, trigger:Function = null){
			_interface = new AnswerInput();
			if (w != 0 && h != 0){
				_interface.width = w;
				_interface.height = h;
			}
			addChild(_interface);
			_interface.enter.buttonMode = false;
			//_interface.addEventListener(MouseEvent.MOUSE_DOWN, _stratDrag);
			//_interface.addEventListener(MouseEvent.MOUSE_UP, _stopDrag);
			//Mouse.Package(_interface.enter, Mouse.PackageType.BUTTON_PLAY);
			if (trigger != null)
				_interface.enter.addEventListener(Type.CLICK, trigger);
		}

		public function set text(value:String):void {
			_interface.answer.text = value;
		}
		public function get Focus():TextField
		{
			return _interface.answer;
		}
		public function get text():String {
			return _interface.answer.text;
		}

		private function _stratDrag(e:MouseEvent):void {
			if (e.target.name != 'main')
				return;
			e.currentTarget.parent.startDrag();
		}

		private function _stopDrag(e:MouseEvent):void {
			if (e.target.name != 'main')
				return;
			e.currentTarget.parent.stopDrag();
		}

	}

}