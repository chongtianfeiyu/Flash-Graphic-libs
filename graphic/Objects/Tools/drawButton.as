package graphic.Objects.Tools {
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import graphic.COPY;
	import flash.filters.BevelFilter;
	import flash.filters.GlowFilter;
	import graphic.Mouse;
	import graphic.utils.Type;
	import graphic.utils.Modifiers;

	/**
	 * ...
	 * @author locke
	 */
	public dynamic class drawButton extends Sprite {
		[Embed(source='flag.png')]
		private var image:Class;
		private var flag:* = new image();
		private var size:int = 32;
		private var callback:Function;

		public var Icon:MovieClip;
		public var Text:MovieClip;

		public function drawButton(_size:int, icon:* = null, inside:Bitmap = null, _callback:Function = null, showText:Boolean = false){
			callback = _callback;
			var rect:MovieClip = new ToolRect();
			size = rect.width = rect.height;
			addChild(rect);
			if (inside != null){
				var _inside:MovieClip = new MovieClip();
				_inside.addChild(inside);
				_inside.width = _inside.height = size;
				_inside = COPY.cloneMovieClip(_inside, size - size / 10, size - size / 10);
				_inside.x = size / 2 - _inside.width / 2;
				_inside.y = size / 2 - _inside.height / 2;
				addChild(_inside);
			}
			if (icon != null){
				Icon = new MovieClip();
				Icon.addChild(icon);
				//_inside.width = _inside.height = size-size / 10;
				Icon = COPY.cloneMovieClip(Icon, size - size / 10, size - size / 10);
				Icon.x = size / 2 - Icon.width / 2;
				Icon.y = size / 2 - Icon.height / 2;
				addChild(Icon);
				Icon.alpha = .5;
				Icon.buttonMode = true;
				//Mouse.add(Icon, Type.MOUSE_DOWN, {filters: [new BevelFilter(-4, 60, 0xaaaaaa, 1, 0, 1, 3, 3, 5)]});
				//Mouse.add(Icon, Type.MOUSE_UP, {filters: []});
				Mouse.add(Icon, Type.MOUSE_MOVE, {alpha: 1, filters: [new GlowFilter()]});
				Mouse.add(Icon, Type.MOUSE_OUT, {alpha: .5, filters: []});
				Icon.addEventListener(Type.CLICK, callback);
			}
			if (showText){
				Text = new TEXT();
				addChild(Text);
				Text.x = rect.width - Text.width;
				Text.y = rect.height - Text.height;
				text = 0;
			}
			this.width = this.height = _size;
		}

		public function set Switch(value:Boolean):void {
			if (value){
				Icon.addEventListener(Type.CLICK, callback);
			}else
			{
				Icon.removeEventListener(Type.CLICK, callback);
			}
			Icon.alpha = .5
			Mouse.add(Icon, Type.MOUSE_OUT, {alpha: .5, filters: []});
			Icon.filters = [];
			if (flag.parent != null)
				removeChild(flag);
		}

		public function set switchOn(value:Boolean):void {
			if (value){
				Icon.addEventListener(Type.CLICK, callback);
				Icon.alpha = 1;
				Icon.filters = [new GlowFilter(0xff0000, .8, 10, 10)];
				Mouse.add(Icon, Type.MOUSE_OUT, {alpha: .5, filters: [new GlowFilter(0xff0000, .8, 10, 10)]});
				addChild(flag);
				flag.width = 32;
				flag.height = 46;
				flag.x = Icon.x + (Icon.width / 2 - flag.width / 2);
				flag.y = Icon.y - flag.height;
			} else {

				Icon.removeEventListener(Type.CLICK, callback);
				Icon.alpha = .5
				Mouse.add(Icon, Type.MOUSE_OUT, {alpha: .5, filters: []});
				Icon.filters = [];
				;
				if (flag.parent != null)
					removeChild(flag);
			}
		}

		public function set text(value:*):void {
			Text.num.text = String(value);
		}

		public function get text():String {
			return Text.num.text;
		}

	}

}