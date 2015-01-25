package utils 
{
	
	import gui.player.PlayerElement;
	import models.connection.ReceivedCards;
	import models.data.PlayerData;
	/**
	 * ...
	 * @author Jerry
	 */
	public class TutorialManager 
	{
		
		static private var instance:TutorialManager;
		
		public function TutorialManager(caller:Function = null) 
		{
			if (caller != TutorialManager.getInstance)
				throw new Error("Singleton is a singleton class, use getInstance() instead");
			if (TutorialManager.instance != null)
				throw new Error("Only one Singleton instance should be instantieted");
		}
		
		static public function getInstance():TutorialManager
		{
			if (instance == null)
				instance = new TutorialManager(arguments.callee);
			return instance;
		}
		
		
		public function getDirection(_data:PlayerData):Number 
		{
			var _number:Number = 0;
			switch (_data.stageCount) 
			{
				case TutorialConstants.STAGE1:
				_number = 90;
				return _number;
				
			case TutorialConstants.STAGE2:
				_number = 90;
				
				return _number;
			case TutorialConstants.STAGE3:
				_number = 90;
				return _number;
				
			case TutorialConstants.STAGE4:
				_number = 270;
				return _number;
				
			case  TutorialConstants.STAGE5:
				_number = 180;
				return _number;
				
			case  TutorialConstants.STAGE6:
				_number = 0;
				return _number;
				
			case TutorialConstants.STAGE7:
				
				return _number;
				_number = 90;
				default:
			}
			
			return _number;
		}
		
		
		public function getCards(client:PlayerElement):ReceivedCards
		{
			var receivedCards:ReceivedCards = new ReceivedCards();
			
			switch (client.playerData.stageCount)
			{
				case TutorialConstants.STAGE1:
					receivedCards.cards = CardDeck.getInstance().getFirstRoundCards(client.playerData);
					return receivedCards;
				
				case TutorialConstants.STAGE2:
					receivedCards.cards = CardDeck.getInstance().getSecondRoundCards(client.playerData);
					return receivedCards;
				
				case TutorialConstants.STAGE3:
					receivedCards.cards = CardDeck.getInstance().getThirdRoundCards(client.playerData);
					return receivedCards;
					
				case TutorialConstants.STAGE4:
					receivedCards.cards = CardDeck.getInstance().getFourthRoundCards(client.playerData);
					return receivedCards;
					
				case TutorialConstants.STAGE5:
					receivedCards.cards = CardDeck.getInstance().getFifthRoundCards(client.playerData);
					return receivedCards;
					
				case TutorialConstants.STAGE6:
					receivedCards.cards = CardDeck.getInstance().getSixthRoundCards(client.playerData);
					return receivedCards;
					
				case TutorialConstants.STAGE7:
					receivedCards.cards = CardDeck.getInstance().getSeventhRoundCards(client.playerData);
					return receivedCards;
		
						
				default: 
			}
			
			return receivedCards;
		
		}
		
	}

}