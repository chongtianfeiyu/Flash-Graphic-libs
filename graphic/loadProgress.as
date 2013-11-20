package graphic 
{
	import flash.events.ProgressEvent;
	
	/**
	 * ...
	 * @author locke
	 */
	public class loadProgress extends ProgressEvent 
	{
		public static const PROGRESS : String = "progress";
		public static const COMPLETE : String = "complete";
		public function loadProgress( name : String, bubbles:Boolean=true, cancelable:Boolean=false ){
			super(name, bubbles, cancelable);		
			this.name = name;
		}
		
	}

}