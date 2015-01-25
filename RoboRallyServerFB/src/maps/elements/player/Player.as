package maps.elements.player
{
	import flash.display.Bitmap;
	import logger.Logger;
	import maps.elements.base.BoardElement;
	import maps.elements.pickup.PickUp;
	import maps.elements.player.base.PlayerBoardElement;
	import maps.Map;
	import models.connection.GetDamage;
	import models.connection.LoseDamage;
	import models.data.CardData;
	import models.data.PlayerData;
	import screens.WinScreen;
	import screens.Playscreen;
	import gui.player.PlayerElement;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Player extends PlayerBoardElement
	{
		private var cardFinished:Function;
		private var checkpointCount:int = 3;
		
		[Embed(source="assets/Arrow.png")]
		private var ArrowClass:Class;
		private var ArrowBitmap:Bitmap = new ArrowClass();
		
		public function Player(playerData:PlayerData)
		{
			super(playerData);
			if (GlobalConstants.TUTORIAL_PLAY)
			{
				checkpointCount = 5;
				addChild(ArrowBitmap);
				ArrowBitmap.rotation = -90;
				ArrowBitmap.x -= 100;
				ArrowBitmap.y += 220;
			}
		}
		
		public function playCard(card:CardData, cardFinished:Function, registerIndex:int):void
		{
			if (ArrowBitmap != null)
			{
				if (this.contains(ArrowBitmap))
				{
					removeChild(ArrowBitmap);
				}
			}
			
			Logger.getInstance().log("Player: " + aPlayerHud.playerData.id + " " + aPlayerHud.playerData.name + " playing card " + card);
			if (destroyed)
			{
				Logger.getInstance().log("Player: " + aPlayerHud.playerData.id + " " + aPlayerHud.playerData.name + "card is canceled because player is destroyed");
				cardFinished(registerIndex);
				return;
			}
			
			switch (card.action)
			{
				case "forward": 
				case "back": 
					playerAction.moveRobot(card, cardFinished, registerIndex);
					break;
				case "rotate": 
					playerAction.rotateRobot(card, cardFinished, registerIndex);
					break;
				default: 
					Logger.getInstance().log("Player: " + aPlayerHud.playerData.id + " " + aPlayerHud.playerData.name + "Unknown Card Not Played");
					cardFinished(registerIndex);
					break;
			}
		
		}
		
		override public function addCheckPoint(id:int):void
		{
			super.addCheckPoint(id);
			Logger.getInstance().log(checkPoints.length.toString() + "checkPointLenght");
			if (checkPoints.length == checkpointCount)
			{
				
				Logger.getInstance().log("Winning");
				var game:RoboRally = ((parent as Map).game as RoboRally);
				(game.currentScreen as Playscreen).gameEnded = true;
				game.destroy();
				var winScreen:WinScreen = new WinScreen();
				winScreen.setColor(this.playerData);
				game.addScreen(winScreen);
			}
		}
		
		override public function doDamage():void
		{
			
			//var getDamage:GetDamage = new GetDamage();
			//aPlayerHud.connection.send(getDamage);
			super.doDamage();
			aPlayerHud.updateHud();
		}
		
		override public function doRepair(value:Number):void
		{
			
			//var loseDamage:LoseDamage = new LoseDamage();
			//aPlayerHud.connection.send(loseDamage);
			super.doRepair(value);
			aPlayerHud.updateHud();
		}
		
		override public function set destroyed(value:Boolean):void
		{
			super.destroyed = value;
			if (destroyed)
			{
				aPlayerHud.lostALife();
				aPlayerHud.updateHud();
			}
		
		}
		
		override public function addPickUp(pickup:BoardElement):void
		{
			aPlayerHud.addPickup(pickup as PickUp);
		}
	}
}