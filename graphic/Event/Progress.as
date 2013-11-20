package graphic.Event 
{
	import flash.events.*;
	
	/**
	 * ...
	 * @author locke
	 */
	public class Progress extends ProgressEvent 
	{
		public static const PROGRESS : String = "progress";
		public static const COMPLETE : String = "complete";
		public static const TRY_AGIAN : String = "tryagian";
		public static const TIMEOUT:String = "timeout";
		public var loadbytes:Number = 0;
		public var loadpercent:Number = 0;
		public var name:String;
		public function Progress( name : String, bubbles:Boolean = true, cancelable:Boolean = false )
		{
			super(name, bubbles, cancelable);		
			this.name = name;
		}
		
	}

}