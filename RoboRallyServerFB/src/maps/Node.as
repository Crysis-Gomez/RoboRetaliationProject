package maps
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import maps.elements.base.BoardElement;
	import maps.elements.checkpoint.CheckPoint;
	import maps.elements.conveyorbelt.ConveyorBelt;
	import maps.elements.Laser;
	import maps.elements.player.base.PlayerBoardElement;
	import maps.elements.player.Player;
	import maps.elements.repair.RepairElement;
	import maps.elements.Wall;
	import maps.factories.BoardElementFactory;
	import maps.tools.properties.NodeProperties;
	import models.data.PlayerData;
	
	/**
	 * ...
	 * @author
	 */
	public class Node extends Sprite
	{
		private var _boardElement:BoardElement;
		[Embed(source="Tile.png")]
		private var nodeImageClass:Class;
		private var nodeImage:Bitmap = new nodeImageClass();
		private var _xPos:int;
		private var _yPos:int;
		public var wallArray:Array = new Array();
		public var laserArray:Array = new Array();
		
		public var hasWallLeft:Boolean = false;
		public var hasWallUp:Boolean = false;
		public var hasWallDown:Boolean = false;
		public var hasWallRight:Boolean = false;
		
		public var hasLaserLeft:Boolean = false;
		public var hasLaserUp:Boolean = false;
		public var hasLaserDown:Boolean = false;
		public var hasLaserRight:Boolean = false;
		public var robot:PlayerBoardElement;
		private var _pickup:BoardElement;
		
		private var wall:Wall;
		private var laser:Laser;
		private var registerMarks:Array = new Array();
		private var _map:Map;
		
		public function Node(i:int, j:int, grid:Grid, map:Map)
		{
			this.addChild(nodeImage);
			nodeImage.width = 60;
			nodeImage.height = 60;
			
			_xPos = i;
			_yPos = j;
			this.x = i * 60;
			this.y = j * 60;
			_map = map;
			grid.addChild(this);
		
		}
		
		public function highlight():void 
		{
			filters = [new GlowFilter(0xFFFFFF,0.8,10,10)];
		}
		
		public function unhighlight():void 
		{
			filters = null;
		}
		
		public function resolveWalls(string:String, bool:Boolean):void
		{
			
			if (bool)
			{
				addWall(string);
			}
			else
			{
				removeWall(string);
			}
		
		}
		
		
		public function resolveLasers(string:String, bool:Boolean):void 
		{
			if (bool)
			{
				addLasers(string);
			}
			else
			{
				removeLasers(string);
			}
		}
		
		public function removeLasers(string:String):void 
		{
			for (var i:int = 0; i < laserArray.length; i++)
			{
				var _laser:Laser = laserArray[i];
				if (_laser.type == string)
				{
					_laser.removeNode();
					laserArray.splice(i, 1);
					
					switch (string)
					{
						case "down":
							
						hasLaserDown = false;
							break;
						
						case "up":
							
						hasLaserUp = false;
							break;
						
						case "left": 
						hasLaserLeft = false;
							break;
						
						case "right": 
						hasLaserRight = false;
							break;
						default: 
					}
				}
			}
		}
		
		
		
		public function addLasers(string:String):void 
		{
				switch (string)
			{
				case "down": 
					laser = new Laser(string, this,_map);
					laser.addToNode();
					hasLaserDown = true;
					
					break;
				
				case "up":
					
					laser = new Laser(string, this,_map);
					laser.addToNode();
					hasLaserUp = true;
					break;
				
				case "left": 
					laser = new Laser(string, this,_map);
					laser.addToNode();
					hasLaserLeft = true;
					break;
				
				case "right": 
					laser = new Laser(string, this,_map);
					laser.addToNode();
					hasLaserRight = true;
					break;
				
				default: 
			}
			
			laserArray.push(laser);
		}
		
		public function addWall(string:String):void
		{
			switch (string)
			{
				case "down": 
					wall = new Wall(string, this);
					wall.addToNode();
					hasWallDown = true;
					break;
				
				case "up":
					
					wall = new Wall(string, this);
					wall.addToNode();
					hasWallUp = true;
					break;
				
				case "left": 
					wall = new Wall(string, this);
					wall.addToNode();
					hasWallLeft = true;
					break;
				
				case "right": 
					wall = new Wall(string, this);
					wall.addToNode();
					hasWallRight = true;
					break;
				
				default: 
			}
			
			wallArray.push(wall);
		}
		
		public function removeWall(string:String):void
		{
			for (var i:int = 0; i < wallArray.length; i++)
			{
				var _wall:Wall = wallArray[i];
				if (_wall.type == string)
				{
					_wall.removeNode();
					
					wallArray.splice(i, 1);
					
					switch (string)
					{
						case "down":
							removeLasers(string);
							hasWallDown = false;
							break;
						
						case "up":
							removeLasers(string);
							hasWallUp = false;
							break;
						
						case "left": 
							removeLasers(string);
							hasWallLeft = false;
							break;
						
						case "right": 
							removeLasers(string);
							hasWallRight = false;
							break;
						default: 
					}
				}
			}
		}
		
		public function addBoardElement(type:String, propertie:* = null):void
		{
			var aElement:BoardElement = BoardElementFactory.getInstance().getBoardElement(type, true, true);
			_boardElement = aElement;
			_boardElement.setPos(xPos, yPos);
			if (propertie != null)
			{
				_boardElement.setPropertie(propertie);
				
			}
			this.addChild(boardElement);
			setChildIndex(_boardElement, 1);
		}
		
		public function removeBoardElement():void
		{
			if (this.contains(_boardElement))
			{
				this.removeChild(_boardElement);
				_boardElement = null;
			}
		}
		
		private function checkWalls():String
		{
			var string:String = "";
			for (var i:int = 0; i < wallArray.length; i++)
			{
				var _wall:Wall = wallArray[i];
				string += _wall.type;
				
			}
			
			return string;
		}
		
	
		
		private function checkLasers():String 
		{
			var string:String = "";
			for (var i:int = 0; i < laserArray.length; i++)
			{
				var _laser:Laser = laserArray[i];
				string += _laser.type;
				
			}
			
			return string;
		}
		
		public function toXML():String
		{
			
			var xmlString:String = "";
			xmlString += "<wall>";
			xmlString += "<x>" + xPos + "</x>";
			xmlString += "<y>" + yPos + "</y>";
			xmlString += "<checkWall>" + checkWalls() + "</checkWall>";
			if(laserArray.length > 0)xmlString += "<checkLaser>" + checkLasers() + "</checkLaser>"; 
			xmlString += "</wall>";
			return xmlString;
		
		}
		
		public function setRobot(robot:PlayerBoardElement):void
		{
			this.robot = robot;
		}
		
		public function get boardElement():BoardElement
		{
			return _boardElement;
		}
		
		public function set boardElement(value:BoardElement):void
		{
			_boardElement = value;
		}
		
		public function get xPos():int
		{
			return _xPos;
		}
		
		public function get yPos():int
		{
			return _yPos;
		}
		
		public function get pickup():BoardElement 
		{
			return _pickup;
		}
		
		public function get map():Map 
		{
			return _map;
		}
		

		
		override public function toString():String
		{
			var string:String = "";
			string += "x: " + xPos + " y: " + yPos + " robot " + robot;
			if (boardElement != null)
			{
				string += " " + boardElement.type
			}
			return string;
		}
		
		public function removeRegisterMark(playerBoardElement:PlayerBoardElement):void
		{
			if (boardElement is CheckPoint) {
				(boardElement as CheckPoint).removePlayer(playerBoardElement.playerData);
			}
			if (boardElement is RepairElement) {
				(boardElement as RepairElement).removePlayer(playerBoardElement.playerData);
			}
		}
		
		public function addRegisterMark(playerBoardElement:PlayerBoardElement):void
		{
			if (boardElement is CheckPoint)
			{
				(boardElement as CheckPoint).addPlayer(playerBoardElement.playerData);
			}
			if (boardElement is RepairElement)
			{
				(boardElement as RepairElement).addPlayer(playerBoardElement.playerData);
			}
		}
		
		public function addPickUp(boardElement:BoardElement):void 
		{
			_pickup = boardElement;
			this.addChild(_pickup);
			
		}
		
		public function removePickUp():void 
		{
			if (this.contains(pickup)) {
				removeChild(pickup);
				_pickup = null;
			}
		}
	
	}
}