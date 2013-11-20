package graphic
{
	import flash.display.DisplayObject;
	import flash.filters.BevelFilter;
	import flash.filters.BlurFilter;
	import graphic.utils.PACKAGE;
	import graphic.utils.Type;
	import flash.events.MouseEvent;
	import graphic.utils.Modifiers;
	import flash.system.System;
	
	/**
	 * ...
	 * @author Locke
	 */
	public class Mouse
	{
		
		private static var Effect:Object;
		public static var PackageType:* = PACKAGE;
		public static var Types:* = Type;
		
		public function Mouse()
		{
		
		}
		
		public static function Package(object:*, type:String):void
		{
			var width:int = (object.width + object.height) / 2 / 10;
			width = width < 8?8:width;
			switch (type)
			{
				case PACKAGE.BUTTON_CLASSIC: 
					Mouse.add(object, Type.MOUSE_OUT, {filters: [new BevelFilter(1, 60, 0xaaaaaa, 1, 0, 1, width/2, width/2, width)]});
					Mouse.add(object, Type.MOUSE_DOWN, {filters: [new BevelFilter(-1, 60, 0xaaaaaa, 1, 0, 1, width/2, width/2, width)]});
					Mouse.add(object, Type.MOUSE_UP, { filters: [new BevelFilter(1, 60, 0xaaaaaa, 1, 0, 1, width/2, width/2, width)] } );
					object.filters = [new BevelFilter(1, 60, 0xaaaaaa, 1, 0, 1, width/2, width/2, width)];
					object.buttonMode = true;
					break;
				case PACKAGE.BUTTON_CLASSIC_TYPE2: 
					Mouse.add(object, Type.MOUSE_OUT, {filters: []});
					Mouse.add(object, Type.MOUSE_DOWN, {filters: [new BevelFilter(-1, 60, 0xaaaaaa, 1, 0, 1, width/2, width/2, width)]});
					Mouse.add(object, Type.MOUSE_UP, {filters: []});
					object.filters = [];
					object.buttonMode = true;
					break;
				case PACKAGE.BUTTON_PLAY: 
					Mouse.add(object, Type.MOUSE_OVER, {filters: [new BlurFilter(2, 2)]});
					Mouse.add(object, Type.MOUSE_OUT, {filters: [new BlurFilter(5, 4)]});
					Mouse.add(object, Type.MOUSE_DOWN, {filters: [new BevelFilter(-1, 60, 0xaaaaaa, 1, 0, 1, width/2, width/2, width)]});
					Mouse.add(object, Type.MOUSE_UP, {filters: [new BlurFilter(2, 2)]});
					break;
				case PACKAGE.BUTTON_SWITCH: 
					Mouse.add(object, Type.MOUSE_OVER, {alpha: 1});
					Mouse.add(object, Type.MOUSE_OUT, {alpha: .5, rotation: 0});
					Mouse.add(object, Type.MOUSE_DOWN, {rotation: 180});
					Mouse.add(object, Type.MOUSE_UP, {rotation: 0});
					object.buttonMode = true;
					break;
				case "def": 
					Mouse.add(object, Type.MOUSE_OUT, {filters: []});
					Mouse.add(object, Type.MOUSE_DOWN, {filters: []});
					Mouse.add(object, Type.MOUSE_UP, { filters: [] } );
					object.filters = [];
					object.buttonMode = false;
					break;
			}
		}
		
		public static function add(object:DisplayObject, type:String, effect:Object):void
		{
			if (object.hasEventListener(type))
				object.removeEventListener(type, Event);
			object[type + '_Effect'] = effect;
			if (effect['Modifiers'] != null)
				effect['Modifiers']['parsent'] = object;
			object.addEventListener(type, Event);
		}
		
		private static function Event(e:MouseEvent):void
		{
			Effect = e.currentTarget[e.type + '_Effect'];
			_Effect(e.currentTarget, Effect);
			System.gc();
		}
		
		private static function _Effect(obj:Object, effect:Object):void
		{
			var ins:String;
			if (effect.Modifiers != undefined)
			{
				effect = Modifiers.Launch(effect);
			}
			for (ins in effect)
			{
				if (ins != "Modifiers" && obj[ins] != undefined)
					obj[ins] = effect[ins];
			}
		}
	
	}

}

