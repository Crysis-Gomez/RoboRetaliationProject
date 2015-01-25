package connection 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import models.connection.*;

	/**
	 * ...
	 * @author Robby Braaksma
	 */
	public class ConnectionHandler extends EventDispatcher
	{
		
		public function ConnectionHandler() 
		{
			
		}
		
		public function receivedConnectAccept(connectAccept:ConnectAccept):void 
		{
			this.dispatchEvent(new ConnectionEvent(ConnectionEvent.CONNECT_ACCEPTED, connectAccept.playerID));
		}
		
		public function receivedConnectDeclined(connectDeclined:ConnectDeclined):void 
		{
			this.dispatchEvent(new ConnectionEvent(ConnectionEvent.CONNECT_DECLINED));
		}
		
		public function gameStarted(gameStarted:GameStarted):void 
		{
			this.dispatchEvent(new ConnectionEvent(ConnectionEvent.GAME_STARTED));
		}
		
		public function receivedCards(receivedCards:ReceivedCards):void 
		{
			this.dispatchEvent(new ConnectionEvent(ConnectionEvent.RECEIVED_CARDS,receivedCards.cards));
		}
		
		public function playerDied(playerDied:PlayerDied):void 
		{
			this.dispatchEvent(new ConnectionEvent(ConnectionEvent.PLAYER_DIED));
		}
		
		public function receivedDisconnect():void 
		{
			this.dispatchEvent(new ConnectionEvent(ConnectionEvent.CONNECT_CLOSE));
		}
		
		public function lostDamage(loseDamage:LoseDamage):void 
		{
			this.dispatchEvent(new ConnectionEvent(ConnectionEvent.LOST_DAMAGE, loseDamage.amount));
		}
		
		public function getDamage(getDamage:GetDamage):void 
		{
			this.dispatchEvent(new ConnectionEvent(ConnectionEvent.GET_DAMAGE));
		}
		
		public function reboot(rebo:Reboot):void 
		{
			this.dispatchEvent(new ConnectionEvent(ConnectionEvent.REBOOT));
		}
		
		public function gameOptions(gameOptions:GameOptions):void 
		{
			this.dispatchEvent(new ConnectionEvent(ConnectionEvent.GAME_OPTIONS, gameOptions));
		}
		
		public function receivedPlayerSync(playerSync:PlayerSync):void 
		{
			this.dispatchEvent(new ConnectionEvent(ConnectionEvent.PLAYER_SYNC, playerSync.playerData));
		}
		
		public function pickupRequest(pickUpActivationRequest:PickUpRequest):void 
		{
			this.dispatchEvent(new ConnectionEvent(ConnectionEvent.PICKUP_REQUEST, pickUpActivationRequest));
		}

	}

}