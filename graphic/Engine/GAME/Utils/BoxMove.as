package graphic.Engine.GAME.Utils {
	import flash.geom.Point;
	import graphic.Engine.Utils.DrawnIsoBox;
	import graphic.Engine.Utils.Grid;
	import graphic.Engine.Utils.IsoWorld;
	import graphic.Engine.Utils.Node;
	import graphic.Engine.Utils.Point3D;
	import graphic.utils.upgrade;

	/**
	 * ...
	 * @author locke
	 */
	public class BoxMove {

		public function BoxMove(){

		}

		public static function MoveToPath(world:IsoWorld, box:DrawnIsoBox, grid:Grid, path:Array, cellSize:int, index:int):int {
			var target:Point3D = new Point3D(path[index].x * cellSize, path[index].y * cellSize);
			var dx:Number = target.x - box.x;
			var dy:Number = target.y - box.z;
			var dist:Number = Math.sqrt(dx * dx + dy * dy);
			var start_xpos:int;
			var start_ypos:int;
			if (dist < 1){
				index++;
				if (index >= path.length){
					box.position = BoxMove.Calc_Rect(box.position, cellSize);
					start_xpos = Math.floor(box.x / (cellSize));
					start_ypos = Math.floor(box.z / (cellSize));
					grid.setWalkable(start_xpos, start_ypos, false);
					box.node.type = "null";
					box.node = grid.getNode(start_xpos, start_ypos);
					box.node.type = box.color == 0xff0000 ? 'red' : 'black';
					index = -1;
				}
			} else {
				
				box.x += dx * (.6);
				box.z += dy * (.6);
				start_xpos = Math.floor(box.x / (cellSize) + .5);
				start_ypos = Math.floor(box.z / (cellSize) + .5);
				var node:Node = grid.getNode(start_xpos, start_ypos);
				var hasBox:Boolean = (node.UP != null && node.UP.b_parent != null) || (node.DOWN != null && node.DOWN.b_parent != null) || (node.RIGHT != null && node.RIGHT.b_parent != null) || (node.LEFT != null && node.LEFT.b_parent != null);

				if (hasBox)
					world.sort();
				box.shadow.show();
					//dx = target.x - box.x;
					//dy = target.y - box.z;
					//if (Math.sqrt(dx * dx + dy * dy))
					//	world.sort();
			}
			return index;
		}

		public static function JumpToPath(world:IsoWorld, box:DrawnIsoBox, grid:Grid, path:Point3D, cellSize:int, index:int):int {
			var ClickPosition:Point3D = BoxMove.Calc_Rect(path, cellSize);
			box.x -= (box.x - ClickPosition.x) / 10;
			box.z -= (box.z - ClickPosition.z) / 10;
			var start_xpos:int = Math.floor(box.x / (cellSize) + .5);
			var start_ypos:int = Math.floor(box.z / (cellSize) + .5);
			var node:Node = grid.getNode(start_xpos, start_ypos);
			var hasBox:Boolean = (node.UP != null && node.UP.b_parent != null) || (node.DOWN != null && node.DOWN.b_parent != null) || (node.RIGHT != null && node.RIGHT.b_parent != null) || (node.LEFT != null && node.LEFT.b_parent != null);
			if (box.y < cellSize)
				if (hasBox)
					world.sort();
			if (box.vy != 0){
				upgrade.gravity({OBJECT: box, TARGET_1: 'vy', TARGET_2: 'y'}, 4, 0.85, 0.9);
				box.shadow.show();
			}
			if ((Math.abs((box.x - ClickPosition.x) / 10) < 0.1 && Math.abs((box.z - ClickPosition.z) / 10) < 0.1)){
				box.position = BoxMove.Calc_Rect(box.position, cellSize);
				start_xpos = Math.floor(box.x / (cellSize));
				start_ypos = Math.floor(box.z / (cellSize));
				grid.setWalkable(start_xpos, start_ypos, false);
				box.node.type = "null";
				box.node = grid.getNode(start_xpos, start_ypos);
				box.node.type = box.color == 0xff0000 ? 'red' : 'black';
				box.shadow.show();
				//world.sort();
				trace(box.node.type);
				trace(box.node.toString());
				return -1;
			} else {
				return 10;
			}
		}

		public static function Calc_Rect(pos:Point3D, cellSize:int):Point3D {
			return new Point3D(Math.round(pos.x / cellSize) * cellSize, Math.round(pos.y / cellSize) * cellSize, Math.round(pos.z / cellSize) * cellSize);
		}

	}

}