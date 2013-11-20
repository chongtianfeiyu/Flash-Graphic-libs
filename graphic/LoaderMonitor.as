package graphic {
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;

	public class LoaderMonitor {
		public function LoaderMonitor(aStage:Stage, aLoader:URLLoader){
			theStage = aStage;
//開啟連線時
			aLoader.addEventListener(Event.OPEN, function(e:Event):void {
					buildTextField(e.target, "OPEN, receive by " + e.target.dataFormat);
				});
//讀取進行時
			aLoader.addEventListener(ProgressEvent.PROGRESS, function(e:ProgressEvent):void {
					buildTextField(e.target, "bytesLoaded:" + String(e.bytesLoaded));
				});
//讀取完成時
			aLoader.addEventListener(Event.COMPLETE, function(e:Event):void {
					buildTextField(e.target, "complete:data=" + e.target.data);
					//for (var i:Number = 0; e.target.data["data" + i]; i++){
						//buildTextField(e.target, "complete:data" + i + "=" + e.target.data["data" + i]); //應該是VARIABLES的接收方式允許如此使用
					//}
				});
//收到連線狀態時
			aLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, function(e:HTTPStatusEvent):void {
					buildTextField(e.target, "HTTP_STATUS:" + e.status);
				});
//發生安全錯誤時
			aLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, function(e:SecurityErrorEvent):void {
					buildTextField(e.target, "SECURITY_ERROR:" + e.text);
				});
//發生讀寫錯誤時
			aLoader.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent):void {
					buildTextField(e.target, "IO_ERROR:" + e.text);
				});
		}
//用創造文字欄位的方式來顯示訊息
	    private	static var theStage:Stage = null;
		private	static var count:Number = 0; //用來計算訊息的Y座標
		private	static var TEXT_HEIGHT:Number = 20;

		public static function buildTextField(aObj:Object, message:String):void {
			var textField:TextField = new TextField();
			textField.x = 0;
			textField.y = count * TEXT_HEIGHT;
			textField.border = true;
			textField.background = true;
			textField.autoSize = TextFieldAutoSize.LEFT;
			//textField.height = TEXT_HEIGHT;
			textField.text = aObj + ":" + message;
			//theStage.addChild(textField);
			count++;
		}
	}
}