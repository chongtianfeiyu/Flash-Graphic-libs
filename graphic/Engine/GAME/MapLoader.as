package graphic.Engine.GAME 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import graphic.bulkLoader;
	import graphic.Event.Progress;
		/**
	 * ...
	 * @author Locke locke12456@gmail.com
	 */
	public class MapLoader extends EventDispatcher
	{
		private var load:bulkLoader;
		private var Xml:XML;
		private var Selected:String;
		private var index:int;
		private var map:*;
		private var ai:*;
		private var subject:*;
		public function MapLoader(url:URLRequest=null) 
		{
			load = new bulkLoader("readMap");
			if (url != null)
				loadMap(url);
		}
		public function loadMap(url:URLRequest):void {
			load.addXml(url, "text");
			load.start();
			load.addEventListener(Progress.COMPLETE, analyze);
		}
		public function set Stage(value:String):void
		{
			index = 0;
			Selected = value;
			map = Xml[value]['MAP'];
			//trace(Xml[value]['MAP']['List']['MAP'].length());
			ai = Xml[value]['AI'];
			if (Xml[value]['Subject'] == 'no')
				subject = 'no';
			else
				subject = Xml[value]['Subject'][0];
		}
		public function set Index(value:int):void
		{
			index = value;
		}
		public function get Index():int
		{
			return index;
		}
		public function get Map():String
		{
			return String(map['Tittle']) + String(map['List']['MAP'][Index]);
		}
		public function get AI():String
		{
			if (ai['Tittle'] == "no") return ai['Tittle'];
			else return String(ai['Tittle']) + String(ai['List']['AI'][Index]);
		}
		public function get Subject():*
		{
			if (subject == "no")
				return 'no';
			var temp:XML = subject['List'][index];
			var obj:*= {Tittle:temp['Tittle'][0],Time:temp['TIME'][0],Total:temp['TOTAL'][0],Score:temp['SCORE'][0],Fail:temp['FAIL'][0],Fault:temp['FAULT'][0],Pass:temp['PASS'][0] };
			return obj;// + map['List']['MAP'][Index];
		}
		public function get Level():String
		{
			return Xml[Selected].level;
		}
		public function get Exp():String
		{
			return Xml[Selected].Exp;
		}
		public function get TeachMode():Boolean
		{
			return (Xml[Selected].TeachMode=="true");
		}
		public function length(table:String):int {
			return Xml[Selected][table]['List'][table].length();
			
		}

		public function Next():void {
			Index = (Index + 1) ;
		}
		private function analyze(e:Progress):void
		{
			Xml = load.Catch("text").content;
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
	}

}