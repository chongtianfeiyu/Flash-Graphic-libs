package graphic.Objects {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import graphic.Event.Progress;
	import graphic.utils.*;

	/**
	 * ...
	 * @author locke
	 */
	public class Panel extends MovieClip {
		
		public var inside:MovieClip;
		public var outside:MovieClip;
		private var top:MovieClip = new MovieClip();
		private var mid:MovieClip = new MovieClip();
		private var Queue:*;
		private var rect:Rectangle = new Rectangle(0, 0, 20, 20);
		private var type:String;
		public function Panel(w:Number = 0, h:Number = 0, queue:* = null):void {
			Queue = queue;
			type = Queue['PanelType'] != null  ? Queue['PanelType'] : '0xff';
			var color:uint;
			if (queue != null && queue['bitmap'][0] != null && queue['bitmap'][0]['bitmap'] != null){
				outside = drawObject(queue['bitmap'][0]['bitmap']);
				outside.width = w;
				outside.height = h;
				if(type==PanelType.FILL_ALPHA)
					rect=PanelType.AlphaRectangle(outside);
			} else {
				color = (queue['bitmap'][0] != undefined && queue['bitmap'][0]['color'] != undefined) ? queue['bitmap'][0]['color'] : 0;
				outside = def_Covery(color);
			}
			if (queue != null && queue['bitmap'][1] != null && queue['bitmap'][1]['bitmap'] != null){
				inside = drawObject(queue['bitmap'][1]['bitmap']);
			} else {
				color = (queue['bitmap'][1] != undefined && queue['bitmap'][1]['color'] != undefined) ? queue['bitmap'][1]['color'] : 0;
				inside = def_Covery(color);
			}
			var layer:int = (queue != null) ? parseInt(queue['queue']) : 0;
			if (layer == 1){
				addChild(inside);
				addChild(mid);
				addChild(outside);
			} else {
				addChild(outside);
				addChild(mid);
				addChild(inside);

			}
			addChild(top);
			
			
			panel_width = w;
			panel_height = h;

			if ((queue != null)){
				inside = upgrade.Upgrade(inside, queue['bitmap'][1], 'bitmap');
				outside = upgrade.Upgrade(outside, queue['bitmap'][0], 'bitmap');
			}
		}
		public function addMovieClip(value:*):* 
		{
			mid.addChild(value);
		}
		public function addObject(value:*):* {
			var m_Text:MovieClip = new MovieClip();
			//value['x'] = ;
			value['y'] = parseInt(value['y']) + inside.y; // / 2;
			var str:String;
			if(value['bitmap']!=null)
				m_Text.addChild(value['bitmap']);
			for (str in value){
				if (str == 'bitmap'){
					
				} else
					m_Text[str] = value[str];
			}
			//m_Text.x = width;

			//Tweener.addTween(m_Text, { x:(parseInt(value['x']) + this.width/2) - value['bitmap']['width'] / 2 ,time:2} );

			//m_Text.y -= value['bitmap']['height'] / 2;

			mid.addChild(m_Text);

			return m_Text;
		}
		public function addObjectToTop():void
		{
			while(mid.numChildren!=0)
				top.addChild(mid.getChildAt(0));
		}
		
		public function drawObject(_tar:*):MovieClip {
			var tmpMC:MovieClip = new MovieClip();

			var bitmap:BitmapData = _tar.bitmapData;
			//bitmap.draw(_tar);
			tmpMC.graphics.beginBitmapFill(bitmap);
			tmpMC.graphics.drawRect(0, 0, bitmap.width, bitmap.height);
			tmpMC.graphics.endFill();
			return tmpMC;

		}

		public function set panel_width(value:int):void {
			
			outside.width = value;
			
			switch (type){
				case PanelType.FILL_ALPHA:
					inside.width = rect.width;
					inside.x = rect.x;
					//inside.x = (inside.width / 2) - rect.x;
					//inside.x = value / 2 - inside.width / 2;
					break;
				case PanelType.FILL_WINDOW:
					inside.width = value-value/10;
					//inside.x = 0;
					break;

				case '0xff':				
					inside.width = (value * 0.93);
					inside.x = value / 2 - inside.width / 2;
					break;
			}
			//inside.x = value / 2 - inside.width / 2;
			//trace(this._objects.length);
			//btn_fit();
		}

		public function set panel_height(value:int):void {
			//var type:String = Queue['bitmap'] != null && Queue['bitmap']['PanelType'] != null ? Queue['bitmap']['PanelType'] : '0xff';
			outside.height = value;
			switch (type){
				case PanelType.FILL_ALPHA:
					inside.height = rect.height;
					inside.y = rect.y;
					break;
				case PanelType.FILL_WINDOW:
					inside.height = (value-value/10);
					inside.y = value / 2 - inside.height / 2;
					break;
				case '0xff':
					inside.height = (value * 0.83);
					inside.y = 10;
					
					break;
			}
			//btn_fit();
		}

		public function get inside_y():int {
			return 10 + inside.height;
			//btn_fit();
		}

		public function get inside_x():int {
			return inside.x + inside.width;
			//btn_fit();
		}

		public function get inside_width():int {
			return inside.width;
		}

		public function get inside_height():int {
			return inside.height;
		}
		public function onRemove(e:Event):void
		{
			e.currentTarget.removeEventListener(Event.COMPLETE, onRemove);
			var parent:* = e.currentTarget.parent;
			if (parent != null) parent.removeChild(e.currentTarget);
		}
		private function def_Covery(col:uint = 0x888888, w:int = 20, h:int = 20):MovieClip {
			//col = Math.random() * 0xffffff;
			var t_movie:MovieClip = new MovieClip();
			t_movie.graphics.beginFill(col);
			t_movie.graphics.drawRect(0, 0, w, h);
			t_movie.graphics.endFill();
			return t_movie;
		}
	}

}