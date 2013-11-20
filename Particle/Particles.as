package Particle {

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GraphicsBitmapFill;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import Particle.STATUS.PARTICLE_STATUS;

	/**
	 * ...
	 * @author locke
	 */
	public class Particles extends MovieClip {

		private var bit:Bitmap = new Bitmap();
		private var k:Number = 0.6, g:Number = 2;
		private var DELAY:int = 0;
		private var NUMBER:int = 3;
		private var NUMBERXY:Number = 0, setNUMBER:int = 0;
		private var _member:PARTICLE_STATUS = new PARTICLE_STATUS(0, 0);
		private var Member:Array = new Array(NUMBER);
		private var Sprite_Member:Array = new Array(NUMBER);
		private var position:Point = new Point();
		private var LIFE:int = 256;
		private var time:Timer;
		public function Particles(_bitmap:Bitmap, _number:int = 0, _speed:Number = 0, delay:int = 1000) {
			time = new Timer(delay);
			position = new Point(0, 0);
			bit = _bitmap;
			NUMBER = _number;
			k = _speed;
			NUMBERXY = LIFE;
			init();
			time.addEventListener(TimerEvent.TIMER, Shift);
		}

		private function init():void {
			var g:Boolean = Math.random() * 2 > 1;
			var newSprite:Sprite = new Sprite();
			for (var i:int; i < NUMBER; i++){
				var theta:Number = ((i / NUMBER) * 360.0) * Math.PI / 180.0;
				var k:int = (Math.random() * 15);
				_member = new PARTICLE_STATUS((Math.sin(theta) * 0.5) - 0.25, (Math.cos(theta) * 0.5) - 0.25, (Math.random() * 0.1) - 0.05);
				_member._end.x = (Math.random() * 2) - 1;
				_member._end.y = (Math.random() * 2) - 1;
				_member._end.z = (Math.random() * 2);
				Member[i] = _member;
				newSprite = new Sprite();
				newSprite.alpha = 1;
				
				newSprite.graphics.beginBitmapFill(bit.bitmapData);
				newSprite.graphics.drawRect(0, 0, bit.width, bit.height);
				newSprite.graphics.endFill();
				newSprite.x = -newSprite.width / 2;
				newSprite.y = -newSprite.height / 2;
				var temp:Sprite = new Sprite()
				temp.addChild(newSprite);
				Sprite_Member[i] = temp;
				temp.alpha = 0;
				//newSprite.rotation = Math.random()*360;
				addChild(Sprite_Member[i]);
			}
			time.start();
		}

		public function release():void {
			//trace(NUMBERXY);
			NUMBERXY = 10;
			g = 3;
			time.reset();
			
		}
		public function start():void
		{
			release();
			time.start();
		}
		public function get running():Boolean
		{
			return time.running;
		}
		private function Shift(e:TimerEvent):void {
			//if (++DELAY % 2 == 0) {
				DELAY = 0;
				if (NUMBERXY < LIFE){
					NUMBERXY += g;
					g += k;
					g = g > 12 ? 12 : g;

					for (var i:int; i < NUMBER; i++){
						var j:int = (NUMBERXY + i) % NUMBER;
						var l:Number = NUMBERXY / LIFE; //Member[i]._lefttime;
						//Member[i]._lefttime = Member[i]._lefttime < 1 ? Member[i]._lefttime + 0.04 : 0;
						Member[i].x = ((Member[i]._end.x - Member[i]._start.x)) * l;
						Member[i].y = ((Member[i]._end.y - Member[i]._start.y)) * l;
						Member[i].z = ((Member[i]._end.z - Member[i]._start.z)) * l;
						Sprite_Member[i].alpha = 0.8 - (l);
						Sprite_Member[i].x = position.x /*(400+Math.sin(theta)*54)*/ + Member[i].x * (64);
						Sprite_Member[i].y = position.y /*(300+Math.cos(theta)*54)*/ + Member[i].y * (64);
						Sprite_Member[i].z = 0 + /*(300+Math.cos(theta)*54)*/ Member[i].z * -64;
					}
				}else 
				{
					time.stop();
				}
			//}
		}

		private function Shift_sinRoute(e:Event):void {

			NUMBERXY += k;
			k = (k > 0 && NUMBERXY > 360) || (k < 0 && NUMBERXY <= 1) ? -k : k;
			var theta:Number = setNUMBER * Math.PI / 180.0;
			for (var i:int; i < NUMBER; i++){
				var j:int = (NUMBERXY + Math.random() * NUMBER) % NUMBER; //(setNUMBER+i)%NUMBER;
				var l:Number = (NUMBERXY + i) % NUMBER / NUMBER + 0.2;
				Member[i].x = ((Member[i]._end.x - Member[i]._start.x)) * l;
				Member[i].y = ((Member[i]._end.y - Member[i]._start.y)) * l;
				
				Member[i].z = ((Member[i]._end.z - Member[i]._start.z)) * l;
				Sprite_Member[i].alpha = 1 - l;
				Sprite_Member[i].x = position.x /*(400+Math.sin(theta)*54)*/ + Member[i].x * (256);
				Sprite_Member[i].y = position.y /*(300+Math.cos(theta)*54)*/ + Member[i].y * (256);
				Sprite_Member[i].z = 16 /*(300+Math.cos(theta)*54)*/ + Member[i].z * (l * 96);
			}
		}

	}

}