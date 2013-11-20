package graphic.Objects
{
	import com.adobe.images.BitString;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BevelFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import graphic.Mouse;
	import graphic.utils.Type;
	import caurina.transitions.Tweener;
	
	/**
	 * ...
	 * @author locke
	 */
	public class Window extends MovieClip
	{
		private var Picture:Array = [];
		private var removePicture:MovieClip;
		private var isFull:Boolean = false;
		public var PICDATA:BitmapData;
		public var PIC:Bitmap;
		private var input:Object = new Object();
		private var output:Object = new Object();
		private var buttons:Object = new Object();
		private var Childs:Object = {input: input, output: output, buttons: buttons};
		private var panel:Panel;
		private var old_b_top:int;
		private var old_t_center:int;
		private var old_t_Top:int;
		private var old_panel_x:int;
		private var static_width:int;
		
		/**
		 *
		 * @param  w	Window's width
		 * @param  h	Window's height
		 * @param  bmp_queue	{	bimap:[{bitmap:Outside frame,layer:1 or 0 , x: ,y: ,alpha: ,	...	}	,	...]}}
		 * */
		public function Window(w:int = 200, h:int = 200, bmp_queue:* = null):void
		{
			PICDATA = new BitmapData(200, 200, true, 0x00000000);
			PIC = new Bitmap(PICDATA);
			panel = new Panel(w, h, bmp_queue);
			static_width = w;
			addChild(panel);
			//panel.addEventListener(MouseEvent.MOUSE_DOWN, _stratDrag);
			//panel.addEventListener(MouseEvent.MOUSE_UP, _stopDrag);
		}
		
		/**
		 *
		 * @param  value	{ x:	, y:	, width:	, height:	...,
		 * 					  Name:		,	}
		 * */
		public function add_Text_Input(value:Object):void
		{
			
			var m_Text:MovieClip = new Text_group();
			value['x'] = parseInt(value['x']) + t_center;
			value['y'] = parseInt(value['y']) + t_Top;
			var str:String;
			for (str in value)
			{
				m_Text[str] = value[str];
			}
			addChild(m_Text);
			input[value['Name']] = m_Text; //Creat_Object(Childs.length, value['Name'], m_Text);
		}
		
		public function Picture_preview(bitmap:*):void
		{
			PICDATA.fillRect(new Rectangle(0, 0, 200, 200), 0x00000000);
			PICDATA.draw(bitmap);
			PIC.y = this.height / 2 - PIC.height / 2;
		}
		
		public function add_Text_Output(value:Object):void
		{
			
			var m_Text:MovieClip = new Text_output();
			value['x'] = parseInt(value['x']) + t_center;
			value['y'] = parseInt(value['y']) + t_Top;
			var str:String;
			for (str in value)
			{
				m_Text[str] = value[str];
			}
			//m_Text.filters = [new BevelFilter(-4, 60, 0xaaaaaa, 1, 0, 1, 3, 3, 5)];
			addChild(m_Text);
			output[value['Name']] = m_Text; //Creat_Object(Childs.length, value['Name'], m_Text);
		}
		
		public function add_button(value:*, skip:Boolean = false):void
		{
			if (skip)
			{
				addChild(value);
				return;
			}
			//var mouse:Mouse = new Mouse();
			if (value is MovieClip)
			{
				addChild(value);
				Mouse.add(value, Type.MOUSE_DOWN, {filters: [new BevelFilter(-4, 60, 0xaaaaaa, 1, 0, 1, 3, 3, 5)]});
				Mouse.add(value, Type.MOUSE_UP, {filters: []});
			}
			else if (value is Object)
			{
				var btn:MovieClip = new Btn_Text();
				value['x'] = parseInt(value['x']) + panel.inside_x;
				value['y'] = parseInt(value['y']) + b_Top;
				value['h'] = b_height;
				var str:String;
				for (str in value)
				{
					btn[str] = value[str];
				}
				buttons[value['Text']] = btn; //Childs.push(Creat_Object(Childs.length, value['Text'], btn));
				addChild(btn);
				Mouse.add(btn, Type.MOUSE_DOWN, {filters: [new BevelFilter(-4, 60, 0xaaaaaa, 1, 0, 1, 3, 3, 5)]});
				Mouse.add(btn, Type.MOUSE_UP, {filters: []});
					//btn.filters = [new BevelFilter( 5)];
			}
		
		}
		
		public function addMovieClip(value:Object):void
		{
			panel.addMovieClip(value);
		}
		
		public function add_Picture(value:Object):MovieClip
		{
			//if (isFull || Picture.length * value['width'] > width)
			//	return null;
			var m_Text:MovieClip = panel.addObject(value); // new MovieClip();
			
			m_Text.x = width;
			Picture.push(m_Text); //Creat_Object(Childs.length, value['Name'], m_Text);
			isFull = (Picture.length + 2 ) * m_Text.width > static_width;
			if (isFull) {
				removePicture = Picture.shift();
				
				removePicture["Tween"]={ x: 0, alpha:0, time: 1, onComplete:removePic };
				removePicture.addEventListener(Event.COMPLETE, panel.onRemove);
				isFull = false;
			}
			p_sort();
			return Picture[Picture.length - 1];
			//Picture['length'] = parseInt(Picture['length']) + 1;
		}
		public function recycle_Picture(value:MovieClip):MovieClip
		{
			panel.addChild(value);
			var m_Text:MovieClip = value; // new MovieClip();
			m_Text.x = width;
			Picture.push(m_Text); //Creat_Object(Childs.length, value['Name'], m_Text);
			isFull = (Picture.length+2 )* m_Text.width > static_width;
			if (isFull) {
				removePicture = Picture.shift();
				removePicture["Tween"]={ x: 0, alpha:0, time: 1, onComplete:removePic };
				//Tweener.addTween(removePicture,  );
				removePicture.addEventListener(Event.COMPLETE, panel.onRemove);
				isFull = false;
			}
			p_sort();
			return Picture[Picture.length - 1];
		}
		private function p_sort():void
		{
			var time:Number;
			var delay:Number;
			var _x:int;
			var a:Number = Picture[0]['x'] - Picture[0]['width'];
			var b:Number = static_width / Picture[0]['width'];
			var bool:Boolean = a > b;
			for (var i:int = 0; i < Picture.length; i++)
			{
				
				if (bool)
				{
					if (i == 0)
					{
						var tar:int = (static_width / 2) - (Picture[i]['width']) / 2;
						_x = Picture[i]['x'] > tar ? tar : (static_width - Picture.length * (Picture[i]['width'])) / 2 - Picture[i]['width'] / 10;
						if (_x < 0)
							_x = static_width / Picture[0]['width']; //Picture[0]['width'] / 2+Picture[i]['width'] / 10;
						trace(_x + "      " + tar);
					}
					//delay = i + 1 < Picture.length ? 0.5 + (Picture.length - i) / Picture.length : 1;
					time = i + 1 < Picture.length ? 1 + (Picture.length - i) / Picture.length : 1;
					delay = ((Picture.length - i) / (Picture.length));
					var moving:*= { x: _x, time: time, onUpdate: PlayingPic };
					Picture[i]["Tween"] = moving;
					if(i==Picture.length-1)
						Tweener.addTween(Picture[i], {x: _x, time: time, onUpdate: PlayingPic, onComplete: panel.addObjectToTop});
					_x += Picture[i]['width'] + Picture[i]['width'] / 10;
					trace(delay);
				}
				else if (!bool && i == Picture.length - 1)
				{
					_x = Picture[i - 1]['x'] + Picture[i]['width'] + Picture[i]['width'] / 10;
					if (_x + Picture[i]['width'] < static_width)
						Tweener.addTween(Picture[i], {x: _x, time: 2});
					else
					{
						Picture.pop();
						isFull = true;
					}
				}
			}
		}
		
		public function getChildbyName(str:String, type:String = null):MovieClip
		{
			var i:int = 0;
			return Childs[type][str];
			//for (i = 0; i < Childs.length; i++){
			//trace((Childs[i].Name == str));
			//if (Childs[i].Name == str)
			//return Childs[i].Child;
			//}
			//return null;
		}
		private function PlayingPic():void
		{
			var mc:MovieClip;
			for (var i:int =  Picture.length - 1; i >= 1; i--) {
				mc = Picture[i];
				if (mc["Tween"] != null && Tweener.isTweening(mc))
				{
					//var mc_local:Point = mc.globalToLocal(new Point(Picture[i-1].x, Picture[i-1].y));
					if (mc.hitTestObject(Picture[i - 1]))
					{
						mc["Tween"] = null;
						mc = Picture[i - 1];
						Tweener.addTween(mc, mc["Tween"]);
						if (i - 1 == 0&&removePicture!=null)
						{
							mc = removePicture;
							Tweener.addTween(mc, mc["Tween"]);
						}
					}
					break;
				}
			}
		}
		private function removePic():void
		{
			removePicture.dispatchEvent(new Event(Event.COMPLETE));
			removePicture = null;
		}
		private function Creat_Object(id:*, Name:*, Child:*):Object
		{
			return {id: id, Name: Name, Child: Child};
		
		}
		
		private function _stratDrag(e:MouseEvent):void
		{
			e.currentTarget.parent.startDrag();
		}
		
		private function _stopDrag(e:MouseEvent):void
		{
			e.currentTarget.parent.stopDrag();
		}
		
		private function save_status():void
		{
			old_b_top = b_Top;
			old_t_center = t_center;
			old_t_Top = t_Top;
			old_panel_x = panel.inside_x;
		}
		
		private function update():void
		{
			
			var i:String;
			for (i in Childs[Type.BUTTON])
			{
				Childs[Type.BUTTON][i]['x'] = (Childs[Type.BUTTON][i]['x'] - old_panel_x) + panel.inside_x;
				Childs[Type.BUTTON][i]['y'] = (old_b_top - Childs[Type.BUTTON][i]['y']) + b_Top;
				Childs[Type.BUTTON][i]['h'] = b_height;
			}
			for (i in Childs[Type.INPUT_TEXT])
			{
				Childs[Type.INPUT_TEXT][i]['x'] = (old_t_center - Childs[Type.INPUT_TEXT][i]['x']) + t_center;
				Childs[Type.INPUT_TEXT][i]['y'] = (Childs[Type.INPUT_TEXT][i]['y'] - old_t_Top) + t_Top;
				
			}
			for (i in Childs[Type.LABEL_TEXT])
			{
				Childs[Type.LABEL_TEXT][i]['x'] = (old_t_center - Childs[Type.LABEL_TEXT][i]['x']) + t_center;
				Childs[Type.LABEL_TEXT][i]['y'] = (Childs[Type.LABEL_TEXT][i]['y'] - old_t_Top) + t_Top;
				
			}
			//for (var i:int = 0; i < Childs.length; i++){
			//if (Childs[i].Child is Btn_Text) {
			//
			//}else
			//{
			//Childs[i].Child['x'] = (old_t_center - Childs[i].Child['x']) + t_center;
			//Childs[i].Child['y'] = (Childs[i].Child['y']-old_t_Top )+t_Top;
			//Childs[i].Child['h'] = b_height;
			//}
			//}
		}
		
		public function set Panel_width(value:int):void
		{
			save_status();
			panel.panel_width = value;
			update();
		}
		
		public function set Panel_height(value:int):void
		{
			save_status();
			panel.panel_height = value;
			update();
		}
		
		public function get b_height():int
		{
			return panel.height - (panel.inside_y + panel.inside_y / 46 * 2);
		}
		
		public function get b_Top():int
		{
			return panel.inside_y + panel.inside_y / 46;
		}
		
		public function get t_Top():int
		{
			return panel.inside_y - panel.inside_height;
		}
		
		public function get t_center():int
		{
			return panel.inside_width / 2;
		}
		
		public function get bTop():int
		{
			return panel.height - panel.inside_y + panel.inside_y / 46 * 2;
		}
	
	}

}