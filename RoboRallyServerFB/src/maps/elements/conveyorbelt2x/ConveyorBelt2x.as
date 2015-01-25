package maps.elements.conveyorbelt2x 
{
	import core.Game;
	import flash.display.Bitmap;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import maps.elements.base.ActionCard;
	import maps.elements.base.BoardElement;
	import maps.elements.player.base.PlayerBoardElement;
	import maps.Node;
	import screens.Playscreen;
	import utils.AnimateComponent;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ConveyorBelt2x extends BoardElement 
	{
		[Embed(source = "assets/conveyorbelt2.png")] private var conveyorBeltClass1:Class;
		[Embed(source = "assets/conveyorbelt2Left.png")] private var conveyorBeltClassLeft:Class;
		[Embed(source = "assets/conveyorbelt2Up.png")] private var conveyorBeltClassUp:Class;
		[Embed(source = "assets/conveyorbelt2Down.png")] private var conveyorBeltClassDown:Class;
		
		
		private var conveyorBeltBitmap:Bitmap = new conveyorBeltClass1();
		private var conveyorBeltLeftBitmap:Bitmap = new conveyorBeltClassLeft();
		private var conveyorBeltUpBitmap:Bitmap = new conveyorBeltClassUp();
		private var conveyorBeltDownBitmap:Bitmap = new conveyorBeltClassDown();
	
		
		
		
		private var animate:AnimateComponent;
		public var moving:Boolean = true;
		
		private var _id:int = 0;
		
		private var bitmaps:Array = new Array(conveyorBeltBitmap, conveyorBeltDownBitmap,conveyorBeltLeftBitmap,conveyorBeltUpBitmap);
		
		public function ConveyorBelt2x(selectable:Boolean, deletable:Boolean) 
		{
			animate = new AnimateComponent((bitmaps[id] as Bitmap), 60, 60, this);
			super(selectable, deletable);
			type = "conveyorBelt2x";
			
			
		
		}

		
		override public function draw():void 
		{
			super.draw();
			graphics.clear();
			graphics.beginBitmapFill(animate.currentBitmap.bitmapData);
			graphics.drawRect(0, 0, 60, 60);
			graphics.endFill();
			
		
		}
		
		
		public function get id():int 
		{
			return _id;
		}
		
		public function set id(value:int):void 
		{
			_id = value;
			if (id > 3 || id < 0) {
				id = 0;
			}
			animate = new AnimateComponent((bitmaps[id] as Bitmap), 60, 60, this);
			draw();
		}
		
	
		override public function toXML():String 
		{
			var xmlString:String = "";
			xmlString += "<boardelement>";
			xmlString += "<type>" + type + "</type>";
			xmlString += "<propertie>" + id + "</propertie>";
			xmlString += "<x>" + xPos + "</x>";
			xmlString += "<y>" + yPos + "</y>";
			xmlString += "</boardelement>";
			return xmlString;
		}
		
		override public function setPropertie(propertie:*):void 
		{
			id = propertie;
			
		
		}
		
		
		
	override public function switchDirection(aItemFinished:Function, itemsPlayed:Array,game:Game):void
		{
			var feedbackTimer:Timer = new Timer(1000 / 30, 30*2);
			feedbackTimer.start();
			feedbackTimer.addEventListener(TimerEvent.TIMER, function():void
				{
				
					if (feedbackTimer.currentCount == feedbackTimer.repeatCount)
					{
						var actionCard:ActionCard = new ActionCard();
						actionCard.x = xPos*60 + (game.currentScreen as Playscreen).map.x;
						actionCard.y = yPos*60 + (game.currentScreen as Playscreen).map.y;
						game.addElement(actionCard);
						
						feedbackTimer.stop();
						var node:Node = (parent as Node);
						switch (id)
						{
							case 0: 
								changeLeftNodes(node, 2);
								changeRighNodes(node, 2);
								id = 2;
								break;
							case 1: 
								changeUpNodes(node, 3);
								changeDownNodes(node, 3);
								id = 3;
								break;
							case 2: 
								changeLeftNodes(node, 0);
								changeRighNodes(node, 0);
								id = 0;
								break;
							case 3: 
								changeUpNodes(node, 1);
								changeDownNodes(node, 1);
								id = 1;
								break;
						}
						aItemFinished(itemsPlayed);
					}
				});
				
		}
		
		
		private function changeRighNodes(node:Node, switchtoid:int):void
		{
			var i:int = 1;
			while (true)
			{
				var node:Node = node.map.getNode((node.xPos + i), (node.yPos));
				if (node == null)
					return;
				if (node.boardElement == null)
					return;
				if (node.boardElement.type == type)
				{
					if ((node.boardElement as ConveyorBelt2x).id == _id) {
						(node.boardElement as ConveyorBelt2x).id = switchtoid;
					}
					else
						return;
				}
				else
				{
					return;
				}
				//++i;
			}
		}
		
		private function changeLeftNodes(node:Node, switchtoid:int):void
		{
			var i:int = 1;
			while (true)
			{
				var node:Node = node.map.getNode((node.xPos - i), (node.yPos));
				if (node == null)
					return;
				if (node.boardElement == null)
					return;
				if (node.boardElement.type == type)
				{
					if ((node.boardElement as ConveyorBelt2x).id == _id) {
						(node.boardElement as ConveyorBelt2x).id = switchtoid;
						trace(node);
					}
					else
						return;
				}
				else
				{
					return;
				}
				//++i;
			}
		}
		
		private function changeUpNodes(node:Node, switchtoid:int):void
		{
			var i:int = 1;
			while (true)
			{
				var node:Node = node.map.getNode((node.xPos), (node.yPos-i));
				if (node == null)
					return;
				if (node.boardElement == null)
					return;
				if (node.boardElement.type == type)
				{
					if ((node.boardElement as ConveyorBelt2x).id == _id)
						(node.boardElement as ConveyorBelt2x).id = switchtoid;
					else
						return;
				}
				else
				{
					return;
				}
				//++i;
			}
		}
		
		private function changeDownNodes(node:Node, switchtoid:int):void
		{
			var i:int = 1;
			while (true)
			{
				var node:Node = node.map.getNode((node.xPos), (node.yPos+i));
				if (node == null)
					return;
				if (node.boardElement == null)
					return;
				if (node.boardElement.type == type)
				{
					if ((node.boardElement as ConveyorBelt2x).id == _id)
						(node.boardElement as ConveyorBelt2x).id = switchtoid;
					else
						return;
				}
				else
				{
					return;
				}
				//++i;
			}
		}
		
		override public function doAction(robot:PlayerBoardElement, aElementFinished:Function, finishedFunction:Function, length:uint, registerIndex:int):void 
		{
			if (robot != null) {
				animate.start(null,0,null );
				switch(id) {
					case 0:
						robot.playerAction.move(new Point(1,0), 1, "conveyorBel2x", aElementFinished, length, finishedFunction);
						break;
					case 1:
						robot.playerAction.move(new Point(0,1), 1, "conveyorBelt2x", aElementFinished, length, finishedFunction);
						break;
					case 2:
						robot.playerAction.move(new Point(-1,0), 1, "conveyorBelt2x", aElementFinished, length, finishedFunction);
						break;
					case 3:
						robot.playerAction.move(new Point(0,-1), 1, "conveyorBelt2x", aElementFinished, length, finishedFunction);
						break;
				}
				
			} else {
				animate.start(aElementFinished, length, finishedFunction);
			}
			super.doAction(robot, aElementFinished, finishedFunction, length, registerIndex);
		}
	}

}