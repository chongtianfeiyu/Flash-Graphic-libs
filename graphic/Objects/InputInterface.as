package graphic.Objects {
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.filters.BevelFilter;
	import flash.filters.BlurFilter;
	import flash.utils.Timer;
	import graphic.Mouse;
	import graphic.phpReader;
	import graphic.utils.Type;
	import graphic.utils.Modifiers;
	import graphic.Converter;
	import flash.events.KeyboardEvent;
	import caurina.transitions.Tweener;

	/**
	 * ...
	 * for InputInterface.swc
	 * @author locke
	 */
	public class InputInterface extends MovieClip {
		private var COVER:Cover;
		private var Questions:QuestionBoard;
		private var input:Input;
		private var keyboard:NumberKeyboard;
		private var target:String;
		private var time:Timer;
		private var allowFault:int = 0;
		private var fault:int = 0;
		private var faultCounter:int = 0;
		private var TotalCounter:int = 0;
		private var totalTime:int;
		private var Amount:int;
		private var Fail:int;
		private var Pass:int;
		private var Score:int;
		private var BOUNS:Array = [1, 1, 1, 2, 2, 2, 3, 3, 3, 10, 10, 15, 15, 20, 20, 25, 25, 50, 75, 100,100];
		public var Combo:int = 0;
		private var Bouns:int = 0;
		public var OPEN:Function;
		public var CLOSE:Function;
		public var TIMER:TimeCom = new TimeCom();
		public var Qid:String;
		private var php:phpReader ;
		//private var OK:OK_btn = new OK_btn();
		//private var calc:key;
		public function InputInterface(){

			COVER = new Cover();
			Questions = new QuestionBoard();
			input = new Input(0, 0, checkAnswer);
			keyboard = new NumberKeyboard(getKeyboardMessage, input);
			keyboard.width *= 1.5;
			keyboard.height *= 1.5;
			addChild(COVER);
			addChild(keyboard);
			addChild(Questions);
			addChild(input);
			//addChild(OK);
			time = new Timer(0);
			//time.start();
			time.addEventListener(TimerEvent.TIMER, onTimer);
			//Mouse.add(OK, Type.CLICK, {Modifiers:{mod:Modifiers.CUSTOM,data:checkAnswer } } );
			//keyboard = new NumberKeyboard(w,h);
		}

		public function STOP():void {
			time.stop();
			Questions.rest();
		}
		//public function get Star():int
		//{
			//Fail
		//}
		public function get isOver():Boolean {
			
			return (TotalCounter>=Amount&&PASS)||(FAIL);
		}

		public function get PASS():Boolean {
			return (TotalCounter - faultCounter > Pass);
		}
		public function set FAIL(value:Boolean):void
		{
			if(value)
				faultCounter = Fail;
		}
		public function get FAIL():Boolean {
			if ((faultCounter >= Fail))
				trace("QOVER");
			return (faultCounter >= Fail);
		}
		public function get fail_persent():Number {
			
			return ((Fail-faultCounter) / Fail);
		}
		public function get finish_persent():Number {
			
			return ((TotalCounter) / Amount);
		}
		public function load(url:String, Setting:* = null):void {
			faultCounter = 0;
			TotalCounter = 0;
			fault = 0;
			Combo = 0;
			if (Setting != null){
				if (Qid == Setting.Tittle){
					Questions.nextQueue();
					return;
				}
				Score = Setting.Score;
				totalTime = Setting.Time;
				allowFault = Setting.Fault;
				Pass = Setting.Pass;
				Fail = Setting.Fail;
				Amount = Setting.Total;
				Qid = Setting.Tittle;
			}

			Questions.load(url, 0, Amount);
		}

		public function reset():void {
			Combo = 0;
			faultCounter = 0;
			TotalCounter = 0;
			fault = 0;
			Questions.nextQueue();
		}

		public function setBoard(x:Number, y:Number):void {
			
			TIMER.time = totalTime;
			TIMER.time_bar = 1;
			COVER.x = x;
			COVER.y = y;
			
			Questions.x = x - Questions.width / 2;
			Questions.y = y - (Questions.height / 2) - 24;
			input.x = Questions.x + Questions.width - input.width;
			input.y = Questions.y + Questions.height;
			input.text = "";
			
			keyboard.x = input.x - keyboard.width;
			keyboard.y = input.y;
			time.reset();
			time.start();
			this.addEventListener(KeyboardEvent.KEY_UP, Keyboard);
		}
		public function Focus():void
		{
			this.stage.focus = input.Focus;
		}

		private function onTimer(e:TimerEvent):void {
			var _time:Number = (time.currentCount / 60);
			if (TIMER != null){
				if (_time * 10 % 10 == 0){
					TIMER.time_bar = 1 - _time / totalTime;
					//trace(_time);
				}
				if (totalTime - _time > 0){
					TIMER.time = totalTime - _time;

				} else {
					trace("over");
					time.stop();
					checkAnswer();
				}
			}
		}

		private function getKeyboardMessage():void {
			input.text = parseInt(keyboard.text).toString();
			Focus();
		}

		private function Keyboard(e:KeyboardEvent = null):void {
			if (e.keyCode == 13)
				checkAnswer();
		}

		private function checkAnswer(e:*=null):void {
			if (Tweener.isTweening(this))
				return;
			input.text = parseInt(input.text).toString();
			if (input.text == "NaN")
			{
				Questions.inputFault();
				input.text = "";
				return;
			}
			Questions.Data['isCorrect'] = input.text == Questions.Answer;
			Questions.Data['PlayerAnswer'] = input.text=="NaN"?"-1":input.text;
			Questions.Data['Time'] = Math.round(((time.currentCount) / 60)*1000)*0.001;
			trace(Questions.Data['Time'] + "," + Questions.Data['PlayerAnswer'] + "," + Questions.Data['isCorrect']);
			php= new phpReader();
			php.beginload("insert_data.php",{quest:Questions.Data['Question'],id:1,qid:Questions.Data['Questionid'],uid:Questions.Data['Unitid'],ans:Questions.Data['PlayerAnswer'],fault:Questions.Data['isCorrect']?1:0,time:Questions.Data['Time']});
			if (input.text == Questions.Answer) {
				Combo = Combo + 1;
				Combo = Combo > BOUNS.length - 1?BOUNS.length - 1:Combo;
				input.text = keyboard.text = "";
				showNext();
				var bonus:int = (Score * BOUNS[int(Combo * (BOUNS.length / Amount) - 1)]);
				var getScore:int = (totalTime - (time.currentCount / 60) + 1) / totalTime * bonus+bonus;
				CLOSE(2, getScore);
				this.removeEventListener(KeyboardEvent.KEY_UP, Keyboard);
				trace(Combo+"   :"+Combo*(BOUNS.length/Amount));
			} else {
				input.text = keyboard.text = "";
				if(Questions.Data['Time']!=totalTime)
					if (fault < allowFault) {
						Combo = 0;
						Questions.answerFault();
						Focus();
						fault++;
						return;
					}
				Combo = 0;
				Questions.answerOutput(Questions.Answer);
				Tweener.removeTweens(this);
				Tweener.addTween(this, {time: 3, onComplete: wait});
			}
			//input.text = keyboard.text = "";
			time.stop();
			//time.reset();
		}

		private function wait():void {
			Tweener.removeTweens(this);

			faultCounter++;
			//Questions.answerOutput("");
			showNext();
			CLOSE(3, 100);
		}

		public function showNext():void {
			
			TotalCounter++;
			trace(TotalCounter);
			fault = 0;
			Questions.nextQuestion();

			//time.start();
		}
	}

}