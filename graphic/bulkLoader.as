package graphic {
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	import flash.events.Event;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import graphic.Event.Progress;

	/**
	 * ...
	 * @author locke
	 */
	[Event(name = "progress", type = "graphic.Event.Progress")]
	[Event(name="complete", type="graphic.Event.Progress")]
	public class bulkLoader extends EventDispatcher{
		private var loader:BulkLoader;
		public static const PROGRESS : String = "progress";
		public static const COMPLETE : String = "complete";
		public function bulkLoader(id:String)
		{
			loader = new BulkLoader(id);
			
		}
		public function remove(key:String):Boolean {
			return loader.remove(key);
			
		}
		//public function PROGRESS(_progress:Function=null):void
		//{
			//progress = _progress;
		//}
		//public function COMPLETE(_complete:Function=null):void
		//{
			//complete = _complete;
		//}
		public function addJson(url:URLRequest, id:String = null):void {
			loader.add(url, {id: id, type: BulkLoader.TYPE_BINARY});
		}

		public function addMovieClip(url:URLRequest, id:String = null):void {
			loader.add(url, {id: id, type: BulkLoader.TYPE_MOVIECLIP});
		}

		public function addImage(url:URLRequest, id:String = null):void {
			loader.add(url, {id: id, type: BulkLoader.TYPE_IMAGE});
		}

		public function addSound(url:URLRequest, id:String = null):void {
			loader.add(url, {id: id, type: BulkLoader.TYPE_SOUND});
		}
		public function addXml(url:URLRequest, id:String = null):void {
			loader.add(url, {id: id, type: BulkLoader.TYPE_XML});
		}
		public function start():void {
			loader.addEventListener(BulkProgressEvent.PROGRESS, onProgress);
			loader.addEventListener(BulkProgressEvent.COMPLETE, onComplete);
			loader.start();
		}
		public function Catch(id:String):*
		{
			return loader.get(id);
		}
		public function CatchJson(id:String):String
		{
			return loader.getBinary(id).toString();
		}
		public function CatchMovieClip(id:String):MovieClip
		{
			return loader.getMovieClip(id);
		}
		public function CatchSound(id:String):Sound
		{
			return loader.getSound(id);
		}
		public function CatchImage(id:String):Bitmap
		{
			return loader.getBitmap(id);
		}
		private function onProgress(e:BulkProgressEvent):void {
			var _progress:Progress = new Progress(PROGRESS);
			_progress.loadbytes = e.bytesLoaded;
			_progress.loadpercent = e.weightPercent;
			dispatchEvent(_progress);
		}

		private function onComplete(e:BulkProgressEvent):void {
			loader.removeEventListener(BulkProgressEvent.PROGRESS, onProgress);
			loader.removeEventListener(BulkProgressEvent.COMPLETE, onComplete);
			var _complete:Progress = new Progress(COMPLETE);
			dispatchEvent(_complete);
		}
	}

}