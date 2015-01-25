package maps
{
	import core.Game;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import gui.player.PlayerElement;
	import logger.Logger;
	import maps.elements.base.BoardElement;
	import maps.elements.Laser;
	import maps.elements.player.base.PlayerBoardElement;
	import maps.elements.player.Player;
	import maps.elements.player.TestPlayer;
	import maps.elements.start.StartElement;
	import maps.factories.BoardElementFactory;
	import maps.tools.MapEditingTools;
	import maps.tools.properties.NodeProperties;
	import models.data.BoardElementMapData;
	import models.data.MapData;
	import models.data.PlayerData;
	import models.data.WallElementData;
	import mx.core.UIComponent;
	import screens.Playscreen;
	
	/**
	 * ...
	 * @author
	 */
	public class Map extends UIComponent
	{
		private var _editable:Boolean;
		private var grid:Grid;
		private var previosElement:BoardElement;
		private var _game:Game;
		private var onComplete:Function;
		private var registerIndex:int;
		private var laserFinishedCounter:int;
		private var elementFinishedCounter:int;
		
		public function Map()
		{
			verticalCenter = 0;
			horizontalCenter = 0;
			width = 960;
			height = 720;
			
			init();
		}
		
		public function toXML():String
		{
			var xmlString:String = "";
			xmlString += "<boardelements>";
			for (var i:int = 0; i < nodes.length; ++i)
			{
				for (var j:int = 0; j < (nodes[i] as Array).length; ++j)
				{
					var node:Node = nodes[i][j] as Node;
					if (node.boardElement != null)
					{
						xmlString += node.boardElement.toXML();
					}
				}
			}
			xmlString += "</boardelements>";
			
			xmlString += "<walls>";
			for (var k:int = 0; k < nodes.length; ++k)
			{
				for (var l:int = 0; l < (nodes[k] as Array).length; ++l)
				{
					var _node:Node = nodes[k][l] as Node;
					if (_node.wallArray.length > 0)
						xmlString += _node.toXML();
				}
				
			}
			
			xmlString += "</walls>";
			
			return xmlString;
		}
		
		public function loadMapData(mapData:MapData):void
		{
			
			for each (var aMapElement:BoardElementMapData in mapData.elements)
			{
				(nodes[aMapElement.x][aMapElement.y] as Node).addBoardElement(aMapElement.type, aMapElement.propertie)
			}
			
			for each (var wall:WallElementData in mapData.walls)
			{
				
				checkLasers(wall, "up");
				checkLasers(wall, "down");
				checkLasers(wall, "right");
				checkLasers(wall, "left");
				checkWalls(wall, "up");
				checkWalls(wall, "down");
				checkWalls(wall, "right");
				checkWalls(wall, "left");
				
			}
		}
		
		public function checkWalls(wall:WallElementData, string:String):void
		{
			if (wall.type.match(string))
			{
				(nodes[wall.x][wall.y] as Node).addWall(string);
			}
		}
		
		public function checkLasers(wall:WallElementData, string:String):void
		{
			if (wall.gotLaser.match(string))
			{
				(nodes[wall.x][wall.y] as Node).addLasers(string);
			}
		}
		
		public function setGame(game:Game):void
		{
			this._game = game;
		
		}
		
		public function addPlayer(aPlayerHud:PlayerElement):void
		{
			for (var i:int = 0; i < nodes.length; ++i)
			{
				for (var j:int = 0; j < nodes[i].length; ++j)
				{
					var node:Node = nodes[i][j] as Node;
					if (node.boardElement != null)
					{
						if (node.boardElement.type == "startElement")
						{
							trace("added PLayer");
							var boardElement:StartElement = node.boardElement as StartElement;
							if (boardElement.id == aPlayerHud.playerData.id)
							{
								var playerElement:Player = new Player(aPlayerHud.playerData);
								aPlayerHud.playerBoardElement = playerElement;
								playerElement.initiate(this, node, aPlayerHud);
								if (GlobalConstants.TUTORIAL_PLAY)
								{
									playerElement.rotation = 90;
								}
								
							}
						}
					}
				}
			}
		
		}
		
		public function addTestPlayer(testPlayer:TestPlayer):void
		{
			for (var i:int = 0; i < nodes.length; ++i)
			{
				for (var j:int = 0; j < nodes[i].length; ++j)
				{
					var node:Node = nodes[i][j] as Node;
					if (node.boardElement != null)
					{
						if (node.boardElement.type == "startElement")
						{
							var boardElement:StartElement = node.boardElement as StartElement;
							if (boardElement.id == testPlayer.playerData.id)
							{
								testPlayer.initiate(this, node, null);
							}
						}
					}
				}
			}
		}
		
		public function getNode(xPos:int, yPos:int):Node
		{
			try
			{
				return nodes[xPos][yPos];
			}
			catch (e:Error)
			{
				return null;
			}
			return null;
		}
		
		public function moveFactory(onComplete:Function, registerIndex:int = -1):void
		{
			
			Logger.getInstance().log("Starting The Factory");
			Logger.getInstance().log("Move Conveyor Belts");
			
			this.registerIndex = registerIndex;
			this.onComplete = onComplete;
			
			doAction(new Array("conveyorBelt", "conveyorBelt2x", "conveyorBeltCorner"), aConveyorBelt1Finished, conveyorBelt1Finished);
		}
		
		public function aConveyorBelt1Finished(length:int, finishedFunction:Function):void
		{
			elementFinishedCounter++;
			
			if (elementFinishedCounter == length)
			{
				
				conveyorBelt1Finished();
			}
		}
		
		private function conveyorBelt1Finished():void
		{
			Logger.getInstance().log("Finished Conveyor Belts");
			Logger.getInstance().log("Move Conveyor Belts 2");
			doAction(new Array("conveyorBelt2x"), aConveyorBelt2Finished, conveyorBelt2Finished);
		}
		
		public function aConveyorBelt2Finished(length:int, finishedFunction:Function):void
		{
			elementFinishedCounter++;
			if (elementFinishedCounter == length)
			{
				conveyorBelt2Finished();
			}
		}
		
		public function conveyorBelt2Finished():void
		{
			Logger.getInstance().log("Finished Conveyor Belts 2");
			Logger.getInstance().log("Move Gears");
			doAction(new Array("rotateGear"), aGearFinished, rotateGearsFinished);
		}
		
		public function aGearFinished(length:int, finishedFunction:Function):void
		{
			elementFinishedCounter++;
			if (elementFinishedCounter == length)
			{
				rotateGearsFinished();
			}
		}
		
		private function rotateGearsFinished():void
		{
			Logger.getInstance().log("Finished Gears");
			Logger.getInstance().log("Start Shooting Lasers");
			Playscreen.gameStatus = 4;
			var timer:Timer = new Timer(1000, 1);
			timer.start();
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, function():void
				{
					timer.stop();
					shootLasers(onLasersFinished);
				});
		}
		
		private function shootLasers(onLasersFinished:Function):void
		{
			laserFinishedCounter = 0;
			var lasers:Array = new Array();
			for (var i:int = 0; i < nodes.length; ++i)
			{
				for (var j:int = 0; j < nodes[i].length; ++j)
				{
					var node:Node = nodes[i][j];
					if (node.robot != null)
					{
						lasers.push(node.robot);
					}
					
					for (var l:int = 0; l < node.laserArray.length; l++)
					{
						lasers.push(node.laserArray[l]);
					}
					
					/*if (node.hasLaserRight)
					   {
					   lasers.push(node.laserRight);
					   }
					   if (node.hasLaserDown)
					   {
					   lasers.push(node.laserDown);
					   }
					   if (node.hasLaserLeft)
					   {
					   lasers.push(node.laserLeft);
					   }
					   if (node.hasLaserUp)
					   {
					   lasers.push(node.laserUp);
					 }*/
				}
			}
			if (lasers.length == 0)
			{
				onLasersFinished();
			}
			
			for (var k:int = 0; k < lasers.length; ++k)
			{
				var aLaser:* = lasers[k];
				if (aLaser is PlayerBoardElement)
				{
					(aLaser as PlayerBoardElement).playerAction.fireLaser(aLaserFinished, lasers.length, onLasersFinished);
				}
				
				if (aLaser is Laser)
				{
					(aLaser as Laser).fireLaser(aLaserFinished, lasers.length, onLasersFinished);
				}
			}
		}
		
		private function aLaserFinished(length:int, onLasersFinished:Function):void
		{
			laserFinishedCounter++;
			if (laserFinishedCounter == length)
			{
				onLasersFinished();
			}
		}
		
		private function onLasersFinished():void
		{
			Logger.getInstance().log("Lasers Finished");
			Logger.getInstance().log("Doing Checkpoints and RepairElements");
			doAction(new Array("repairElement", "checkPoint"), aCheckpointFinished, checkPointsFinished);
		}
		
		public function aCheckpointFinished(length:int, finishedFunction:Function):void
		{
			elementFinishedCounter++;
			if (elementFinishedCounter == length)
			{
				checkPointsFinished();
			}
		}
		
		public function checkPointsFinished():void
		{
			Logger.getInstance().log("Finished Checkpoints and RepairElements");
			onComplete(registerIndex);
		}
		
		public function higlight(array:Array):void
		{
			for (var i:int = nodes.length - 1; i >= 0; --i)
			{
				for (var j:int = nodes[i].length - 1; j >= 0; --j)
				{
					var aNode:Node = nodes[i][j];
					for each (var type:String in array)
					{
						if (aNode.boardElement != null)
						{
							if (aNode.boardElement.type == type)
							{
								grid.setChildIndex(aNode, grid.numChildren - 1)
								aNode.boardElement.highlight();
							}
						}
					}
				}
			}
		}
		
		public function highLightTutorial(index:int):void
		{
			
			var string:String = "";
			var string2:String = "";
			switch (index)
			{
				case TutorialConstants.STAGE2: 
					string = "pit";
					break;
				
				case TutorialConstants.STAGE3: 
					string = "conveyorBelt";
					string2 = "rotateGear";
					
					break;
				
				case TutorialConstants.STAGE4: 
					string = "lasers";
					break;
				
				default:
			
			}
			
			for (var i:int = 0; i < nodes.length; i++)
			{
				for (var j:int = 0; j < nodes[i].length; j++)
				{
					var aNode:Node = nodes[i][j];

							if(aNode.boardElement != null){
						
								if (aNode.boardElement.type == string || aNode.boardElement.type == string2)
								{
									aNode.highlight();
									aNode.boardElement.highlight();
									
								}
								else
								{
									aNode.unhighlight();
									aNode.boardElement.unhighlight();
								}
							}else {
								if (string != "lasers") {
									if (aNode.hasLaserDown || aNode.hasLaserUp || aNode.hasLaserRight || aNode.hasLaserLeft) {
										aNode.unhighlight();
									}
								}
								
							}
								
							if (string == "lasers") {
									
								if (aNode.hasLaserDown || aNode.hasLaserUp || aNode.hasLaserRight || aNode.hasLaserLeft) {
									aNode.highlight();
								}
							}
							
				}
			}
		}
		
		public function unhiglight(array:Array):void
		{
			for (var i:int = 0; i < nodes.length; ++i)
			{
				for (var j:int = 0; j < nodes[i].length; ++j)
				{
					var aNode:Node = nodes[i][j];
					for each (var type:String in array)
					{
						if (aNode.boardElement != null)
						{
							if (aNode.boardElement.type == type)
							{
								aNode.boardElement.unhighlight();
							}
						}
					}
				}
			}
		}
		
		private function doAction(types:Array, aElementFinished:Function, finishedFunction:Function):void
		{
			elementFinishedCounter = 0;
			var activeNodes:Array = new Array();
			for (var i:int = 0; i < nodes.length; ++i)
			{
				for (var j:int = 0; j < nodes[i].length; ++j)
				{
					var node:Node = nodes[i][j];
					if (node.boardElement != null)
					{
						for each (var aType:String in types)
						{
							if (node.boardElement.type == aType)
							{
								activeNodes.push(node);
							}
						}
						
					}
				}
			}
			if (activeNodes.length == 0)
			{
				if (finishedFunction != null)
				{
					finishedFunction();
				}
			}
			for each (var aNode:Node in activeNodes)
			{
				aNode.boardElement.doAction(aNode.robot, aElementFinished, finishedFunction, activeNodes.length, registerIndex);
			}
		}
		
		public function get nodes():Array
		{
			return grid.nodes;
		}
		
		private function init():void
		{
			createGrid();
		}
		
		private function createGrid():void
		{
			grid = new Grid(this);
			this.addChild(grid);
		}
		
		public function get editable():Boolean
		{
			return _editable;
		}
		
		public function set editable(value:Boolean):void
		{
			_editable = value;
			if (editable == true)
			{
				this.addEventListener(MouseEvent.CLICK, onMapClick);
			}
			else
			{
				if (this.hasEventListener(MouseEvent.CLICK))
				{
					this.removeEventListener(MouseEvent.CLICK, onMapClick);
				}
			}
			
			_editable = value;
		}
		
		public function get game():Game
		{
			return _game;
		}
		
		private function onMapClick(e:MouseEvent):void
		{
			var gridPosX:int;
			var gridPosY:int;
			
			if (e.target is Node)
			{
				gridPosX = Math.floor(e.target.x / 60);
				gridPosY = Math.floor(e.target.y / 60);
			}
			if (e.target.parent is Node)
			{
				gridPosX = Math.floor(e.target.parent.x / 60);
				gridPosY = Math.floor(e.target.parent.y / 60);
			}
			
			var clickedNode:Node = grid.getNode(gridPosX, gridPosY);
			
			if (MapEditingTools.mayPutWalls || MapEditingTools.mayPutLasers)
			{
				MapEditingTools.getInstance().showNodeProperties(clickedNode);
				
			}
			else
			{
				if (clickedNode.boardElement == null)
				{
					if (MapEditingTools.selectedItem != null)
					{
						clickedNode.addBoardElement(MapEditingTools.selectedItem.type);
					}
				}
				else
				{
					if (MapEditingTools.mayErase)
					{
						clickedNode.removeBoardElement();
					}
					else
					{
						var clickedElement:BoardElement = clickedNode.boardElement;
						if (clickedElement != previosElement)
						{
							if (previosElement != null)
							{
								previosElement.deselect();
							}
						}
						
						if (clickedElement.selected)
						{
							clickedElement.deselect();
						}
						else
						{
							clickedElement.select();
						}
						
						previosElement = clickedElement;
					}
				}
				
			}
		}
	
	}

}