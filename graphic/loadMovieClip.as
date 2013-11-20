package graphic {
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLRequest;
	//[Event(name="complete", type="graphic.loadProgress")]
	/**
	 * ...
	 * @author locke
	 */
	public class loadMovieClip extends MovieClip {
		private var MovieLoader:Loader = new Loader();
		private var tempMovie:MovieClip;
		private var loaded:Boolean = false, COMPLETE:Boolean = false;
		private var loading_step:int = 0, _total:int = 0;
		private var MovieClipArray:Array = new Array();
		private var UrlArray:Array = new Array();
		private var NameArray:Array = new Array();
		private var Url:URLRequest = new URLRequest();
		public function loadMovieClip(){
			//addEventListener(Event.ENTER_FRAME, init);
		}

		public function start():void {
			_total = loading_step;
			loading_step = 0;
			addEventListener(Event.ENTER_FRAME, init);
		}

		public function add(url:URLRequest, name:String):void 
		{
			UrlArray[loading_step] = url;
			NameArray[loading_step] = name;
			loading_step++;
		}

		private function init(e:Event):void {
			if (loading_step < _total){
				if (Url != UrlArray[loading_step]){
					Url = UrlArray[loading_step];
					_loadMovieClip(Url);
					loaded = false;
				}
				if (loaded){
					MovieClipArray[loading_step] = tempMovie;
					//MovieClipArray[loading_step].name = ;
					//addChild(MovieClipArray[loading_step]);
					loaded = false;
					loading_step++;
				}
			}else
			{
				COMPLETE = true;
				removeEventListener(Event.ENTER_FRAME, init);
			}
		}

		public function _loadMovieClip(url:URLRequest):void {
			MovieLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
			MovieLoader.load(url);
		}

		private function loadComplete(e:Event):void {
			MovieLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadComplete);
			tempMovie = new MovieClip();
			tempMovie = MovieLoader.content as MovieClip;
			MovieLoader.unload();
			loaded = true;
			
			//loading_step++;
		}
		public function isComplete():Boolean
		{
			return COMPLETE;
		}
		public function getMovieByIndex(index:int):MovieClip
		{
			if (COMPLETE)
			{
				return MovieClipArray[index] as MovieClip;
			}else
				return null;
		}

	}

}