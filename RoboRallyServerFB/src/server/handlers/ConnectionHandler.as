package server.handlers
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import models.connection.ConnectAccept;
	import models.connection.ConnectDeclined;
	import models.connection.PickUpAccept;
	import models.connection.PickUpDeclined;
	import models.data.PlayerData;
	import mx.collections.ArrayCollection;
	import server.Connection;
	import server.events.ConnectionEvent;
	import server.events.SocketEvent;
	import server.SocketManager;
	
	/**
	 * ...
	 * @author Robby Braaksma
	 */
	public class ConnectionHandler extends EventDispatcher
	{
		private var connection:Connection;
		private var game:RoboRally;
		
		public function ConnectionHandler(connection:Connection, game:RoboRally)
		{
			this.game = game;
			this.connection = connection;
		
		}
		
		public function handleConnectRequest():void
		{
			if ((game as RoboRally).clients.length < GlobalConstants.MAX_PLAYERS && (game as RoboRally).started == false) {
				connection.playerID = (game as RoboRally).clients.length + 1;
				SocketManager.getInstance().socketHandler.dispatchEvent(new SocketEvent(SocketEvent.CLIENT_CONNECTED, connection));
				
				
	
				
				var connectAccept:ConnectAccept = new ConnectAccept();
				connectAccept.playerID = connection.playerID;
				
				connection.send(connectAccept);
				
			} else {
				connection.send(new ConnectDeclined());
			}
		}
		
		public function handleDisconnect(connectionID:String):void 
		{
			this.dispatchEvent(new ConnectionEvent(ConnectionEvent.PLAYER_DISCONNECT, connectionID));
		}
		
		public function handlePlayerReady(playerdata:PlayerData):void 
		{
			this.dispatchEvent(new ConnectionEvent(ConnectionEvent.PLAYER_READY, playerdata));
		}
		
		
		public function handleReboot(playerID:int):void 
		{
			this.dispatchEvent(new ConnectionEvent(ConnectionEvent.PLAYER_REBOOT, playerID));
		}
		
		public function handleReceivedCards(cards:Array, playerData:PlayerData):void 
		{
			this.dispatchEvent(new ConnectionEvent(ConnectionEvent.PLAYER_SENDS_CARDS, new Array(cards, playerData)));
		}
		
		public function handlePickUpAccept(pickUpAccept:PickUpAccept):void 
		{
			this.dispatchEvent(new ConnectionEvent(ConnectionEvent.PICKUP_ACCEPT, pickUpAccept));
		}
		
		public function handlePickUpDeclined(pickUpDeclined:PickUpDeclined):void 
		{
			this.dispatchEvent(new ConnectionEvent(ConnectionEvent.PICKUP_DECLINED, pickUpDeclined));
		}
	
	}

}