package graphic 
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.System;
	import graphic.Converter;
	/**
	 * ...
	 * @author locke
	 */
	public class HtmlSplitter extends URLLoader
	{
		private var uReq:URLRequest;
		public function HtmlSplitter() 
		{
			super(uReq);
			addEventListener(Event.COMPLETE, searchStart);
		}
		private function searchStart(e:Event):void
		{
			//var i:String;
			//var Txt:URLVariables = new URLVariables(uLoader.data);
			//var a:String = data;
			//var search:Array = ['<td bgcolor=',"'edeccf'",'><a href=','"SIMDATA.PHP?'];
			//var c:String = search[0]+search[1]+search[2]+search[3];
			//var b:int = a.search(c);
			//var d:Array = a.split(c);
			//search = ["</td><td width=", "'14%'", ""];
			//c = search[0] + search[1] + search[2];
			//var f:Array = a.split(c);
			//var obj:*= {書名:searchWords(d[1],"=",'"'),作者:searchWords(d[2],"=",'"'),出版社:searchWords(d[3],"=",'"'),分類號:searchWords(d[6],"=",'"'),ISBN:searchWords(d[8],"=",'"'),登陸號:searchWords(f[1], ">", '<')};
			//trace(obj);
			//var d:String = a[b];
			//trace(d[2]);
			//System.gc();
		}
		private function searchWords(str:String,strat:String,stop:String):String
		{
			var arr:Array = Converter.String2Array(str);
			return Converter.Array2String(arr, strat, stop);
		}
		
	}

}