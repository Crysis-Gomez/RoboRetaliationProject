package maps.elements
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import maps.Map;
	import maps.Node;
	
	/**
	 * ...
	 * @author Jerry
	 */
	public class Laser extends Sprite
	{
		private var _id:int = 0;
		private var _type:String = "";
		private var _node:Node;
		
		[Embed(source="laser.png")]
		private var laserClass:Class;
		private var laserBitmap:Bitmap = new laserClass();
		private var map:Map;
		
		public function Laser(string:String, node:Node, map:Map)
		{
			this.map = map;
			type = string;
			_node = node;
		}
		
		public function draw():void
		{
			
			graphics.clear();
			graphics.beginBitmapFill(laserBitmap.bitmapData);
			graphics.drawRect(0, 0, 60, 30);
			graphics.endFill();
		
		}
		
		public function removeNode():void 
		{
			if (_node.contains(this))_node.removeChild(this);
		}
		
		public function addToNode():void
		{
			if (_node.contains(this)) return;
			
			_node.addChild(this);
			switch (type)
			{
				case "up": 
					this.x = 0;
					this.y = 0;
					
					break;
				
				case "down": 
					this.x = 60;
					this.y = 60;
					this.rotation = 180;
					
					break;
				
				case "left": 
					this.x = 0;
					this.y = 60;
					this.rotation = -90;
					
					break;
				
				case "right": 
					this.x = 60;
					this.y = 0;
					this.rotation = 90;
					
					break;
			
			}
			draw();
		}
		
		public function fireLaser(aLaserFinished:Function, length:uint, onLasersFinished:Function):void 
		{
			var direction:Point = getDirection();
			if (_node.robot != null && !_node.robot.destroyed) {
				fire(aLaserFinished, length, onLasersFinished, _node);
				return;
			}
			var check:Array = checkIfInSigh(_node , getNextNode(direction, _node), direction);
			if (check[0]) {
				fire(aLaserFinished, length, onLasersFinished, check[1] as Node);
				return
			}
			
			
			aLaserFinished(length, onLasersFinished);
		}
		
		private function fire(aLaserFinished:Function, length:uint, onLasersFinished:Function, node:Node):void 
		{
			var sprite:Sprite = new Sprite();
			sprite.graphics.lineStyle(3, 0xFF0000);
			sprite.graphics.moveTo(_node.x + 30, _node.y + 30);
			sprite.graphics.lineTo(node.x + 30, node.y + 30);
			map.addChildAt(sprite,1);
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
		
		public function exlpode():void 
		{
			
		}
		
		private function checkIfInSigh(currentNode:Node, nextNode:Node, direction:Point):Array 
		{
			if (nextNode == null) {
				return new Array(false);
			}
			if (collideWithWalls(currentNode, nextNode, direction)) {
				return new Array(false);
			}
			if (nextNode.robot != null && !nextNode.robot.destroyed) {
				return new Array(true,nextNode);
			}
			return checkIfInSigh(nextNode, getNextNode(direction, nextNode), direction);
		}
		
		private function collideWithWalls(currentNode:Node, nextNode:Node, direction:Point):Boolean 
		{
			switch (direction.x)
			{
				case 1: 
					if (currentNode.hasWallRight || nextNode.hasWallLeft)
						return true;
					break;
				case-1: 
					if (currentNode.hasWallLeft || nextNode.hasWallRight)
						return true;
					break;
			}
			switch (direction.y)
			{
				case 1: 
					if (currentNode.hasWallDown || nextNode.hasWallUp)
						return true;
					break;
				case-1: 
					if (currentNode.hasWallUp || nextNode.hasWallDown)
						return true;
					break;
			}
			return false;
		}
		
		private function getNextNode(direction:Point, node:Node):Node 
		{
			return map.getNode(node.xPos + direction.x, node.yPos + direction.y);
		}
		
		private function getDirection():Point 
		{
			var direction:Point
			switch (type)
			{
				case "left": 
					direction = new Point(1, 0);
					break;
				case "down": 
					direction = new Point(0, -1);
					break;
				case "right": 
					direction = new Point(-1, 0);
					break;
				case "up": 

					direction = new Point(0, 1);
					break;
			}
			return direction;
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		public function set type(value:String):void 
		{
			_type = value;
		}
	
	}

}