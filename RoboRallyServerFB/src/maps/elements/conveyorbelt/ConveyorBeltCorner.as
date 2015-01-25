package maps.elements.conveyorbelt
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	import maps.elements.base.BoardElement;
	import maps.elements.player.base.PlayerBoardElement;
	import utils.AnimateComponent;
	
	/**
	 * ...
	 * @author Jerry
	 */
	public class ConveyorBeltCorner extends BoardElement
	{
		
		[Embed(source="assets/conveyorbeltRotateRightDown.png")]
		private var conveyorBeltRotateRightDown:Class;
		[Embed(source="assets/conveyorbeltRotateRightUp.png")]
		private var conveyorBeltRotateRightUp:Class;
		[Embed(source="assets/conveyorbeltRotateLeftDown.png")]
		private var conveyorBeltRotateLeftDown:Class;
		[Embed(source="assets/conveyorbeltRotateLeftUp.png")]
		private var conveyorBeltRotateLeftUp:Class;
		
		[Embed(source="assets/conveyorbeltRotateDownRight.png")]
		private var conveyorBeltRotateDownRight:Class;
		[Embed(source="assets/conveyorbeltRotateDownLeft.png")]
		private var conveyorBeltRotateDownLeft:Class;
		[Embed(source="assets/conveyorbeltRotateUpRight.png")]
		private var conveyorBeltRotateUpRight:Class;
		[Embed(source="assets/conveyorbeltRotateUpLeft.png")]
		private var conveyorBeltRotateUpLeft:Class;
		
		private var conveyorBeltRotateRightDownBitmap:Bitmap = new conveyorBeltRotateRightDown();
		private var conveyorBeltRotateRightUpBitmap:Bitmap = new conveyorBeltRotateRightUp();
		private var conveyorBeltRotateLeftDownBitmap:Bitmap = new conveyorBeltRotateLeftDown();
		private var conveyorBeltRotateLeftUpBitmap:Bitmap = new conveyorBeltRotateLeftUp();
		
		private var conveyorBeltRotateDownRightBitmap:Bitmap = new conveyorBeltRotateDownRight();
		private var conveyorBeltRotateDownLeftBitmap:Bitmap = new conveyorBeltRotateDownLeft();
		private var conveyorBeltRotateUpRightBitmap:Bitmap = new conveyorBeltRotateUpRight();
		private var conveyorBeltRotateUpLeftBitmap:Bitmap = new conveyorBeltRotateUpLeft();
		
		private var animate:AnimateComponent;
		public var moving:Boolean = true;
		
		private var _id:int = 0;
		
		private var bitmaps:Array = new Array(conveyorBeltRotateRightDownBitmap, conveyorBeltRotateRightUpBitmap, conveyorBeltRotateLeftDownBitmap, conveyorBeltRotateLeftUpBitmap, conveyorBeltRotateDownRightBitmap, conveyorBeltRotateDownLeftBitmap, conveyorBeltRotateUpRightBitmap, conveyorBeltRotateUpLeftBitmap);
		
		public function ConveyorBeltCorner(selectable:Boolean, deletable:Boolean)
		{
			animate = new AnimateComponent((bitmaps[id] as Bitmap), 60, 60, this);
			super(selectable, deletable);
			type = "conveyorBeltCorner";
		}
		
		override public function draw():void
		{
			super.draw();
			
			graphics.clear();
			graphics.beginBitmapFill((bitmaps[id] as Bitmap).bitmapData);
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
			if (id > 7 || id < 0)
			{
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
			animate = new AnimateComponent((bitmaps[id] as Bitmap), 60, 60, this);
			draw();
		}
		
		override public function doAction(robot:PlayerBoardElement, aElementFinished:Function, finishedFunction:Function, length:uint, registerIndex:int):void
		{
			if (robot != null)
			{
				animate.start();
				switch (id)
				{
					case 0: 
						//robot.playerAction.rotate(90, "conveyorBeltCorner", aElementFinished, length, finishedFunction);
						robot.playerAction.move(new Point(0, 1), 1, "conveyorBeltCorner", aElementFinished, length, finishedFunction);
						break;
					case 1: 
						//robot.playerAction.rotate(-90, "conveyorBeltCorner", aElementFinished, length, finishedFunction);
						robot.playerAction.move(new Point(0, -1), 1, "conveyorBeltCorner", aElementFinished, length, finishedFunction);
						break;
					case 2: 
						//robot.playerAction.rotate(-90, "conveyorBeltCorner", aElementFinished, length, finishedFunction);
						robot.playerAction.move(new Point(0, 1), 1, "conveyorBeltCorner", aElementFinished, length, finishedFunction);
						break;
					case 3: 
						//robot.playerAction.rotate(90, "conveyorBeltCorner", aElementFinished, length, finishedFunction);
						robot.playerAction.move(new Point(0, -1), 1, "conveyorBeltCorner", aElementFinished, length, finishedFunction);
						break;
					case 4: 
						//robot.playerAction.rotate(-90, "conveyorBeltCorner", aElementFinished, length, finishedFunction);
						robot.playerAction.move(new Point(1, 0), 1, "conveyorBeltCorner", aElementFinished, length, finishedFunction);
						break;
					case 5: 
						//robot.playerAction.rotate(90, "conveyorBeltCorner", aElementFinished, length, finishedFunction);
						robot.playerAction.move(new Point(-1, 0), 1, "conveyorBeltCorner", aElementFinished, length, finishedFunction);
						break;
					case 6: 
						//robot.playerAction.rotate(90, "conveyorBeltCorner", aElementFinished, length, finishedFunction);
						robot.playerAction.move(new Point(1, 0), 1, "conveyorBeltCorner", aElementFinished, length, finishedFunction);
						break;
					case 7: 
						//robot.playerAction.rotate(-90, "conveyorBeltCorner", aElementFinished, length, finishedFunction);
						robot.playerAction.move(new Point(-1, 0), 1, "conveyorBeltCorner", aElementFinished, length, finishedFunction);
						break;
				}
				
			}
			else
			{
				animate.start(aElementFinished, length, finishedFunction);
			}
			super.doAction(robot, aElementFinished, finishedFunction, length, registerIndex);
		} 
		
		override public function getDirection():int 
		{
			var direction:int = 0;
			switch (id)
				{
					case 0: 
						direction = 90;
						break;
					case 1: 
						direction = -90;						
					break;
					case 2: 
						direction = -90;
						break;
					case 3: 
						direction = 90;
						break;
					case 4: 
						direction = -90;
						break;
					case 5: 
						direction = 90;
						break;
					case 6: 
						direction = 90;
						break;
					case 7: 
						direction = -90;
						break;
				}
			
			return direction;
		}
	
	}

}