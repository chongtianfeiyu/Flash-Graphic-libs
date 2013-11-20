package graphic.Event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Locke
	 */
	
	public class DragEvent extends Event 
	{
		public static const TOUCH : String = "touch";
		public static const HIT : String = "hit";
		public static const DRAGING : String = "drag";
		public static const DRAG_STOP : String = "drag_stop";
		public function DragEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new DragEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("DragEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}