package graphic {
	import flash.display.Sprite;
	import flash.text.*;

	/**
	 * ...
	 * @author locke
	 */
	public class addItem extends Sprite {

		public function addItem(){

		}

		public function addText(str:String, input:Boolean, x:int, y:int, w:int, h:int, color:uint = 0):TextField {
			var TextBox:TextField = new TextField();
			TextBox.type = input ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
			TextBox.text = str;
			TextBox.width = w;
			TextBox.height = h;
			TextBox.x = x;
			TextBox.y = y;
			TextBox.textColor = color;
			//TextBox.background = true;
			return TextBox;
		}

		public function addButton(x:int, y:int, w:int, h:int):Sprite {
			var _sprite:Sprite = new Sprite();
			_sprite.graphics.beginFill(0xffffff);
			_sprite.graphics.drawRect(0, 0, w, h);
			_sprite.graphics.endFill();
			_sprite.buttonMode = true;
			_sprite.x = x;
			_sprite.y = y;
			return _sprite;
		}

		public function addTextButton(_string:String, x:int, y:int, w:int, h:int):Sprite {
			var Button:Sprite = addButton(x, y, w, h);
			var ButtonText:TextField = addText(_string, false, 0, 0, w, h);
			var Button_cover:Sprite = addButton(0, 0, w, h);
			Button_cover.alpha = 0.5;
			Button.addChild(ButtonText);
			Button.addChild(Button_cover);
			return Button;
		}

	}

}