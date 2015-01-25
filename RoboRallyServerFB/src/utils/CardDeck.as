package utils
{
	import models.data.CardData;
	import models.data.CardsData;
	import models.data.PlayerData;
	
	/**
	 * ...
	 * @author Robby Braaksma
	 */
	public class CardDeck
	{
		private var deck:Array;
		private var FirstRoundDeck:Array;
		private var lockedList:Array = new Array();
		static private var instance:CardDeck;
		
		public function CardDeck(caller:Function = null)
		{
			if (caller != CardDeck.getInstance)
				throw new Error("Singleton is a singleton class, use getInstance() instead");
			if (CardDeck.instance != null)
				throw new Error("Only one Singleton instance should be instantieted");
				
		}
		
		static public function getInstance():CardDeck
		{
			if (instance == null)
				instance = new CardDeck(arguments.callee);
			return instance;
		}
		
		
		public function pushToLock(card:CardData):void 
		{
			for (var i:int = 0; i < GameData.cards.length; i++) 
			{
				var data:CardData = GameData.cards[i];
				
				if (data == card) {
					lockedList.push(card);
				}
				
			}
			
		}
		
		
		public function removeFromLock(card:CardData):void 
		{
			for (var i:int = 0; i < lockedList.length; i++) 
			{
				var data:CardData = lockedList[i];
				if (data.priority == card.priority) {
					lockedList.splice(i, 1);
				}
			}
			
		}
		
		public function resetCards():void
		{
			deck = GameData.cards.concat();
			deck = shuffleDeck(deck);
			//removing the locked cards from the deck;
			var removeList:Array = new Array();
			for each(var aLockedCard:CardData in lockedList) {
				for (var i:int = 0; i < deck.length; ++i) {
					var cardInDeck:CardData = deck[i];
					if (cardInDeck.priority == aLockedCard.priority) removeList.push(i);
				}
			}
			
			for each(var deleteIndex:int in removeList) {
				deck.splice(i, 1);
			}
		}
		
		public function getFirstRoundCards(playerData:PlayerData):Array
		{
			var cards:Array = new Array();
			
				cards.push(GameData.cards[42]);
				cards.push(GameData.cards[43]);
				cards.push(GameData.cards[60]);
				cards.push(GameData.cards[70]);
				cards.push(GameData.cards[80]);
		
	
			return cards;
		}
		
		public function getSecondRoundCards(playerData:PlayerData):Array
		{
			var cards:Array = new Array();
			
				cards.push(GameData.cards[10]);
				cards.push(GameData.cards[70]);
				cards.push(GameData.cards[31]);
				cards.push(GameData.cards[50]);
				cards.push(GameData.cards[80]);
		
	
			return cards;
		}
		
		
		public function getThirdRoundCards(playerData:PlayerData):Array 
		{
			/////-1,L, 2, 1,1
			
			var cards:Array = new Array();
			
				cards.push(GameData.cards[42]);
				cards.push(GameData.cards[20]);
				cards.push(GameData.cards[70]);
				cards.push(GameData.cards[60]);
				cards.push(GameData.cards[61]);
		
	
			return cards;
		}
		
		
		public function getFourthRoundCards(playerData:PlayerData):Array 
		{
			///// 1,L,1,1,2
			
				
			var cards:Array = new Array();
			
				cards.push(GameData.cards[59]);
				cards.push(GameData.cards[20]);
				cards.push(GameData.cards[70]);
				cards.push(GameData.cards[60]);
				cards.push(GameData.cards[61]);
		
	
			return cards;
			
		}
		
		public function getFifthRoundCards(playerData:PlayerData):Array 
		{
			/////R,3,1,-1,3
			var cards:Array = new Array();
			
				cards.push(GameData.cards[19]);
				cards.push(GameData.cards[78]);
				cards.push(GameData.cards[79]);
				cards.push(GameData.cards[60]);
				cards.push(GameData.cards[42]);
		
	
			return cards;
		}
		
		public function getSixthRoundCards(playerData:PlayerData):Array 
		{
			/////R,3,1,-1,3
			var cards:Array = new Array();
			
				cards.push(GameData.cards[19]);
				cards.push(GameData.cards[60]);
				cards.push(GameData.cards[1]);
				cards.push(GameData.cards[42]);
				cards.push(GameData.cards[20]);
		
	
			return cards;
			
		}
		
		public function getSeventhRoundCards(playerData:PlayerData):Array 
		{
			/////R, 2, T, -1, L
			trace("Here");
			var cards:Array = new Array();
			
				cards.push(GameData.cards[19]);
				cards.push(GameData.cards[70]);
				cards.push(GameData.cards[1]);
				cards.push(GameData.cards[42]);
				cards.push(GameData.cards[20]);
		
	
			return cards;
		}
		
		
		public function getCards(playerData:PlayerData):Array
		{
			var cards:Array = new Array();
			
			while (cards.length != 9 - playerData.damage) {
				cards.push(deck.pop());
			}
			return cards;
		}
		
		private function shuffleDeck(array:Array):Array
		{
			//l=length arr=temp parameter array mixed=randomized array i=index
			var l:int = array.length, arr:Array = array.slice(), mixed:Array = new Array(l), i:int;
			for (i = 0; i < l; i++)
			{
				mixed[i] = arr.splice(int(Math.random() * (l - i)), 1)[0];
			}
			return mixed;
		}
	
	}

}