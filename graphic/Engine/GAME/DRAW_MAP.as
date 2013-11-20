package graphic.Engine.GAME {
	import flash.display.*;
	import graphic.Engine.Utils.*;
	import graphic.Mouse;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Locke locke12456@gmail.com
	 */
	public dynamic class DRAW_MAP {

		public function DRAW_MAP(){

		}

		public static function buildMap(world:IsoWorld, grid:Grid,map_size:int,cellSize:int=20,onBoxClick:Function=null):void{
			var node:Node;
			var i:int, j:int;
			for (i = 0; i < map_size; i++){
				for (j = 0; j < map_size; j++) {
					node = grid.getNode(i, j);
					var tile:DrawnIsoTile = new DrawnIsoTile(cellSize, 0xcc6600, 0);
					var tempTile:DrawnIsoTile = new DrawnIsoTile(cellSize, 0x666666, 0);
					tile.addChild(tempTile);
					tile.position = new Point3D(i * cellSize, 0, j * cellSize);
					world.addChildToFloor(tile);
					node.tile = tempTile;
					tempTile.alpha = 0;
					//Mouse.add(tile, MouseEvent.MOUSE_OVER, {alpha: 0.5});
					//Mouse.add(tile, MouseEvent.MOUSE_OUT, {alpha: 1});
					
					node.b_parent = null;
					if (!node.walkable){
						var color:uint = node.type == 'red' ? 0xff0000 : 0x555555;
						var tempbox:DrawnIsoBox = CreatBoxTo(node, color,cellSize,onBoxClick);
						world.addChildToWorld(tempbox);
					}
				}
			}
		}
		public static function bulidGrid(grid:Grid,Map:Array, map_size:int):void
		{
			//grid = new Grid(map_size, map_size);
			var node:Node;
			for (var i:int = 1; i < Map.length; i++){
				node = grid.getNode(Map[i].x, Map[i].y);
				node.walkable = false;
				node.type = Map[i].type;
			}
		}
		public static function CreatBoxTo(node:Node, color:uint,cellSize:int,onBoxClick:Function=null ,bit:Bitmap = null):DrawnIsoBox {
			var tempbox:DrawnIsoBox = new DrawnIsoBox(cellSize, color, cellSize, bit);
			node.walkable = false;
			tempbox.node = node;
			tempbox.node.b_parent = tempbox;
			tempbox.node.tile.alpha = 0;
			tempbox.position = new Point3D(node.x * cellSize, 0, node.y * cellSize);
			Mouse.add(tempbox, MouseEvent.MOUSE_OVER, {alpha: 0.5});
			Mouse.add(tempbox, MouseEvent.MOUSE_OUT, { alpha: 1 } );
			if(onBoxClick!=null)
				tempbox.addEventListener(MouseEvent.CLICK, onBoxClick);
			
			return tempbox;
		}
		public static function draw(Map:Array, map_size:int):IsoWorld
		{
			var tempWorld:IsoWorld = new IsoWorld();
			var grid:Grid = new Grid(map_size, map_size);
			bulidGrid(grid, Map, map_size);
			buildMap(tempWorld, grid, map_size);
			return tempWorld;
		}
	}

}