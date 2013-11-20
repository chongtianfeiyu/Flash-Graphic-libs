package graphic.utils 
{
	import graphic.utils.Formula;
	/**
	 * ...
	 * @author locke
	 */
	public class Calculation 
	{
		private static var stack:Array = [];
		private static var Max:Number = 0;
		private static var Min:Number = 0;
		public function Calculation() 
		{
			
		}
		public static function set MAX(value:Number):void
		{
			Max = value;
		}
		public static function set MIN(value:Number):void
		{
			Min = value;
		}
		public static function get Percent():Number
		{
			return Formula.Percent(Calculation.calc,Calculation.Max);
		}
		public static function get calc():Number
		{
			var calculate:Number = 0;
			for (var i:int = 0; i < stack.length; i++)
				calculate += stack[i];
			return calculate;
		}
		public static function push(value:Number):void
		{
			stack.push(value);
		}
		public static function clear():void
		{
			stack = [];
		}
		
	}

}