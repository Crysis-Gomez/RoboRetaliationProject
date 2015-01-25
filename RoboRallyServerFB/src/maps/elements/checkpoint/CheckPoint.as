package maps.elements.checkpoint
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import maps.elements.base.BoardElement;
	import maps.elements.checkpoint.util.PieChart;
	import maps.elements.checkpoint.util.PieChartSliceInfo;
	import maps.elements.player.base.PlayerBoardElement;
	import models.data.PlayerData;
	import utils.AnimateComponent;
	
	/**
	 * ...
	 * @author Jerry
	 */
	public class CheckPoint extends BoardElement
	{
		
		[Embed(source="assets/checkpoint1.png")]
		private var checkPoint1Class:Class;
		[Embed(source="assets/checkpoint2.png")]
		private var checkPoint2Class:Class;
		[Embed(source="assets/checkpoint3.png")]
		private var checkpoint3Class:Class;
		[Embed(source="assets/checkpoint4.png")]
		private var checkpoint4Class:Class;
			[Embed(source="assets/checkpoint5.png")]
		private var checkpoint5Class:Class;
		
		private var checkPoint1Bitmap:Bitmap = new checkPoint1Class();
		private var checkPoint2Bitmap:Bitmap = new checkPoint2Class();
		private var checkPoint3Bitmap:Bitmap = new checkpoint3Class();
		private var checkPoint4Bitmap:Bitmap = new checkpoint4Class();
		private var checkPoint5Bitmap:Bitmap = new checkpoint5Class();
		
		private var animate:AnimateComponent;
		public var moving:Boolean = true;
		
		private var _id:int = 0;
		
		private var bitmaps:Array = new Array(checkPoint1Bitmap, checkPoint2Bitmap, checkPoint3Bitmap,checkPoint4Bitmap,checkPoint5Bitmap);
		private var checkpointMarker:PieChart;
		private var element:Sprite;
		private var playersOnCheckPoint:Array = new Array();
		
		public function CheckPoint(selectable:Boolean, deletable:Boolean)
		{
			
			type = "checkPoint";
			
			element = new Sprite();
			
			checkpointMarker = new PieChart();
			checkpointMarker.autoBalance = true;
			checkpointMarker.addSlice("", 100, 0x000000);
			checkpointMarker.radius = 20;
			checkpointMarker.x = 30;
			checkpointMarker.setOuterBorder(1, 0, 1);
			checkpointMarker.y = 30;
			checkpointMarker.draw();
			checkpointMarker.mouseEnabled = false;
			this.addChild(checkpointMarker);
			addChild(element);
			checkpointMarker.mouseEnabled = false;
			element.mouseEnabled = false;
			
			super(selectable, deletable);
		}
		
		override public function draw():void
		{
			super.draw();
			
			element.graphics.clear();
			element.graphics.beginBitmapFill((bitmaps[id] as Bitmap).bitmapData);
			element.graphics.drawRect(0, 0, 60, 60);
			element.graphics.endFill();
		
		}
		
		public function get id():int
		{
			return _id;
		}
		
		public function set id(value:int):void
		{
			_id = value;
			if (id > 4 || id < 0)
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
		}
		
		override public function doAction(robot:PlayerBoardElement, aElementFinished:Function, finishedFunction:Function, length:uint, registerIndex:int):void
		{
			if (robot != null && !robot.destroyed)
			{
				robot.setCheckPoint();
				robot.resolveCheckPoint(id);
			}
			aElementFinished(length, finishedFunction);
			super.doAction(robot, aElementFinished, finishedFunction, length, registerIndex);
		}
		
		public function addPlayer(playerData:PlayerData):void
		{
			for each (var aPlayerData:PlayerData in playersOnCheckPoint)
			{
				if (aPlayerData.id == playerData.id)
				{
					return;
				}
			}
			
			playersOnCheckPoint.push(playerData);
			
			checkpointMarker.removeAllSlices();
			checkpointMarker.destroy();
			
			for each (var aPlayerData2:PlayerData in playersOnCheckPoint)
			{
				checkpointMarker.addSlice("", 100 / playersOnCheckPoint.length, GlobalConstants.COLORS[aPlayerData2.id - 1]);
			}
			if (playersOnCheckPoint.length >= 2)
			{
				checkpointMarker.setSliceBorder(1, 0, 1);
			}
			checkpointMarker.draw();
		}
		
		public function removePlayer(playerData:PlayerData):void
		{
			for (var i:int = 0; i < playersOnCheckPoint.length; ++i)
			{
				var aPlayerData:PlayerData = playersOnCheckPoint[i];
				if (aPlayerData.id == playerData.id)
					playersOnCheckPoint.splice(i, 1);
			}
			checkpointMarker.removeAllSlices();
			checkpointMarker.destroy();
			
			if (playersOnCheckPoint.length == 0)
				checkpointMarker.addSlice("", 100, 0x000000);
			
			for each (var aPlayerData2:PlayerData in playersOnCheckPoint)
			{
				checkpointMarker.addSlice("", 100 / playersOnCheckPoint.length, GlobalConstants.COLORS[aPlayerData2.id - 1]);
			}
			if (playersOnCheckPoint.length >= 2)
				checkpointMarker.setSliceBorder(1, 0, 1);
			checkpointMarker.draw();
		}
	
	}

}