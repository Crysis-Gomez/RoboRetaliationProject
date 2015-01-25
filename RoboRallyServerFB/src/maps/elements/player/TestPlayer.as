package maps.elements.player
{
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.ui.Keyboard;
	import logger.Logger;
	import maps.elements.player.base.PlayerBoardElement;
	import maps.tools.TestTools;
	import models.data.CardData;
	import models.data.PlayerData;
	
	/**
	 * ...
	 * @author ...
	 */
	public class TestPlayer extends PlayerBoardElement
	{
		private var testTools:TestTools;
		private var moving:Boolean;
		
		public function TestPlayer(playerData:PlayerData, testTools:TestTools)
		{
			super(playerData);
			this.testTools = testTools;
			addEventListener(MouseEvent.CLICK, onTestPlayerClick);
		}
		
		private function onTestPlayerClick(e:MouseEvent):void
		{
			if (testTools.selectedPlayer != null)
			{
				testTools.selectedPlayer.deselect();
			}
			testTools.selectedPlayer = this;
			testTools.selectedPlayer.select();
		}
		
		public function select():void
		{
			filters = [new GlowFilter()];
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			if (this.moving) return;
			Logger.getInstance().log("Start Test Player");
			var cardData:CardData = new CardData();
			this.moving = true;
			if (e.keyCode == Keyboard.UP)
			{
				cardData.action = "forward";
				cardData.amount = 1;
				playerAction.moveRobot(cardData, finished,-1);
			}
			if (e.keyCode == Keyboard.DOWN)
			{
				cardData.action = "back";
				cardData.amount = 1;
				playerAction.moveRobot(cardData, finished,-1);
			}
			if (e.keyCode == Keyboard.LEFT)
			{
				cardData.action = "rotate";
				cardData.amount = -90;
				playerAction.rotateRobot(cardData, finished, -1);
			}
			if (e.keyCode == Keyboard.RIGHT)
			{
				cardData.action = "rotate";
				cardData.amount = 90;
				playerAction.rotateRobot(cardData, finished, -1);
			}
			
		}
		
		public function finished(uselessVar:int):void 
		{
			Logger.getInstance().log("Test Player Finished");
			this.moving = false;
		}
		
		public function deselect():void
		{
			filters = null;
			stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
	
	}

}