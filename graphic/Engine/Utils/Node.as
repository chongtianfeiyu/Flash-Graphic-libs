package graphic.Engine.Utils
{
	/**
	 * Represents a specific node evaluated as part of a pathfinding algorithm.
	 */
	public dynamic class Node
	{
		public var x:int;
		public var y:int;
		public var f:Number;
		public var g:Number;
		public var h:Number;
		public var walkable:Boolean = true;
		public var parent:Node;
		public var costMultiplier:Number = 1.0;
		private var _gird:Grid;
		private var _obj:IsoObject;
		private var _tile:DrawnIsoTile;
		public function Node(x:int, y:int)
		{
			this.x = x;
			this.y = y;
		}
		public function toString():String
		{
			return "X：" + x + " , Y：" + y;
		}
		public function get UP():Node
		{
			if (y-1 >= 0)
				return _gird.getNode(x, y - 1);
			else return null;
		}
		public function get DOWN():Node
		{
			if (y+1 < _gird.numRows)
				return _gird.getNode(x, y + 1);
			else return null;
		}
		public function get LEFT():Node
		{
			if (x-1 >= 0)
				return _gird.getNode(x-1, y);
			else return null;
		}
		public function get RIGHT():Node
		{
			if (x+1 < _gird.numCols)
				return _gird.getNode(x+1, y);
			else return null;
		}
		public function set g_parent(g:Grid):void
		{
			_gird = g;
		}
		public function get g_parent():Grid
		{
			return _gird;
		}
		public function set b_parent(b:*):void
		{
			_obj = b;
			if(_obj!=null&&_obj.node!=this)
				_obj.node = this;
		}
		public function get b_parent():*
		{
			return _obj;
		}
		public function set tile(b:DrawnIsoTile):void
		{
			_tile = b;
		}
		public function get tile():DrawnIsoTile
		{
			return _tile;
		}
	}
}