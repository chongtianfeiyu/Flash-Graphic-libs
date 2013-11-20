package graphic
{
	import com.adobe.serialization.json.*;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.net.*;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import graphic.Event.Progress;
	import flash.system.System;
	
	/**
	 * ...
	 * @author locke
	 * version 0.2a
	 * 		Update date : 2012/03/09
	 * 		Add			: Timeout,LoaderSchedule
	 */
	[Event(name="progress",type="graphic.Event.Progress")]
	[Event(name="complete",type="graphic.Event.Progress")]
	[Event(name="tryagian",type="graphic.Event.Progress")]
	[Event(name="timeout",type="graphic.Event.Progress")]
	
	public class phpReader extends EventDispatcher
	{
		public static const PROGRESS:String = "progress";
		public static const COMPLETE:String = "complete";
		public static const TIMEOUT:String = "timeout";
		public var READING:Boolean = false;
		public const DELAY:int = 5000;
		private var loader:URLLoader;
		private var timeout:Timer;
		private var Schedule:Array = [];
		private var date:Date = new Date();
		
		public function phpReader()
		{
			loader = new URLLoader();
		}
		
		public function get data():*
		{
			return loader.data;
		}
		
		public function get decode_data():*
		{
			if (loader.data == "Error!")
				return [];
			try
			{
				var temp:* = JSON.decode(loader.data);
			}
			catch (e:Error)
			{
				temp = loader.data;
			}
			return temp;
		}
		
		public function LoaderSchedule(schedule:Array, _timeout:int = 1000):void
		{
			Schedule = schedule;
			timeout = new Timer(_timeout);
		}
		public function StratSchedule():void
		{
			var url:*= Schedule.shift();
			beginload(url["url"],url["obj"]);
		}
		public function beginload(string:String, obj:Object = null):void
		{
			if (READING)
				return;
			
			System.gc();
			try
			{
				var nocache:String;
				var arr:Array = string.split("");
				
				date = new Date();
				
				if (Converter.seachString("?", arr) == arr.length)
					nocache = "?time=" + date.getTime();
				else
					nocache = "&time=" + date.getTime();
				READING = true;
				var header:URLRequestHeader = new URLRequestHeader("Cache-Control", "no-cache");
				var loadPHP:URLRequest = new URLRequest(string + nocache);
				trace(string + nocache);
				loadPHP.requestHeaders.push(header);
				loadPHP.method = URLRequestMethod.POST;
				if (obj != null)
				{
					var str:String = JSON.encode(obj);
					loadPHP.data = str;
					trace(str);
					loadPHP.contentType = "text/plain";
				}
				loader.addEventListener(IOErrorEvent.IO_ERROR, onIOERROR);
				loader.addEventListener(Event.COMPLETE, onComplete);
				loader.addEventListener(ProgressEvent.PROGRESS, onProgress);
				if (timeout == null)
				{
					timeout = new Timer(DELAY);
					
				}
				timeout.addEventListener(TimerEvent.TIMER, onTimer);
				loader.load(loadPHP);
				timeout.reset();
				timeout.start();
			}
			catch (e:Error)
			{
				
			}
		}
		private function removeAll():void
		{
			READING = false;
			loader.removeEventListener(IOErrorEvent.IO_ERROR, onIOERROR);
			loader.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			loader.removeEventListener(Event.COMPLETE, onComplete);
			loader.close();
			if(timeout!=null){
				timeout.removeEventListener(TimerEvent.TIMER, onTimer);
				timeout.stop();
				if (Schedule.length == 0)
					timeout = null;
			}
		}
		private function onTimer(e:TimerEvent):void
		{
			trace("Time out");
			removeAll();
			if (Schedule.length == 0) return;
			StratSchedule();
		}
		
		private function onIOERROR(e:IOErrorEvent):void
		{
			removeAll();
			trace("error");
			READING = false;
			dispatchEvent(new Progress(Progress.TRY_AGIAN));
		}
		
		private function onProgress(e:ProgressEvent):void
		{
			var _progress:Progress = new Progress(PROGRESS);
			_progress.loadbytes = e.bytesLoaded;
			_progress.loadpercent = Number(e.bytesTotal / e.bytesTotal);
			dispatchEvent(_progress);
		}
		
		private function onComplete(e:*):void
		{
			if (e is IOErrorEvent)
				trace("error");
			
			Schedule = [];
			removeAll();
			var _complete:Progress = new Progress(COMPLETE);
			dispatchEvent(_complete);
			
		}
	
	}

}