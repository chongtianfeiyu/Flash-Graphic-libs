package graphic.Engine.GAME {

	import com.adobe.serialization.json.JSON;
	import flash.geom.Point;
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;
	import flash.filters.*;
	import graphic.Engine.Utils.*;
	import graphic.Converter;
	import graphic.Objects.InputInterface;
	import graphic.Mouse;
	import graphic.utils.*;
	import graphic.Objects.Window;
	import graphic.Engine.GAME.Utils.*;
	import graphic.Engine.GAME.Rule.*;
	import caurina.transitions.Tweener;
	import flash.system.System;
	import Particle.Particles;

	/**
	 * ...
	 * @author locke
	 */
	public class Game extends Sprite {
		[Embed(source='effect_001.png')]
		private var bitmap:Class;
		public var TEACH_MODE:Boolean;
		public var GAME_OVER:Boolean;
		public var TileBitmap:Bitmap;
		public var BoxBitmap:Bitmap;
		public var FlagBitmap:Bitmap;
		public var BONUS:Boolean = false;
		public var MOVEOVER:Boolean = false;
		public var addBox:Boolean = false;
		public var ADDBACKCOUNT:Number = 5;
		public var MAP:Array = [];

		public var MAP_INDEX:int;
		public var PAUSE:Boolean = false;
		private var world:IsoWorld;
		private var other_world:IsoWorld;
		private var AI:Array = [];
		private var box:DrawnIsoBox;
		private var Shadows:Shadow;
		private var shadow:DrawnIsoTile;
		private var ClickPosition:Point3D;
		private var gravity:Number = 2;
		private var friction:Number = 0.95;
		private var bounce:Number = 0.8;
		private var filter:BlurFilter;
		//private var ClickPosition:Point3D;

		private var BlackIndex:int;
		private var Spring:GraphicIsoBox;
		private var MouseFlag:GraphicIsoBox;
		private var TargetFlag:GraphicIsoBox;
		private var PLAYER:GraphicIsoBox;
		private var mc:MovieClip;
		private var Stretch:Number = 0;
		private var SpringHeight:Number = 0;
		private var isMouseDown:Boolean;
		private var isSwitchMode:Boolean;
		private var isPlayerMove:Boolean;
		private var minWidth:int;
		private var minHeight:int;
		private var maxWidth:int;
		private var maxHeight:int;

		private var grid:Grid;
		private var _cellSize:int = 20;
		private var map_size:int = 10;
		private var _index:int;
		private var _path:Array;
		private var maxCol:int = 3;
		private var maxHit:int = 4;

		private var COLOR:Array = new Array(map_size);

		private var Flags:Flag;
		private var StopFlag:Array = [];
		private var WaitToDelete:Array = [];
		private var WaitToAdd:Array = [];
		private var tempWaitToDelete:Array = [];
		private var ParticlesGroup:Array = [];
		private var GameOption:Object = new Object();
		private var TempOption:Object = new Object();
		private var StartPoint:Point; // = new Point();

		public var isBoxfull:Boolean = false;

		public function Game(x:Number = 0, y:Number = 0){
			maxHeight = y;
			maxWidth = x;
			init(x, y);
			MAP_INDEX = 0;
			for (var i:int = 0; i < maxHit; i++){
				var temp:Particles = new Particles(new bitmap(), 5, 1.2, 10);
				temp.width = 32;
				temp.height = 32;
				temp.release();
				temp.start();
				ParticlesGroup.push(temp);
			}
		}

		public function init(x:Number = -1, y:Number = -1):void {
			//if (x == -1 || y == -1){
			x = maxWidth / 2;
			y = maxHeight / 2;
			//}
			if (world == null){
				world = new IsoWorld();
				other_world = new IsoWorld();
				addChild(world);

			} else {
				removeChild(world);
				world = new IsoWorld();
				other_world = new IsoWorld();
				addChild(world);

				world.addChild(Flags.shadow);
				world.addChild(Flags.flag);
				Flags.enable = false;
			}
			world.x = x;
			world.y = y;
			if (StopFlag.length == 0){
				for (var i:int = 0; i < 36; i++){
					mc = new DrawnIsoBox(_cellSize / 2, 0x666666, _cellSize * 2)

					StopFlag.push(new GraphicIsoBox(_cellSize, mc, 0, 0));
					StopFlag[i].alpha = 0;
				}
			}
			if (Spring == null){
				mc = new SpringMc();
				mc.width *= 0.58;
				mc.height *= 0.58;
				mc.gotoAndPlay(15);
				Spring = new GraphicIsoBox(_cellSize, mc, mc.width / 2, 28);
			}
			Spring.position = new Point3D(0, 5000, 5 * _cellSize);
			world.addChildToWorld(Spring);
			if (PLAYER == null){
				mc = new Player();
				mc.width *= 0.58;
				mc.height *= 0.58;
				PLAYER = new GraphicIsoBox(_cellSize, mc, mc.width / 2, 28);
			}
			PLAYER.position = new Point3D(0, 5000, 5 * _cellSize);
			world.addChildToWorld(PLAYER);
			if (MouseFlag == null){
				mc = new FLAG();
				mc.width *= 0.58;
				mc.height *= 0.58;
				mc.gotoAndPlay(15);
				MouseFlag = new GraphicIsoBox(_cellSize, mc, mc.width / 2, 28);
				MouseFlag.position = new Point3D(0, 0, 5 * _cellSize);
				MouseFlag.shadow = new Shadow(MouseFlag, _cellSize, 0xffffff, 0);
			}


			if (TargetFlag == null){
				mc = new WhiteFLAG();
				mc.width *= 0.58;
				mc.height *= 0.58;
				mc.gotoAndPlay(15);

				TargetFlag = new GraphicIsoBox(_cellSize, mc, mc.width / 2, 28);
				TargetFlag.position = new Point3D(0, 5000, 5 * _cellSize);
				TargetFlag.alpha = 0;
			}
			if (TEACH_MODE)
				world.addChildToWorld(TargetFlag);


		}

		public function setMap_RANDOM(_map_size:int, _maxCol:int = 4):void {
			map_size = _map_size;
			maxCol = _maxCol;
			grid = new Grid(map_size, map_size);
			var node:Node;
			for (var i:int = 0; i < maxHit * maxCol; i++){
				var bool:Boolean = false;

				while (!bool){
					var x:int = Math.floor(Math.random() * map_size), y:int = Math.floor(Math.random() * map_size);
					bool = grid.setWalkable(x, y, false);
				}
				node = grid.getNode(x, y);
				node.type = i < (maxHit * maxCol) / 2 ? 'red' : 'black';
			}
		}

		public function setMap_LOADMAP(map:Array = null):void {
			if (map != null)
				MAP = map;
			else if (MAP.length == 0)
				return;
			else if (MAP_INDEX == MAP.length)
				return;
			var temp:Array = MAP[MAP_INDEX];

			map_size = temp[0]['mapSize'];
			_cellSize = temp[0]['cellSize'];
			StartPoint = temp[0]['startX'] != undefined ? new Point(Number(temp[0]['startX']), Number(temp[0]['startY'])) : null;
			grid = new Grid(map_size, map_size);
			DRAW_MAP.bulidGrid(grid, temp, map_size);
			trace("MAP" + MAP_INDEX);
		}

		public function setFlagType(bitmap:Bitmap):void {
			if (bitmap == null)
				return;
			FlagBitmap = bitmap;
			Flags = new Flag(box, FlagBitmap, _cellSize, 30, 30);

			world.addChild(Flags.shadow);
			world.addChild(Flags.flag);
			Flags.addEventListener(Event.ENTER_FRAME, update);
			Flags.enable = false;
		}

		public function BuildWorld():void {
			var node:Node;

			DRAW_MAP.buildMap(world, grid, map_size, _cellSize, onBoxClick);
			//addBoxToWorld();
			world.width *= 1.8;
			world.height *= 1.8;
			drawMap();

			box = StartPoint != null ? grid.getNode(StartPoint.x, StartPoint.y).b_parent : searchRedBox();

			var _Shadows:Shadow = new Shadow(box, _cellSize, 0, 0);

			world.addChildToFloor(_Shadows);
			Shadows = _Shadows;
			if (!TEACH_MODE){
				world.addChildToWorld(MouseFlag);
			}
			world.addChildToFloor(MouseFlag.shadow);

			//for (i = 0; i < map_size; i++)
			//for (j = 0; j < map_size; j++){
			//var obj:* = grid.getNode(i, j).b_parent;
			//tempbox = obj;
			//if (tempbox != null){
			//tempbox.vy = 10;
			//tempbox.y = -(100 + j * 16 - i); // + Math.random() * 100);
			//tempbox.addEventListener(Event.ENTER_FRAME, updateBoxY);
			//}
			//}
			world.sort();

		}

		public function get thisMap():int {
			return MAP_INDEX;
		}

		public function RESTOK():void {
			if (GameOption['CallBack'] != null){
				GameOption['CallBack'].Command['rest'] = true;
				GameOption['CallBack'].Function(GameOption['CallBack'].Command);
			}
		}

		/**
		 *
		 * @param  option	SwitchType(String),MoveType(String),CellSize(int),MapSize(int),AddBox(int),RemoveBox(Point),CallBack({Function,Command,etc..}),Warning({Function,Command,etc..}),REST(Boolean)
		 * */
		public function Option(option:*):void {
			GameOption = {};
			System.gc();
			for (var str:String in option){
				TempOption[str] = option[str];
				switch (str){
					case "REST":
						PAUSE = false;
						BONUS = false;
						ADDBACKCOUNT = 5;
						WaitToAdd = [];
						if (option[str] == true){
							if (MAP_INDEX == MAP.length - 1)
								dispatchEvent(new Event(Event.COMPLETE));
							//Converter.OutputFile("http://locke.lst.ncu.edu.tw/savefile.php?filename=AI", JSON.encode(AI));
							if (MAP_INDEX == MAP.length)
								return;
							//
							AI = [];
							init();
							setMap_LOADMAP();
							BuildWorld();
							Option({SwitchType: BOX_SWITCH.NORMAL, CallBack: TempOption["CallBack"]});

						}
						break;
					case "NEXT":
						PAUSE = false;
						BONUS = false;
						ADDBACKCOUNT = 5;
						WaitToAdd = [];
						if (option[str] == true){
							MAP_INDEX++;
							if (MAP_INDEX == MAP.length - 1)
								dispatchEvent(new Event(Event.COMPLETE));

							//Converter.OutputFile("http://locke.lst.ncu.edu.tw/savefile.php?filename=AI", JSON.encode(AI));
							if (MAP_INDEX == MAP.length){

								return;
							}
							//
							AI = [];
							init();
							setMap_LOADMAP();
							BuildWorld();
							Option({SwitchType: BOX_SWITCH.NORMAL, CallBack: TempOption["CallBack"]});
								//GameOption['CallBack'].Function(GameOption['CallBack'].Command);

						}
						break;
					case "CellSize":
						break;
					case "MapSize":
						break;


					case "MoveType":
						isSwitchMode = false;
					case "SwitchType":
						if (option["SwitchType"] != undefined){
							isSwitchMode = true;
							if (this.hasEventListener(MouseEvent.MOUSE_UP)){
								this.removeEventListener(MouseEvent.MOUSE_UP, onClick);
								this.removeEventListener(MouseEvent.MOUSE_UP, Release);
							}
							if (this.hasEventListener(MouseEvent.MOUSE_DOWN)){
								this.removeEventListener(MouseEvent.MOUSE_DOWN, Arrest);
							}
								//box = null;
						}
					case "Warning":
					case "CallBack":
						GameOption[str] = option[str];
						break;
				}
			}
		}

		/**
		 *
		 * @param  cmd	MOVETO:{Select(Point),MoveTo(Point)},SELECT(POINT),MOVE(Point)
		 * */
		public function Command(cmds:*, onlyTarget:Boolean = false):void {
			var event:MouseEvent = new MouseEvent(MouseEvent.CLICK);
			var cmd:*;
			var moveTo:Point3D;
			var temp:GraphicIsoBox;
			for (var str:String in cmds){
				if (!onlyTarget){
					switch (str){
						case "MOVETO":
						case "SELECT":
							cmd = cmds[str];
							var node:Node = grid.getNode(cmd.Select.x, cmd.Select.y);
							node.b_parent.dispatchEvent(event);
							if (str == "SELECT")
								break;
						case "MOVE":
							cmd = cmds[str];
							moveTo = new Point3D(cmd.MoveTo.x * _cellSize, 0, cmd.MoveTo.y * _cellSize); //node.x
							MouseFlag.position = moveTo;
							if (str == "MOVE")
								break;
							event = new MouseEvent(MouseEvent.MOUSE_UP);
							this.dispatchEvent(event);
							break;
						case "DELECT":
							break;
					}
				} else {
					cmd = cmds[str];
					if (str == "SELECT"){
						moveTo = new Point3D(cmd.Select.x * _cellSize, -_cellSize, cmd.Select.y * _cellSize);
						node = grid.getNode(cmd.Select.x, cmd.Select.y);
						if (node.b_parent == null)
							moveTo = new Point3D(0, -5000, 0);
					} else if (str == "MOVE"){
						moveTo = new Point3D(cmd.MoveTo.x * _cellSize, 0, cmd.MoveTo.y * _cellSize);
						node = grid.getNode(cmd.MoveTo.x, cmd.MoveTo.y);
						if (node.b_parent != null)
							moveTo = new Point3D(0, -5000, 0);
					}
					TARGET = moveTo;
				}
				switch (str){
					case "ShiftBox":
						if (WaitToAdd.length > 0){
							if (isSwitchMode)
								if (!world.hasListener()){
									WaitToAdd[0].flag.alpha = 0;
									world.releaseItem(WaitToAdd[0].flag);

									addBoxToWorld(WaitToAdd[0].name, WaitToAdd[0].node);
									WaitToAdd.shift();
								}
						}
						break;

					case "AddBox":
						var black:Array = world.getChildbyColor(0x555555);
						isBoxfull = (black.length >= ((map_size * map_size) / 2));

						if (world.Childs > (map_size * map_size) / 2)
							return;
						//var black:Array = world.getChildbyColor(0x555555);
						//if (black.length < 2)
						//	return;
						var string:String;
						var i:int = 0;
						BlackIndex = (BlackIndex + 1) % 4
						var rand:int = BlackIndex;
						var STR:Array = ["UP", "LEFT", "DOWN", "RIGHT"];


						node = getSpaceNode();
						//for (i = 0; i < STR.length; i++){
						//var string:String = STR[(i+rand)%STR.length];
						//if (node[string] != null && node[string].b_parent == null)
						//break;
						//if (node[string] != null && node[string].b_parent == null)
						//break;
						//}

						for (i = 0; i < cmds[str]; i++){
							node.walkable = false;
							node.tile.alpha = .8;
							StopFlag.sortOn('alpha', Array.NUMERIC);
							temp = StopFlag[0];
							temp.alpha = .5;
							temp.position = new Point3D(node.x * _cellSize, 0, node.y * _cellSize);
							world.addChildToWorld(temp);
							WaitToAdd.push({name: 'black', node: node, flag: temp});
							//addBoxToWorld('black', node);
							for (var j:int = 0; j < STR.length; j++){
								string = STR[(j + rand) % STR.length];
								if (node[string] != null && node[string].b_parent == null && node[string].walkable){
									node = node[string];
									//node.walkable = false;
									break;
								}
							}
							if (j == STR.length)
								node = getSpaceNode();
						}
						var red:Array = world.getChildbyColor(0xff0000);
						if (red.length <= 1){
							Command({AddRed: 2});
						}
						break;
					case "AddRed":
						black = world.getChildbyColor(0x555555);
						red = world.getChildbyColor(0xff0000);
						isBoxfull = (black.length >= (map_size * map_size / 2));
						var isFull:int = (map_size * map_size) - ((map_size * map_size) / 3);
						if ((world.Childs + WaitToAdd.length < isFull && WaitToAdd.length < map_size * 2) || red.length < maxHit * 2){
							for (i = 0; i < cmds[str]; i++){
								node = getSpaceNode();
								StopFlag.sortOn('alpha', Array.NUMERIC);
								temp = StopFlag[0];
								temp.alpha = .5;
								temp.position = new Point3D(node.x * _cellSize, 0, node.y * _cellSize);
								world.addChildToWorld(temp);
								node.walkable = false;
								WaitToAdd.push({name: 'red', node: node, flag: temp});
								node.tile.alpha = .8;
							}
						}
						break;
					case "RemoveBox":
						break;
					case "draw":
						if (hasEventListener(Event.ENTER_FRAME))
							return;
						drawMap();

						addBox = false;
						break;
				}
			}
		}

		private function set TARGET(value:Point3D):void {
			if (TEACH_MODE){
				TargetFlag.position = value;
				TargetFlag.alpha = 0.8;
				world.sort();
			} else {
				TargetFlag.position = new Point3D(0, -5000, 0);
				TargetFlag.alpha = 0;
			}
		}

		private function onBoxClick(e:MouseEvent = null):void {
			if (PAUSE)
				return;
			if (world.hasListener())
				return;
			if (hasEventListener(Event.ENTER_FRAME))
				return;
			//if (box == null)
			//return;
			if (world.Childs == 0)
				return;
			//if (!e.altKey)
			//return;
			if (GameOption['SwitchType'] == undefined)
				return;
			var canSelect:Boolean = (GameOption['SwitchType'] == BOX_SWITCH.SPRING || GameOption['SwitchType'] == BOX_SWITCH.MAGNET);
			var temp:* = e.currentTarget;
			if (temp.node.type == "black" && !canSelect){
				TempOption.Warning.Command = 2;
				return;
			}
			if (temp.node.type == "red" && canSelect){
				TempOption.Warning.Command = 1;
				return;
			}
			if (GameOption['SwitchType'] == BOX_SWITCH.NORMAL && temp.node.type == "black")
				return;
			if (TEACH_MODE && (temp != null)){
				if (temp.position.x != TargetFlag.position.x || temp.position.z != TargetFlag.position.z){
					TempOption.Warning.Command = 0x20;
					return;
				}
			}
			if (temp != null){
				if (box != temp && box != null)
					box.y = 0;
				box = temp;
				Shadows.parentes = box;
				Shadows.show();
				Flags.target = box;

				switchBox(box);
				var tempOBJ:Array = world.getChildbyColor();
				for (var i:int = 0; i < tempOBJ.length; i++){
					tempOBJ[i].alpha = .5;
					Mouse.add(tempOBJ[i], MouseEvent.MOUSE_OUT, {alpha: .5});
				}
					//}
			} else {

			}
		}

		private function onClick(e:MouseEvent):void {
			if (PAUSE)
				return;
			if (world.hasListener())
				return;
			if (box == null)
				return;
			if (GameOption['MoveType'] != BOX_MOVE.JUMP&&ADDBACKCOUNT < .3)
				return;
			if (hasEventListener(Event.ENTER_FRAME))
				return;

			var pos:Point3D = MouseFlag.position; //IsoUtils.screenToIso(new Point(world.mouseX, world.mouseY));
			if (TEACH_MODE)
				if (pos.x != TargetFlag.position.x || pos.z != TargetFlag.position.z){
					TempOption.Warning.Command = 0x20;
					return;
				}
			//pos = Calc_Rect(pos);
			ClickPosition = pos;
			var end_xpos:int = Math.floor(pos.x / (_cellSize));
			var end_ypos:int = Math.floor(pos.z / (_cellSize));
			if ((end_xpos < 0 || end_xpos > map_size - 1) || (end_ypos < 0 || end_ypos > map_size - 1))
				return;
			grid.setEndNode(end_xpos, end_ypos);
			box.position = Calc_Rect(box.position);
			var start_xpos:int = Math.floor(box.x / (_cellSize));
			var start_ypos:int = Math.floor(box.z / (_cellSize));
			grid.setStartNode(start_xpos, start_ypos);
			grid.setWalkable(start_xpos, start_ypos, true);
			if (GameOption['MoveType'] == BOX_MOVE.JUMP){
				_index = 0;
				gravity = 0.3;
				box.vy = 72;
				_path = [];
				_path.push(grid.startNode);
				_path.push(grid.endNode);
				_path = Path(_path);
				if (!grid.endNode.walkable || _path.length == 0){
					this.removeEventListener(MouseEvent.MOUSE_UP, onClick);
					box.y = 0;
					grid.setWalkable(start_xpos, start_ypos, false);
					if ( /*(world.Childs != 0 || other_world.Childs == 0) && */GameOption['CallBack'] != null){
						GameOption['CallBack'].Function(GameOption['CallBack'].Command);
							//GameOption['CallBack'] = null;
					}
				} else {
					MOVEOVER = false;
					addEventListener(Event.ENTER_FRAME, onEnterFrame);
					this.removeEventListener(MouseEvent.MOUSE_UP, onClick);
				}
			} else {
				var astar:AStar = new AStar();
				if (astar.findPath(grid)){
					//trace("Command:" + CommanText(start_xpos, start_ypos, end_xpos, end_ypos));
					MOVEOVER = false;
					_path = Path(astar.path);
					_index = 0;
					gravity = 0.3;
					box.vy = 72;

					addEventListener(Event.ENTER_FRAME, onEnterFrame);
					this.removeEventListener(MouseEvent.MOUSE_UP, onClick);
				} else {
					box.y = 0;
					PLAYER.y = 500;
					//if (box.node.type == "red")
					//	PLAYER.y = 500;
					grid.setWalkable(start_xpos, start_ypos, false);
					this.removeEventListener(MouseEvent.MOUSE_UP, onClick);
					TempOption.Warning.Command = 0;
					if ( /*(world.Childs != 0 || other_world.Childs == 0) && */GameOption['CallBack'] != null){
						GameOption['CallBack'].Function(GameOption['CallBack'].Command);
							//GameOption['CallBack'] = null;
					}
						//box.y = 0;
				}
			}
			var tempOBJ:Array = world.getChildbyColor();

			for (var i:int = 0; i < tempOBJ.length; i++){
				tempOBJ[i].alpha = 1;
				Mouse.add(tempOBJ[i], MouseEvent.MOUSE_OUT, {alpha: 1});
			}
		}

		private function CommanText(x1:int, y1:int, x2:int, y2:int):String {
			var cmd:* = {MOVE: {Select: {x: x1, y: y1}, MoveTo: {x: x2, y: y2}}};
			cmd.Item = TempOption['SwitchType'];
			cmd.MoveType = TempOption['MoveType'];
			AI.push(cmd);
			return JSON.encode(cmd);
			//return "Command( { MOVE: { Select: { x: " +x1 + ", y: " +y1 + " }" + " , MoveTo: { x: " +x2 + ", y: " + y2 + " } " + "} } )";
		}

		private function Arrest(e:MouseEvent):void {
			isMouseDown = true;
		}

		private function Release(e:MouseEvent):void {
			mc.play();
			if (TEACH_MODE){
				var pos:Point3D = MouseFlag.position; //IsoUtils.screenToIso(new Point(world.mouseX, world.mouseY));
				if (TEACH_MODE)
					if (pos.x != TargetFlag.position.x || pos.z != TargetFlag.position.z){
						TempOption.Warning.Command = 0x20;
						return;
					}
				//pos = Calc_Rect(pos);
				ClickPosition = pos;
				var end_xpos:int = Math.floor(pos.x / (_cellSize));
				var end_ypos:int = Math.floor(pos.z / (_cellSize));
				if ((end_xpos < 0 || end_xpos > map_size - 1) || (end_ypos < 0 || end_ypos > map_size - 1))
					return;
				grid.setEndNode(end_xpos, end_ypos);
				box.position = Calc_Rect(box.position);
				var start_xpos:int = Math.floor(box.x / (_cellSize));
				var start_ypos:int = Math.floor(box.z / (_cellSize));
				grid.setStartNode(start_xpos, start_ypos);
				grid.setWalkable(start_xpos, start_ypos, true);
				if (GameOption['MoveType'] == BOX_MOVE.JUMP){
					_index = 0;
					gravity = 0.3;
					box.vy = 72;
					_path = [];
					_path.push(grid.startNode);
					_path.push(grid.endNode);
					_path = Path(_path);
					if (!grid.endNode.walkable || _path.length == 0){

					} else {
						isMouseDown = false;
						this.removeEventListener(MouseEvent.MOUSE_DOWN, Arrest);
						this.removeEventListener(MouseEvent.MOUSE_UP, Release);

						addEventListener(Event.ENTER_FRAME, onEnterFrame);
						var tempOBJ:Array = world.getChildbyColor();

						for (var i:int = 0; i < tempOBJ.length; i++){
							tempOBJ[i].alpha = 1;
							Mouse.add(tempOBJ[i], MouseEvent.MOUSE_OUT, {alpha: 1});
						}
					}
				}
			} else {
				isMouseDown = false;
				this.removeEventListener(MouseEvent.MOUSE_DOWN, Arrest);
				this.removeEventListener(MouseEvent.MOUSE_UP, Release);
				onClick(e);
			}

		}

		private function onEnterFrame(event:Event):void {
			if (PAUSE)
				return;

			//var pos:Point3D = IsoUtils.screenToIso(new Point(world.mouseX, world.mouseY));
			switch (GameOption['MoveType']){
				case BOX_MOVE.JUMP:
					_index = BoxMove.JumpToPath(world, box, grid, ClickPosition, _cellSize, _index); //BoxMove.MoveToPath(world, box, grid, _path, _cellSize, _index);
					break;
				case BOX_MOVE.ROAD:

					_index = BoxMove.MoveToPath(world, box, grid, _path, _cellSize, _index);


					break;
				default:
					_index = -1;
					break;
			}
			if (box.node.type == 'red' && _index != -1){
				var target:Point3D = new Point3D(_path[_index].x * _cellSize, _path[_index].y * _cellSize);
				var dx:Number = target.x - box.x;
				var dy:Number = target.y - box.z;
				var array:Array = ['front', 'back', 'left', 'right'];
				var index:int = 0;
				if (Math.abs(dx) > Math.abs(dy)){
					if (dx > 0)
						index = 0;
					else if (dx < 0)
						index = 1;
				} else {
					if (dy > 0)
						index = 2;
					else if (dy < 0)
						index = 3;
				}
				PLAYER.label("Man", array[index]);
				PLAYER.position = new Point3D(box.position.x, 0, box.position.z);
			}
			if (_index == -1){
				box.y = 0;
				PLAYER.y = 500;
				MOVEOVER = true;
				Flags.enable = false;
				Spring.x = 1024;
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				//drawMap();
				isPlayerMove = true;
				addBox = true;
				if ( /*(world.Childs != 0 || other_world.Childs == 0) && */GameOption['CallBack'] != null){
					GameOption['CallBack'].Function(GameOption['CallBack'].Command);
						//GameOption['CallBack'] = null;
				}
			}

		}

		private function drawMap():void {
			//if (box == null)
			//return;
			var i:int, j:int, color:uint, alpha:Number = 1;
			var node:Node;
			var hit_num:int;
			var startNode:int;
			WaitToDelete = [];
			//graphics.clear();

			if (!y_search(COLOR)){
				//if (deleteBox()){
				if (isPlayerMove)
					PAUSE = true;
				else
					Command({AddBox: 2});
				//drawMap();
				return;
					//}
			}
			if (!x_search(COLOR)){
				if (isPlayerMove)
					PAUSE = true;
				else
					Command({AddBox: 2});
				//if (deleteBox()){
				//BONUS = true;
				//drawMap();
				return;
					//}
			}
			//for (i = startNODE.x; i < endNODE.x; i++){
			//for (j = startNODE.y; j < endNODE.y; j++){
			//graphics.beginFill(COLOR[i][j].color, COLOR[i][j].alpha);
			//graphics.drawRect(i * _cellSize / 2, j * _cellSize / 2, _cellSize / 2, _cellSize / 2);
			//}
			//}
			//world.sort();

		}

		public function addBoxToWorld(box_color:String = 'black', to:Node = null):void {
			var bit:Bitmap = BoxBitmap;
			var node:Node = (to == null) ? getSpaceNode() : to;
			node.type = box_color;
			var color:uint = node.type == 'red' ? 0xff0000 : 0x555555;
			var tempbox:DrawnIsoBox = DRAW_MAP.CreatBoxTo(node, color, _cellSize, onBoxClick);
			//var _Shadows:Shadow = new Shadow(tempbox, _cellSize, 0, 0);
			//node.b_parent = tempbox;
			world.addChildToWorld(tempbox);
			//world.addChildToFloor(_Shadows);
			tempbox.vy = 10;
			tempbox.y = -(100 + node.y * 16 - node.x);
			//tempbox.shadow = _Shadows;
			tempbox.addEventListener(Event.ENTER_FRAME, updateBoxY);


			//box = tempbox;
			//Flags.target = tempbox;
			//Shadows = tempbox.shadow;

		}

		private function update(event:Event):void {
			if (TempOption.Warning != undefined)
				TempOption.Warning.Command = TempOption.Warning.Function(TempOption.Warning.Command);
			if (Flags.enable){
				if (!Tweener.isTweening(Flags.flag))
					Tweener.addTween(Flags.flag, {scaleX: Flags.flag.scaleX <= 0 ? 0.2 : -0.2, time: 1.5, delay: 0.5});

				bounce = (gravity <= 0 && bounce < 0) || (gravity >= 18 && bounce > 0) ? -bounce : bounce;
				gravity += bounce;
				Flags.flag.scaleY = 0.2 + (gravity * 0.1) / 20;
				Flags.show(gravity);
			} else {
				Flags.y = 500;
			}
			if (isSwitchMode){
				MouseFlag.stop();
				MouseFlag.x = 1024;
				MouseFlag.y = 1024;
				MouseFlag.alpha = 0;
				MouseFlag.shadow.alpha = 0;
			} else {
				getPosition(MouseFlag);
				MouseFlag.alpha = 1;
				MouseFlag.shadow.alpha = .8;
				MouseFlag.shadow.show();
			}
			if (isMouseDown){
				box.y = (_cellSize * 0.6 * Stretch) + SpringHeight;
				Stretch = Stretch < 1 ? Stretch + 0.02 : 1;
				var k:int = 5 - Stretch * 5;
				mc.gotoAndStop(k);
			} else {

				Stretch -= Stretch / 6;
			}

		}

		private function playAnima(e:Event):void {

			for (var i:int = 0; i < tempWaitToDelete.length; i++){
				if (tempWaitToDelete[i] != null){
					var isTweening:Boolean = true;
					isTweening = Tweener.isTweening(tempWaitToDelete[i]);
					if (!isTweening){
						other_world.releaseChild(tempWaitToDelete[i]);
						tempWaitToDelete[i] = null;
					}
				}
			}
			if (other_world.Childs == 0){

				for (i = 0; i < ParticlesGroup.length; i++)
					other_world.removeChild(ParticlesGroup[i]);
				//GAME_OVER = true; 
				world.removeChild(other_world);
				if (world.Childs == 0 && WaitToAdd.length <= 2){
					GAME_OVER = true;
						//Option({NEXT: true});
				}
				tempWaitToDelete = [];
				removeEventListener(Event.ENTER_FRAME, playAnima);
				addBox = true;
			}

		}

		private function updateBoxY(e:Event):void {
			if (e.target.vy != 0){
				upgrade.gravity({OBJECT: e.target, TARGET_1: 'vy', TARGET_2: 'y'}, 2, 0.3, 0.9);
				Shadows.parentes = e.target;
				Shadows.show();
					//e.target.shadow.show();
			} else {
				//world.removeChildToFloor(e.target.shadow);

				e.target.removeEventListener(Event.ENTER_FRAME, updateBoxY);
				var temp:DrawnIsoBox = box;
				try {
					var node:Node = e.currentTarget.node;
					var temp2:DrawnIsoBox = node.b_parent;
				} catch (error:Error){
				}
				box = temp2;
				isPlayerMove = false;
				drawMap();
				isPlayerMove = true;
				if (box == null){
					PLAYER.y = 500;
					box = temp;
					if (temp != null)
						box.y = 0;

				} else if (temp != null){
					box = temp;
						//box.y = 0;
				} else {
					temp = world.lastChild;
				}

				//
				//
				world.sort();
			}
		}

		private function getPosition(target:IsoObject):void {

			var pos:Point3D = IsoUtils.screenToIso(new Point(world.mouseX, world.mouseY));
			pos = Calc_Rect(pos);

			pos.y = -3;

			if (pos.x == target.position.x && pos.z == target.position.z)
				return;

			var end_xpos:int = Math.floor(pos.x / (_cellSize));
			var end_ypos:int = Math.floor(pos.z / (_cellSize));
			if (!(end_xpos < 0 || end_xpos > map_size - 1) && !(end_ypos < 0 || end_ypos > map_size - 1)){

				var node:Node = grid.getNode(end_xpos, end_ypos);
				if (node.b_parent != null)
					pos.y = -_cellSize;
				target.position = pos;
				var hasBox:Boolean = (node.UP != null && node.UP.b_parent != null) || (node.DOWN != null && node.DOWN.b_parent != null) || (node.RIGHT != null && node.RIGHT.b_parent != null) || (node.LEFT != null && node.LEFT.b_parent != null);
				if (hasBox){
					if (!TEACH_MODE)
						world.sort();
				}
			} else {

			}

		}

		private function switchBox(target:*):void {

			if (target.node.type == "black"){
				switch (GameOption['SwitchType']){
					case BOX_SWITCH.SPRING:
						if (GameOption['CallBack'] != null)
							GameOption['CallBack'].Function(GameOption['CallBack'].Command);
						PLAYER.position = new Point3D(target.position.x, -5000, target.position.z);

						Option({MoveType: BOX_MOVE.JUMP, CallBack: GameOption['CallBack']});
						mc = Spring.MOVIE_CLIP;
						mc.gotoAndStop(1);
						Spring.position = new Point3D(target.position.x, 0, target.position.z);
						SpringHeight = -_cellSize * 0.7;
						target.y = SpringHeight;
						this.addEventListener(MouseEvent.MOUSE_DOWN, Arrest);
						this.addEventListener(MouseEvent.MOUSE_UP, Release);
						break;
					case BOX_SWITCH.MAGNET:
						if (GameOption['CallBack'] != null)
							GameOption['CallBack'].Function(GameOption['CallBack'].Command);
						PLAYER.position = new Point3D(target.position.x, -5000, target.position.z);
						target.y = 0;
						Option({MoveType: BOX_MOVE.AGRID, CallBack: GameOption['CallBack']});

						this.addEventListener(MouseEvent.MOUSE_UP, onClick);
						break;
				}
				Flags.enable = true;


			} else if (target.node.type == "red"){

				PLAYER.position = new Point3D(target.position.x, 0, target.position.z);
				target.y = -PLAYER.height / 2;

				if (GameOption['SwitchType'] == BOX_SWITCH.NORMAL)
					this.addEventListener(MouseEvent.MOUSE_UP, onClick);
				if (GameOption['CallBack'] != null){
					GameOption['CallBack'].Function(GameOption['CallBack'].Command);
						//GameOption['CallBack'] = null;
				}
				Flags.enable = false;
			}
			world.sort();

		}

		private function Path(target:Array):Array {
			var x:int = grid.endNode.x * _cellSize;
			var y:int = grid.endNode.y * _cellSize;
			switch (GameOption['MoveType']){
				case BOX_MOVE.AGRID:
					while (target.length > 3)
						target.pop();
					if (Formula.Radius(x, y, box.position.x, box.position.z) >= _cellSize * 1.5){
						TempOption.Warning.Command = 3;
						target.pop();
					}
					Option({MoveType: BOX_MOVE.ROAD, CallBack: GameOption['CallBack']});
					break;
				case BOX_MOVE.JUMP:
					if (Formula.Radius(x, y, box.position.x, box.position.z) < _cellSize * 3){
						ClickPosition = new Point3D(grid.startNode.x * _cellSize, 0, grid.startNode.y * _cellSize);
						box.vy = 10;
						TempOption.Warning.Command = 4;
						return [];
					}
					break;
			}
			return target;
		}

		private function getSpaceNode():Node {
			var temp:Array = grid.getfreeNode();
			temp.sortOn("z", Array.NUMERIC);
			var i:int = temp[0].x, j:int = temp[0].y;
			var node:Node = grid.getNode(i, j);

			return node;
		}

		private function get startNODE():Point {
			if (box == null)
				return new Point();
			var range:int = maxHit - 1;
			var pointX:int = box.node.x - range > 0 ? box.node.x - range : 0;
			var pointY:int = box.node.y - range > 0 ? box.node.y - range : 0;

			return new Point(pointX, pointY);
		}

		private function get endNODE():Point {
			if (box == null)
				return new Point(map_size, map_size);
			var range:int = maxHit;
			var pointX:int = box.node.x + range < map_size ? box.node.x + range : map_size;
			var pointY:int = box.node.y + range < map_size ? box.node.y + range : map_size;
			return new Point(pointX, pointY);
		}

		private function Calc_Rect(pos:Point3D):Point3D {
			return new Point3D(Math.round(pos.x / _cellSize) * _cellSize, Math.round(pos.y / _cellSize) * _cellSize, Math.round(pos.z / _cellSize) * _cellSize);
		}

		private function deleteBox():Boolean {
			if (hasEventListener(Event.ENTER_FRAME))
				return false;
			var node:Node;
			WaitToDelete = CheckStack();
			if (WaitToDelete.length != maxHit)
				return false;
			for (var i:int = 0; i < WaitToDelete.length; i++){

				node = WaitToDelete[i];
				//node.type = "";
				tempWaitToDelete.push(node.b_parent);
				if (node.b_parent.hasEventListener(Event.ENTER_FRAME)){
					node.b_parent.y = 0;
					node.b_parent.removeEventListener(Event.ENTER_FRAME, updateBoxY);
				}
				world.releaseChild(node.b_parent);

				other_world.addChildToWorld(tempWaitToDelete[i]);
				ParticlesGroup[i].x = IsoUtils.isoToScreen(tempWaitToDelete[i].position).x;
				ParticlesGroup[i].y = IsoUtils.isoToScreen(tempWaitToDelete[i].position).y + (-8);
				ParticlesGroup[i].release();

				other_world.addChild(ParticlesGroup[i]);
				Tweener.addTween(tempWaitToDelete[i], { /*x:0,z:0,y:0,*/alpha: 0, time: 0.6, delay: 0.1 + (i * 0.1), onStart: ParticlesGroup[i].start});
				node.b_parent = null;
				node.type = "";
				node.walkable = true;
			}
			if (tempWaitToDelete.length == maxHit){
				world.addChild(other_world);
				addEventListener(Event.ENTER_FRAME, playAnima);
			}
			box = null;
			//box = searchRedBox();
//
			//if (box != null){
			Shadows.parentes = world.lastChild;

			Shadows.show();
			//Flags.target = box;
			//} else {
			//Shadows.alpha = 0;
			//}

			world.erase();
			//} else if (black.length == 0){

			//Option({REST: true});
			//}

			return true;
		}

		private function CheckStack():Array {
			var i:int = 0;
			var red:Array = [];
			var black:Array = [];
			var tempStack:Object = new Object();
			var string:String = "";
			for (i = 0; i < WaitToDelete.length; i++){
				var node:Node = WaitToDelete[i];
				if (node.type == 'red')
					red.push({node: node, id: i});
				if (node.type == 'black')
					black.push({node: node, id: i});

				string += (node.type == 'red' ? "0" : "1");
			}
			return rule(string);

			//var sw:int = WaitToDelete.length - maxHit;
			//if (sw == 0){
			//if (red.length == black.length || red.length == maxHit || black.length == maxHit)
			//return WaitToDelete;
			//} else {
			//var head:Array = (red.length >= maxHit / 2 && red.length < maxHit && red[0].id == 0) ? red : [];
			//head = (black.length >= maxHit / 2 && black.length < maxHit && black[0].id < red[0].id) ? black : head;
			//if (red.length == maxHit)
			//return pop(red);
			//else if (black.length == maxHit)
			//return pop(black);
			//else if (head.length != 0){
			//return merge(head, ((head == red) ? black : red));
			//} else {
			//return pop(((red.length == 0) ? black : red));
			//}
//
			//}
			//return [];
		}

		private function rule(str:String):Array {
			var rule01:String = "";
			var rule02:String = "";
			var rule03:String = "";
			var rule04:String = "";
			var tempArray:Array = [];
			var start:int = WaitToDelete.length - maxHit;
			var i:int = 0;
			for (i = 0; i < maxHit; i++)
				rule01 += "1";
			for (i = 0; i < maxHit; i++)
				rule02 += "0";
			for (i = 0; i < maxHit; i++)
				rule03 += (i < (maxHit / 2) ? "0" : "1");
			for (i = 0; i < maxHit; i++)
				rule04 += (i < (maxHit / 2) ? "1" : "0");
			var rules:Array = [rule01, rule02, rule03, rule04];
			if (WaitToDelete.length == maxHit){
				for (i = 0; i < rules.length; i++)
					if (str == rules[i]){
						tempArray = WaitToDelete;
						break;
					}
			} else {
				while (start >= 0){
					str = "";

					for (i = start; i < maxHit + start; i++){
						var node:Node = WaitToDelete[i];
						tempArray.push(WaitToDelete[i]);
						str += (node.type == 'red' ? "0" : "1");
					}
					for (i = 0; i < rules.length; i++)
						if (str == rules[i])
							break;

					if (i == rules.length){
						tempArray = [];
						start--;
					} else
						break;
				}
			}
			if (i != rules.length)
				trace("rule is " + rules[i]);
			return tempArray;
		}

		private function merge(a:Array, b:Array):Array {
			var i:int = a.length - maxHit / 2;
			var temp:Array = [];
			for (i; i < a.length; i++)
				temp.push(a[i].node);
			var k:int = b.length == 2 ? 2 : (b.length > 2) ? 2 : 0;
			for (i = 0; i < k; i++)
				temp.push(b[i].node);
			if (temp.length == maxHit)
				return temp;
			else
				return [];
		}

		private function Safe_stack(arr:Array):Boolean {
			if (arr.length == 0)
				return true;
			var i:int = 0;
			var start:int = arr[0].id;
			if (arr.length == maxHit){
				for (i = start; i < (start + arr.length); i++){
					if (arr[i - start].id != i)
						return false;
				}
			}
			return true;
		}

		private function pop(a:Array):Array {
			var temp:Array = [];
			var i:int;
			for (i = 0; i < maxHit; i++)
				temp.push(a[i].node);
			if (temp.length == maxHit)
				return temp;
			else
				return [];
		}

		private function x_search(_arr:Array):Boolean {
			var i:int, j:int, k:int, color:uint, alpha:Number = 1;
			var node:Node;
			var hit_num:int;
			var startNode:int;
			for (j = startNODE.y; j < endNODE.y; j++){
				hit_num = 0;
				for (i = startNODE.x; i < endNODE.x; i++){

					alpha = 1;
					node = grid.getNode(i, j);
					color = node.walkable ? 0xffffff : 0x555555;
					if (color != 0xffffff && node.b_parent != null && !node.b_parent.hasEventListener(Event.ENTER_FRAME)){
						color = node.type == 'red' ? 0xff0000 : color;
						if ((node.LEFT != null /* && node.LEFT.type == node.type*/) || (node.RIGHT != null /* && node.RIGHT.type == node.type*/)){
							if (hit_num == 0)
								startNode = i;
							alpha = 0.5;
							hit_num++;
						} else {

						}
					} else {
						if (hit_num < maxHit)
							hit_num = 0;
							//node.type = "";
					}
						//_arr[i][j].alpha = _arr[i][j].alpha != 0.5 ? alpha : _arr[i][j].alpha;
						//if (hit_num >= maxHit)
						//break;
				}
				if (hit_num < maxHit)
					hit_num = 0;
				if (hit_num != 0 && (hit_num >= maxHit || hit_num == world.Childs)){
					k = hit_num;
					node = grid.getNode(startNode, j);
					var bool:Boolean;
					var firstColor:String = node.type;
					for (i = startNode; i < startNode + k; i++){
						node = grid.getNode(i, j);
						if (node.b_parent != null)
							WaitToDelete.push(node);
					}
					if (deleteBox())
						return false;

				}
			}
			return true;
		}

		private function y_search(_arr:Array):Boolean {
			var i:int, j:int, k:int, color:uint, alpha:Number = 1;
			var node:Node;
			var hit_num:int;
			var startNode:int;

			for (i = startNODE.x; i < endNODE.x; i++){
				hit_num = 0;
				for (j = startNODE.y; j < endNODE.y; j++){
					alpha = 1;
					node = grid.getNode(i, j);
					graphics.lineStyle(0);
					color = node.walkable ? 0xffffff : 0x555555;
					if (color != 0xffffff && node.b_parent != null && !node.b_parent.hasEventListener(Event.ENTER_FRAME)){
						color = node.type == 'red' ? 0xff0000 : color;
						if ((node.DOWN != null /* && node.DOWN.type == node.type*/) || (node.UP != null /* && node.UP.type == node.type*/)){
							if (hit_num == 0)
								startNode = j;
							alpha = 0.5;
							hit_num++;
						}
					} else {
						if (hit_num < maxHit)
							hit_num = 0;
							//node.type = "";
					}
						//_arr[i][j] = {color: color, alpha: alpha};
				}
				if (hit_num < maxHit)
					hit_num = 0;
				if (hit_num != 0 && (hit_num >= maxHit || hit_num == world.Childs)){
					k = hit_num;
					node = grid.getNode(i, startNode);
					var bool:Boolean;
					var firstColor:String = node.type;
					for (j = startNode; j < startNode + k; j++){
						node = grid.getNode(i, j);
						if (node.b_parent != null)
							WaitToDelete.push(node);
					}
					if (deleteBox())
						return false;
				}
			}
			return true;
		}

		private function searchRedBox():DrawnIsoBox {
			if (world.lastChild == null)
				return null;
			var lastbox:DrawnIsoBox = world.lastChild;
			var tempbox:DrawnIsoBox = lastbox;
			while (world.nextChild(tempbox) != lastbox){
				if (tempbox.node.type == 'red')
					return tempbox;
				tempbox = world.nextChild(tempbox);
			}
			return (lastbox.node.type == 'red') ? lastbox : null;
		}
	}
}