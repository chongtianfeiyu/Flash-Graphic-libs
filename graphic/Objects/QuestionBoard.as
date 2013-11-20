package graphic.Objects {
	import flash.display.MovieClip;
	import flash.filters.BevelFilter;
	import flash.filters.BlurFilter;
	import graphic.Event.Progress;
	import graphic.Mouse;
	import graphic.phpReader;
	import graphic.utils.Type;
	import graphic.utils.Modifiers;
	import graphic.Converter;
	import Probability.utils.Random;

	/**
	 * ...
	 * for InputInterface.swc
	 * @author locke
	 */
	public class QuestionBoard extends MovieClip {
		private var reader:phpReader = new phpReader();
		private var _interface:Board = new Board();
		private var totalQuestion:int, thisQuestion:int;
		private var index:int;
		private var question:Array;

		public function QuestionBoard(){
			//load(url, start, Amount);
			addChild(_interface);
		}

		public function load(url:String, start:int = 0, Amount:int = 10):void {
			index = start;
			totalQuestion = Amount;
			reader.addEventListener(Progress.COMPLETE, complete);
			reader.beginload(url);
		}

		public function set text(value:String):void {
			_interface.question.text = value;
		}

		public function get text():String {
			return _interface.question.text;
		}

		public function set Question(value:int):void {
			thisQuestion = value % question.length;
			text = question[thisQuestion]['Question'];
		}

		public function get Answer():String {
			return question[thisQuestion]['Answer'];
		}

		public function rest():void {
			
			_interface.ANSWER.text = "";
			Question = index;

		}

		public function nextQuestion():void {
			if (question == null)
				return;
			Question = ( index +(thisQuestion + 1) )% totalQuestion;
			_interface.ANSWER.text = "";
			//thisQuestion = (index + value) % question.length;
			//text = question[thisQuestion]['question'];
		}

		public function answerOutput(value:String):void {
			_interface.ANSWER.text = "答案：" + value;
		}

		public function answerFault():void {
			_interface.ANSWER.text = "請再仔細想想";
		}

		public function inputFault():void {

			_interface.ANSWER.text = "請輸入數字";
		}

		public function get Data():* {
			return question[thisQuestion];
		}

		public function nextQueue():void {
			index = (index + totalQuestion) % question.length;
			Question = index;
		}


		private function complete(e:Progress):void {
			reader.removeEventListener(Progress.COMPLETE, complete);
			var temp:Array = reader.decode_data;
			var array:Array = [];
			array = Random.SORT_RANDOM(temp.length);
			question = [];
			for (var i:int = 0; i < temp.length; i++)
				question.push(temp[array[i]]);
			index = 0;
			Question = 0;
		}
	}

}