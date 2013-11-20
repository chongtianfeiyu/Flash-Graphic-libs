package graphic.Drag
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Locke
	 */
	[Event(name="touch",type="graphic.Event.DragEvent")]
	[Event(name="hit",type="graphic.Event.DragEvent")]
	[Event(name="drag_stop",type="graphic.Event.DragEvent")]
	[Event(name="drag",type="graphic.Event.DragEvent")]
	
	public class DragBase extends MovieClip
	{
		public static const TOUCH:String = "touch";
		public static const HIT:String = "hit";
		public static const DRAGING:String = "drag";
		public static const DRAG_STOP:String = "drag_stop";
		private var Target:Array;
		private var ITEM:MovieClip;
		private var TempXY:Point;
		private var TempItem:MovieClip;
		private var ItemSelected:MovieClip;
		private var DragRect:Rectangle;
		
		/*
		 * Public
		 * */
		public function DragBase()
		{
			super();
		}
		
		/*
		 * Getter And Setter
		 * */
		public function get DragRange():Rectangle
		{
			return DragRect;
		}
		
		public function set DragRange(value:MovieClip):void
		{
			var Offset:Point = new Point(value.width - (value.width - value.x), (value.height - (value.height - value.y)));
			var OffsetB:Point = value.localToGlobal(new Point((Offset.x == 0) ? (value.x) : (value.x - Offset.x), (Offset.y == 0) ? (value.y) : (value.y - Offset.y)));
			var OffsetA:Point = DragItem.globalToLocal(new Point(OffsetB.x, OffsetB.y));
			DragRect = new Rectangle(OffsetA.x, OffsetA.y, value.width, value.height);
		}
		
		public function get DragTarget():Array
		{
			return Target;
		}
		
		public function set DragTarget(value:Array):void
		{
			Target = value;
		}
		
		public function get DragItem():MovieClip
		{
			return ITEM;
		}
		
		public function set DragItem(value:MovieClip):void
		{
			ITEM = value;
		}
		
		public function get DragItemXY():Point
		{
			return TempXY;
		}
		
		public function set DragItemXY(value:Point):void
		{
			TempXY = value;
		}
		
		/*
		 * Private
		 * */
		private function ResetChild(item:MovieClip):void
		{
			item.parent.addChild(item);
		}
		
		/*
		 * Event
		 * */
		private function ItemSelectMouseIn(e:MouseEvent = null):void
		{
			if (TempItem == null)
				return;
			var item:MovieClip = TempItem;
			ItemSelected = e.currentTarget;
			item.stopDrag();
			ReleaseItemButton(item);
			TempItem = null;
			ItemSelected = null;
		}
		
		private function ItemSelectDeleteClick(e:MouseEvent):void
		{
		
		}
		
		private function ItemBarMouseOut(e:MouseEvent):void
		{
			if (TempItem != null)
			{
				var item:MovieClip = TempItem;
				item.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP));
			}
		}
		
		private function ItemMouseIn(e:MouseEvent):void
		{
			var item:MovieClip = e.currentTarget.getChildAt(2) as MovieClip;
			item.Text.visible = true;
		}
		
		private function ItemMouseOut(e:MouseEvent):void
		{
			var item:MovieClip = e.currentTarget.getChildAt(2) as MovieClip;
			item.Text.visible = false;
			var touch:* = TouchTest(item);
			
			item.x = item.tempxy.x;
			item.y = item.tempxy.y;
			item.stopDrag();
			TempItem = null;
		
		}
		
		private function ItemMouseUp(e:MouseEvent):void
		{
			var item:MovieClip = e.currentTarget.getChildAt(2) as MovieClip;
			//var touch:*= TouchTest(item);
			if (touch is Cells)
			{
				touch.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER));
				return;
			}
			item.x = item.tempxy.x;
			item.y = item.tempxy.y;
			item.stopDrag();
			TempItem = null;
		}
		
		private function ItemMouseDown(e:MouseEvent):void
		{
			ResetChild(e.currentTarget);
			if (!(e.currentTarget is DragBase))
				return;
			try
			{
				var target:DragBase = (e.currentTarget as DragBase);
				var item:MovieClip = target.DragItem;
				
				item.x = target.DragItemXY.x;
				item.y = target.DragItemXY.y;
				
				item.startDrag(false, target.DragRange);
				target.TempItem = item;
			}
			catch (error:Error)
			{
				
			}
		}
	}

}