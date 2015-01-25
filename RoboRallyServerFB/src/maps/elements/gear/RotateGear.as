package maps.elements.gear
{
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.utils.Timer;
	import maps.elements.base.BoardElement;
	import maps.elements.player.base.PlayerBoardElement;
	import utils.AnimateComponent;
	
	/**
	 * ...
	 * @author Jerry
	 */
	public class RotateGear extends BoardElement
	{
		
		[Embed(source="assets/RotationGearLeftSmall.png")]
		private var rotateGearLeftClass:Class;
		[Embed(source="assets/RotationGearRightSmall.png")]
		private var rotateGearRightClass:Class;
		
		private var leftGearBitmap:Bitmap = new rotateGearLeftClass();
		private var rightGearBitmap:Bitmap = new rotateGearRightClass();
		
		private var _id:int = 0;
		private var animate:AnimateComponent;
		private var bitmaps:Array = new Array(leftGearBitmap, rightGearBitmap);
		
		public function RotateGear(selectable:Boolean, deletable:Boolean)
		{
			super(selectable, deletable);
			type = "rotateGear";
			this.x += 30;
			this.y += 30;
		}
		
		override public function draw():void
		{
			super.draw();
			
			var mat:Matrix = new Matrix();
			mat.translate(-30, -30);
			
			graphics.clear();
			graphics.beginBitmapFill(bitmaps[id].bitmapData, mat, false, true);
			graphics.drawRect(-30, -30, 60, 60);
			graphics.endFill();
		}
		
		public function get id():int
		{
			return _id;
		}
		
		public function set id(value:int):void
		{
			_id = value;
			if (id > 1 || id < 0)
			{
				id = 0;
			}
			
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
			draw();
		}
		
		public function rotate(amount:Number, aElementFinished:Function = null, length:uint = 0, finishedFunction:Function = null):void
		{
			var timer:Timer = new Timer(1000 / 30);
			timer.start();
			var checkValue:int = 0;
			var rotateSpeed:int = amount / 45;
			timer.addEventListener(TimerEvent.TIMER, function():void
				{
					draw();
					checkValue += rotateSpeed;
					rotation += rotateSpeed;
					if (checkValue == amount)
					{
						timer.stop();
						if (aElementFinished != null) {
							aElementFinished(length, finishedFunction);
						}
					}
				});
		}
		
		override public function doAction(robot:PlayerBoardElement, aElementFinished:Function, finishedFunction:Function, length:uint, registerIndex:int):void
		{
			if (robot != null)
			{
				switch (id)
				{
					case 0:
						rotate( -90);
						robot.playerAction.rotate(-90, "rotateGear", aElementFinished, length, finishedFunction);
						break;
					case 1: 
						robot.playerAction.rotate(90, "rotateGear", aElementFinished, length, finishedFunction);
						rotate(90);
						break;
				}
			}
			else
			{
				if (id == 0) {
					rotate(-90,  aElementFinished, length, finishedFunction);
				}
				else {
					rotate(90, aElementFinished, length, finishedFunction);
				}
			}
			
			super.doAction(robot, aElementFinished, finishedFunction, length, registerIndex);
		}
	
	}

}