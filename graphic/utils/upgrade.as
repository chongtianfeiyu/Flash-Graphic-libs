package graphic.utils {
	import flash.geom.Rectangle;
	import caurina.transitions.Tweener;

	/**
	 * ...
	 * @author locke
	 */
	public class upgrade {
		//public static const Upgrade:Function = UpgradeAll;

		public static function UpgradeAll(def:*, obj:*):* {
			var str:String;
			for (str in obj){
				def[str] = obj[str];
			}
			return def;
		}

		public static function Upgrade(def:*, obj:*, filter:String):* {
			var str:String;
			for (str in obj){
				if (filter != null){
					if (str != filter)
						def[str] = obj[str];
				}
			}
			return def;
		}
		public static function gravity(obj:*,g:Number=0,bounce:Number=0,friction:Number=0):void
		{
			//trace(obj['OBJECT'][obj['TARGET_1']]);
			obj['OBJECT'][obj['TARGET_1']] += g;
			//box.x += box.vx;
			obj['OBJECT'][obj['TARGET_2']] += obj['OBJECT'][obj['TARGET_1']];
			if (obj['OBJECT'][obj['TARGET_2']] > 0){
				obj['OBJECT'][obj['TARGET_2']] = 0;
				obj['OBJECT'][obj['TARGET_1']] *= -bounce;
				obj['OBJECT'][obj['TARGET_1']] = int(Math.abs(obj['OBJECT'][obj['TARGET_1']])) <= g?0:obj['OBJECT'][obj['TARGET_1']];
				friction = int(Math.abs(obj['OBJECT'][obj['TARGET_1']])) <=g?0:friction;
			}
			obj['OBJECT'][obj['TARGET_1']] *= friction;
			//trace(obj['OBJECT'][obj['TARGET_1']]);
			
		}
		public static function mc_sort(objs:Array, range:Rectangle,time:Number=1):void {
			var t_array:Array = [];
			var line:int = range.y;
			var start:int = 0;
			var this_height:int = range.height / objs[0]['height'];
			var this_width:int = (range.width / objs[0]['width']);
			this_width = this_width * objs[0]['width'] > range.width ? this_width - 1 : this_width;
			var total:int = objs.length;
			var limit:Number = Number(range.width - this_width * objs[0]['width']) / objs[0]['width'];
			//this_height = this_height < 1 || objs.length / this_width < 1 ? 1 : this_height;
			this_height = objs.length / this_width < 1 ? 1 : Number(objs.length / this_width + (1 + limit));
			//trace("h:" +( Number(objs.length / this_width + (1 + limit))-this_height) + " w:" + this_width * objs[0]['width']);
			for (var h:int = 0; h < this_height; h++){
				this_width = start + this_width < total ? this_width : total - start;
				//trace(this_width);
				for (var w:int = start; w < start + this_width; w++){
					t_array.push(objs[w]);
					objs[w]['line'] = line;
				}
				var i:int = _sort(t_array, range.width, line,time);
				//start = start + this_width;
				//if (i < t_array.length){
				//	start += this_width - 1;
				//} else {
				start = start + i;

				//if (start > total - start)
				//	break;
				//}
				line += objs[0]['height'] + objs[0]['height'] / 10;
				t_array = [];
			}
		}

		public static function _sort(objs:Array, this_width:int, line:int,_time:Number=1):* {
			if (objs.length == 0)
				return;
			var time:Number;
			var delay:Number;
			var _x:int;
			var start:int = 0;
			var bool:Boolean = objs[0]['x'] - (objs[0]['width'] - objs[0]['width'] / 10) > this_width / objs[0]['width'];
			if (!bool){
				start = objs.length - 1;

			}
			for (var i:int = start; i < objs.length; i++){
				//if(objs[i]['_stop']!=1)

				if (bool){
					//objs[i]['y'] = objs[i]['line'];
					if (i == 0){
						var tar:int = (this_width / 2) - (objs[i]['width']) / 2;
						_x = objs[i]['x'] > tar ? tar : (this_width - objs.length * (objs[i]['width'])) / 2 - objs[i]['width'] / 10;
						if (_x < 0)
							_x = this_width / objs[0]['width']; //objs[0]['width'] / 2+objs[i]['width'] / 10;
						//trace(_x + "      " + tar + " line:" + line);
					}
					//delay = i + 1 < objs.length ? 0.5 + (objs.length - i) / objs.length : 1;
					time = i + 1 < objs.length ? 1+(objs.length - i) / objs.length : 1;
					delay = (objs.length - i) / objs.length;
					Tweener.addTween(objs[i], {x: _x,y:objs[i]['line'], time: time*_time, delay: delay*_time});
					_x += objs[i]['width'] + objs[i]['width'] / 10;
					objs[i]['_stop'] = 0;
					//trace(time);
					if (i == objs.length - 1)
						return objs.length;
				} else {
					_x = objs[i - 1]['x'] + objs[i]['width'] + objs[i]['width'] / 10;
					if (_x + objs[i]['width'] < this_width && objs[i]['_stop'] == 0){
						objs[i]['_stop'] = 1;
						Tweener.addTween(objs[i], {x: _x, time: 2});
						return objs.length;
					} else {
						//if (objs[i]['_stop'] == 0){
						objs[i]['_stop'] = 1;
						return objs.length - 1;
							//}
					}
				}
			}
		}
	}

}