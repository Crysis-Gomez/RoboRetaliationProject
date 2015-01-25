package maps.elements.repair
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import maps.elements.base.BoardElement;
	import maps.elements.checkpoint.util.PieChart;
	import maps.elements.player.base.PlayerBoardElement;
	import models.data.PlayerData;
	import screens.Playscreen;
	
	/**
	 * ...
	 * @author Jerry
	 */
	public class RepairElement extends BoardElement
	{
		private var _id:int = 0;
		
		[Embed(source="assets/repairPoint.png")]
		private var repairClass:Class;
		[Embed(source="assets/doubleRepairPoint.png")]
		private var doublerepairClass:Class;
		
		private var repairBitmap:Bitmap = new repairClass();
		private var doubleRepairBitmap:Bitmap = new doublerepairClass();
		
		private var bitmaps:Array = new Array(repairBitmap, doubleRepairBitmap);
		private var element:Sprite;
		private var checkpointMarker:PieChart;
		private var playersOnCheckPoint:Array = new Array();
		
		public function RepairElement(selectable:Boolean, deletable:Boolean)
		{
			
			type = "repairElement";
			
			element = new Sprite();
			
			checkpointMarker = new PieChart();
			checkpointMarker.autoBalance = true;
			checkpointMarker.addSlice("", 100, 0x000000);
			checkpointMarker.radius = 20;
			checkpointMarker.x = 30;
			checkpointMarker.setOuterBorder(0, 0, 0);
			checkpointMarker.y = 30;
			checkpointMarker.draw();
			checkpointMarker.mouseEnabled = false;
			this.addChild(checkpointMarker);
			addChild(element);
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
		
		}
		
		override public function doAction(robot:PlayerBoardElement, aElementFinished:Function, finishedFunction:Function, length:uint, registerIndex:int):void
		{
			if (robot != null)
			{
		
				if (robot.playerData.stageCount == 3) {
					robot.playerData.stageCount++;
					(robot.aPlayerHud.playerBoardElement.map.game.currentScreen as Playscreen).updateText(robot.playerData.stageCount);
				}
				robot.setCheckPoint();
				if (registerIndex == 5)
					robot.doRepair(1);
			}
			aElementFinished(length, finishedFunction);
			super.doAction(robot, aElementFinished, finishedFunction, length, registerIndex);
		}
		
		public function addPlayer(playerData:PlayerData):void
		{
			for each (var aPlayerData:PlayerData in playersOnCheckPoint)
			{
				if (aPlayerData.id == playerData.id)
					return;
			}
			
			playersOnCheckPoint.push(playerData);
			
			checkpointMarker.removeAllSlices();
			checkpointMarker.destroy();
			
			for each (var aPlayerData2:PlayerData in playersOnCheckPoint)
			{
				checkpointMarker.addSlice("", 100 / playersOnCheckPoint.length, GlobalConstants.COLORS[aPlayerData2.id - 1]);
			}
			if (playersOnCheckPoint.length >= 2)
				checkpointMarker.setSliceBorder(1, 0, 1);
			checkpointMarker.draw();
		}
		
		public function removePlayer(playerData:PlayerData):void
		{
			for (var i:int = 0; i < playersOnCheckPoint.length; ++i)
			{
				var aPlayerData:PlayerData = playersOnCheckPoint[i];
				if (aPlayerData.id == playerData.id)
				{
					playersOnCheckPoint.splice(i, 1);
				}
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