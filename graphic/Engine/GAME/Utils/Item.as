package graphic.Engine.GAME.Utils {

	/**
	 * ...
	 * @author locke
	 */
	public class Item {
		private var USING:String;
		private var _items:Object;
		private var _itemArray:Array;
		private var alwaysUsing:String;
		public function Item(item:* = null) {
			_itemArray = [];
			if (item != null)
				_items = item;
			else
				_items = {};
		}

		public function add(name:String, obj:*):void {
			_items[name] = obj;
			_items[name].id = _itemArray.length;
			_itemArray.push(_items[name]);
		}
		public function set ALWAYSUSING(value:String):void
		{
			alwaysUsing = value;
		}
		public function set SELECT(name:String):void {
			USING = name;
		}
		public function get SELECT():String {
			return USING;
		}
		public function get ITEM():* 
		{
			return _items[USING];
		}
		public function get ID():* 
		{
			return _items[USING].id;
		}
		public function getItemByID(value:int):*
		{
			return _itemArray[value];
		}
		public function getItemByName(value:String):*
		{
			return _items[value];
		}
	}

}