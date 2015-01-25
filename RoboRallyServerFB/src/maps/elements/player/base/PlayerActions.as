package maps.elements.player.base
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import logger.Logger;
	import maps.elements.conveyorbelt.ConveyorBeltCorner;
	import maps.elements.player.TestPlayer;
	import maps.Map;
	import maps.Node;
	import models.data.CardData;
	
	/**
	 * ...
	 * @author ...
	 */
	public class PlayerActions
	{
		private var map:Map;
		private var playerBoardElement:PlayerBoardElement;
		private var _currentNode:Node;
		private var cardFinished:Function;
		private var registerIndex:int;
		
		public function PlayerActions(playerBoardElement:PlayerBoardElement)
		{
			this.playerBoardElement = playerBoardElement;
		
		}
		
		public function registerRobotToNode():void
		{
			var xPos:int = Math.floor(playerBoardElement.x / 60);
			var yPos:int = Math.floor(playerBoardElement.y / 60);
			
			var tempNode:Node = map.getNode(xPos, yPos);
			if (tempNode != null)
			{
				if (tempNode != currentNode)
				{
					if (currentNode != null)
					{
						if (currentNode.robot == playerBoardElement) {
							currentNode.robot = null;
						}
						
					}
					_currentNode = tempNode;
					if (_currentNode.pickup != null) {
						playerBoardElement.addPickUp(_currentNode.pickup);
						_currentNode.removePickUp();
					}
					_currentNode.robot = playerBoardElement;
				}
			}
		}
		
		public function rotateRobot(card:CardData, cardFinished:Function, registerIndex:int):void
		{
			this.registerIndex = registerIndex;
			this.cardFinished = cardFinished;
			
			rotate(card.amount, "card");
		}
		
		public function rotate(amount:Number, typeObject:String, elementFinished:Function = null, length:uint = 0, finishedFunction:Function = null):void
		{
			var timer:Timer = new Timer(1000 / 30);
			timer.start();
			var checkValue:int = 0;
			var rotateSpeed:int = amount / 45;
			
			Logger.getInstance().log("Rotating robot " + amount + " degrees by " + typeObject);
			
			timer.addEventListener(TimerEvent.TIMER, function():void
				{
					checkValue += rotateSpeed;
					playerBoardElement.rotation += rotateSpeed;
					if (checkValue == amount)
					{
						timer.stop();
						registerRobotToNode();
						Logger.getInstance().log("Finished rotating robot");
						if (typeObject == "card")
						{
							cardFinished(registerIndex);
						}
						else if ("rotateGear")
						{
							elementFinished(length, finishedFunction);
							
						}
					}
				});
		}
		
		public function moveRobot(card:CardData, cardFinished:Function, registerIndex:int):void
		{
			this.registerIndex = registerIndex;
			this.cardFinished = cardFinished;
			
			var direction:Point = getDirection();
			
			if (card.action == "back")
			{
				direction.x *= -1;
				direction.y *= -1;
			}
			move(direction, card.amount, "card");
		}
		
		public function move(direction:Point, argument:Number, objectType:String, aElementFinished:Function = null, length:uint = 0, finishedFunction:Function = null):void
		{
			var amount:int = argument;
			
			var nextNode:Node = getNextNode(direction, currentNode);
			//Found the bug of not colliding with walls that are on the edge of the board next node will be then null 
			//but when nextnode will be null we are asuming we will mov of the board
			if (collideWithWalls(currentNode, nextNode, direction))
			{
				Logger.getInstance().log("Player collided with a wall");
				cardFinished(registerIndex);
				return;
			}
			
			if (nextNode == null)
			{
				Logger.getInstance().log("Player falls of the board");
				var point:Point = new Point(currentNode.x + direction.x * 60, currentNode.y + direction.y * 60);
				moveTo(point, direction, 1, "moveOfTheBoard", aElementFinished, length, finishedFunction);
				return;
			}
			
			
			
			if (nextNode.boardElement != null)
			{
				if (nextNode.boardElement.type == "pit")
				{
					Logger.getInstance().log("Player falls into a pit");
					moveTo(new Point(nextNode.x, nextNode.y), direction, 1, "moveOfTheBoard", aElementFinished, length, finishedFunction);
					return;
				}
			}
			
			if (objectType == "conveyorBelt" || objectType == "conveyorBelt2x" || objectType == "conveyorBeltCorner" || objectType == "conveyorBeltCorner2X")
			{
				//moveRobotByConveyor(direction, argument, )
				if (nextNode.robot != null)
				{
					if (nextNode.boardElement != null)
					{
						if (nextNode.boardElement.type.substring(0, 8) == "conveyor")
						{
							if (nextNode.boardElement.type.substring(12, 18) == "Corner") {
								rotate(nextNode.boardElement.getDirection(), objectType, aElementFinished, length, finishedFunction);
								moveTo(new Point(nextNode.x, nextNode.y), direction, 1, objectType, null, 0, null);
								return
							} else {
								moveTo(new Point(nextNode.x, nextNode.y), direction, 1, "conveyorBelt", aElementFinished, length, finishedFunction);
								return;
							}
						}
						else
						{
							
							nextNode.robot.playerAction.move(direction, 1, "push", null, 0, null);
							moveTo(new Point(nextNode.x, nextNode.y), direction, 1, objectType, aElementFinished, length, finishedFunction);
							return
						}
					}
					else
					{
						nextNode.robot.playerAction.move(direction, 1, "push", null, 0, null);
						moveTo(new Point(nextNode.x, nextNode.y), direction, 1, objectType, aElementFinished, length, finishedFunction);
						return;
					}
				}
				else
				{
					if (nextNode.boardElement != null) {
						if (nextNode.boardElement.type.substring(0, 8) == "conveyor") {
							if (nextNode.boardElement.type.substring(12, 18) == "Corner") {
								rotate(nextNode.boardElement.getDirection(), objectType, aElementFinished, length, finishedFunction);
								moveTo(new Point(nextNode.x, nextNode.y), direction, 1, objectType, null, 0, null);
								return
							} else {
								moveTo(new Point(nextNode.x, nextNode.y), direction, 1, "conveyorBelt", aElementFinished, length, finishedFunction);
								return;
							}
							moveTo(new Point(nextNode.x, nextNode.y), direction, 1, "conveyorBelt", aElementFinished, length, finishedFunction);
							return;
						} else {
							moveTo(new Point(nextNode.x, nextNode.y), direction, 1, "conveyorBelt", aElementFinished, length, finishedFunction);
							return;
						}
					} else {
						moveTo(new Point(nextNode.x, nextNode.y), direction, 1, "conveyorBelt", aElementFinished, length, finishedFunction);
						return
					}
				}
				return;
			}
			
			if (nextNode.robot != null)
			{
				if (nextNode.robot.playerAction.pushable(direction))
				{
					Logger.getInstance().log("Pushing robot from " + nextNode.robot.playerData.id + " " + nextNode.robot.playerData.name);
					nextNode.robot.playerAction.move(direction, 1, "push");
				}
				else
				{
					Logger.getInstance().log("Can't push the other robot");
					cardFinished(registerIndex);
					return;
				}
			}
			moveTo(new Point(nextNode.x, nextNode.y), direction, amount, objectType, aElementFinished, length, finishedFunction);
			return;
		}
		
		private function getNextNode(direction:Point, node:Node):Node
		{
			return map.getNode(node.xPos + direction.x, node.yPos + direction.y)
		}
		
		private function pushable(direction:Point):Boolean
		{
			return true;
		}
		
		public function fireLaser(aLaserFinished:Function, length:uint, onLasersFinished:Function):void
		{
			var direction:Point = getDirection();
			if (currentNode.robot != null && currentNode.robot != playerBoardElement && !currentNode.robot.destroyed)
			{
				fire(aLaserFinished, length, onLasersFinished, currentNode);
				return;
			}
			var check:Array = checkIfInSigh(currentNode, getNextNode(direction, currentNode), direction);
			if (check[0])
			{
				fire(aLaserFinished, length, onLasersFinished, check[1] as Node);
				return
			}
			
			aLaserFinished(length, onLasersFinished);
		}
		
		public function setMap(map:Map):void
		{
			this.map = map;
		
		}
		
		private function fire(aLaserFinished:Function, length:uint, onLasersFinished:Function, node:Node):void
		{
			var sprite:Sprite = new Sprite();
			sprite.graphics.lineStyle(3, 0xFF0000);
			sprite.graphics.moveTo(currentNode.x + 30, currentNode.y + 30);
			sprite.graphics.lineTo(node.x + 30, node.y + 30);
			map.addChildAt(sprite, 1);
			var timer:Timer = new Timer(1000, 1);
			timer.start();
			node.robot.doDamage();
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, function():void
				{
					timer.stop();
					map.removeChild(sprite);
					aLaserFinished(length, onLasersFinished);
				});
		
		}
		
		private function checkIfInSigh(currentNode:Node, nextNode:Node, direction:Point):Array
		{
			if (nextNode == null)
			{
				return new Array(false);
			}
			if (collideWithWalls(currentNode, nextNode, direction))
			{
				return new Array(false);
			}
			if (nextNode.robot != null && !nextNode.robot.destroyed)
			{
				return new Array(true, nextNode);
			}
			return checkIfInSigh(nextNode, getNextNode(direction, nextNode), direction);
		}
		
		public function getDirection():Point
		{
			var direction:Point
			switch (playerBoardElement.rotation)
			{
				case 0: 
				case 360: 
					direction = new Point(1, 0);
					break;
				case 90: 
				case-270: 
					direction = new Point(0, 1);
					break;
				case 180: 
				case-180: 
					direction = new Point(-1, 0);
					break;
				case 270: 
				case-90: 
					direction = new Point(0, -1);
					break;
			}
			return direction;
		}
		
		private function collideWithWalls(currentNode:Node, nextNode:Node, direction:Point):Boolean
		 {
            switch (direction.x)
            {
                case 1:
                    if (nextNode != null) {
						if (nextNode.hasWallLeft) {
							return true;
						}
					}
					if (currentNode.hasWallRight)
                        return true;
                    break;
                case-1:
					if (nextNode != null) {
						if (nextNode.hasWallRight) {
							return true;
						}
					}
                    if (currentNode.hasWallLeft)
                        return true;
                    break;
            }
            switch (direction.y)
            {
                case 1:
                    if (nextNode != null) {
						if (nextNode.hasWallUp) {
							return true;
						}
					}
					if (currentNode.hasWallDown)
                        return true;
                    break;
                case-1:
					if (nextNode != null) {
						if (nextNode.hasWallDown) {
							return true;
						}
					}
                    if (currentNode.hasWallUp)
                        return true;
                    break;
            }
            return false;
        }
		
		private function moveTo(nextNode:Point, direction:Point, amount:Number, objectType:String, aElementFinished:Function, length:uint, finishedFunction:Function):void
		{
			var timer:Timer = new Timer(1000 / 30);
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, function():void
				{
					
					playerBoardElement.x += GlobalConstants.speed * direction.x;
					playerBoardElement.y += GlobalConstants.speed * direction.y;
					
					registerRobotToNode();
					if (playerBoardElement.x - 30 == nextNode.x && playerBoardElement.y - 30 == nextNode.y)
					{
						
						timer.stop();
						if (amount > 1)
						{
							move(direction, --amount, "card");
						}
						else
						{
							if (aElementFinished != null)
							{
								//aElementFinished(length, finishedFunction);
								
								if (objectType == "moveOfTheBoard")
								{
									currentNode.robot = null;
									playerBoardElement.destroyed = true;
								}
								
								aElementFinished(length, finishedFunction);
								return;
							}
							
							if (objectType == "card")
							{
								cardFinished(registerIndex);
							}
							if (objectType == "moveOfTheBoard")
							{
								currentNode.robot = null;
								playerBoardElement.destroyed = true;
								cardFinished(registerIndex);
							}
						}
					}
				});
		}
		
		public function get currentNode():Node
		{
			return _currentNode;
		}
	}

}