package graphic.Engine.Utils
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;

	public class IsoWorld extends MovieClip
	{
		//namespace AS3;
		
		private var _floor:Sprite;
		private var _floors:Array=[];
		private var _objects:Array=[];
		private var _items:Array = [];
		private var _index:Array = [];
		
		private var _world:Sprite;
		
		public function IsoWorld()
		{
			_floor = new Sprite();
			addChild(_floor);
			
			_world = new Sprite();
			addChild(_world);
			
			//_objects = new Array();
		}
		
		public function addChildToWorld(child:*):void
		{
			_world.addChild(child);
			if(child is DrawnIsoBox)
				_objects.push(child);
			if(child is GraphicIsoBox)
				_items.push(child);
			sort();
		}
		
		public function addChildToFloor(child:*):void
		{
			_floors.push(child);
			_floor.addChild(child);
		}
		public function removeChildToFloor(child:IsoObject):void
		{
			_floor.removeChild(child);
		}
		
		public function sort():void
		{
			var objects:Array = [];
			//erase();
			var i:int = 0;
			for ( i = 0; i < _objects.length; i++) {
				if(_objects[i].parent!=null)
					objects.push(_objects[i]);
			}
			for ( i = 0; i < _items.length; i++)
				if(_items[i].parent!=null)
					objects.push(_items[i]);
			objects.sortOn("depth", Array.NUMERIC);
			for( i = 0; i < objects.length; i++)
			{
				try{
					if(_world.numChildren!=i)
						_world.setChildIndex(objects[i], i);
				}catch (e:Error)
				{
					trace(e.message);
				}
			}
		}
		public function erase():void
		{
			for (var i:int = 0; i < _objects.length; i++) {
				if (_objects[i].node.type == "")
					releaseChild(_objects[i]);
			}
			
		}
		public function hasListener():Boolean
		{

			for(var i:int = 0; i < _objects.length; i++)
			{
				var obj:DrawnIsoBox = _objects[i];
				if(obj.hasEventListener(Event.ENTER_FRAME))
				{
					return true;
				}
			}
			return false;
		}
		public function releaseChild(obj:IsoObject):void
		{
			var index:int = _objects.indexOf(obj);
			if (index == -1)
				return;
			_objects.splice(index,1);
			//_objects.shift();
			_world.removeChild(obj);
		}
		public function releaseItem(obj:IsoObject):void
		{
			var index:int = _items.indexOf(obj);
			if (index == -1)
				return;
			_items.splice(index,1);
			//_objects.shift();
			_world.removeChild(obj);
		}
		public function get Childs():int
		{
			return _objects.length;
		}
		public function get lastChild():*
		{
			return _objects[_objects.length-1];
		}
		public function nextChild(obj:*):*
		{
			if (_objects.length == 0)
				return obj;
			var index:int = _objects.indexOf(obj);
			if (index == -1)
				index=0;
			return _objects[(index+1)%_objects.length];
		}
		public function preChild(obj:*):*
		{
			if (_objects.length == 0)
				return obj;
			var index:int = _objects.indexOf(obj);
			if (index == -1)
				index = 0;
			index = index - 1 < 0?_objects.length:index;
			return _objects[(index-1)%_objects.length];
		}
		public function getChildbyColor(value:*=null):Array
		{
			if (value == null)
				return _objects;
			var temp:Array = [];
			var i:int = 0;
			for ( i = 0; i < _objects.length; i++)
				if (_objects[i].color == value)
					temp.push(_objects[i]);
			return temp;
		}
	}
}