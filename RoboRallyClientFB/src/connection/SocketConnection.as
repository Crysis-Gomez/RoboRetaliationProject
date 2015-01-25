package connection
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import models.connection.*;

	
	/**
	 * ...
	 * @author Robby Braaksma
	 */
	public class SocketConnection extends Socket
	{
		static private var instance:SocketConnection;
		private var bytesLoaded:int;
		private var waitingForPackage:Boolean = true;
		private var retryCount:int;
		private var connecting:Boolean;
		public var connectionHandler:ConnectionHandler;
		
		public static function getInstance():SocketConnection
		{
			if (instance == null)
			{
				instance = new SocketConnection(arguments.callee);
			}
			return instance;
		}
		
		public function SocketConnection(caller:Function = null)
		{
			super();
			if (caller != SocketConnection.getInstance)
			{
				throw new Error("Singleton is a singleton class, use getInstance() instead");
			}
			if (SocketConnection.instance != null)
			{
				throw new Error("Only one Singleton instance should be instantiated");
			}
			init();
		}
		
		private function init():void
		{
			connectionHandler = new ConnectionHandler();
		}
		
		//public function createConnection():void
		//{
			
		//}
		
		private function setListeners():void
		{
			this.addEventListener(Event.CLOSE, onClose);
			this.addEventListener(Event.CONNECT, onConnect);
			this.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			this.addEventListener(ProgressEvent.SOCKET_DATA, receivedData);
			this.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
		}
		
		private function onClose(e:Event):void
		{
			connectionHandler.receivedDisconnect();
		}
		
		private function onConnect(e:Event):void
		{
			connecting = false;
		}
		
		private function onIOError(e:IOErrorEvent):void
		{
			connectionHandler.dispatchEvent(new ConnectionEvent(ConnectionEvent.CONNECT_FAILED));
		}
		
		public function sendData(data:*, waitForCallback:Boolean = false):void
		{
			if (connected)
			{
				send(data);
				
			}
			else
			{
				retryCount = 0;
				if(!connecting) {
					this.connect(GlobalConstants.SERVER_IP, GlobalConstants.SERVER_PORT);
				}
				var timer:Timer = new Timer(250);
				timer.start();
				timer.addEventListener(TimerEvent.TIMER, function():void {
					retryCount++;
					trace(connected);
					if (connected) {
						timer.stop();
						send(data);
						
						return;
					}
					if (retryCount == GlobalConstants.TIME_OUT) {
						connectionHandler.dispatchEvent(new ConnectionEvent(ConnectionEvent.CONNECT_FAILED));
					}
				});
			}
		}
		
		private function send(data:*):void 
		{
			var bytes:ByteArray = new ByteArray();
			bytes.writeObject(data);
			bytes.compress();
			
			writeBytes(bytes);
			flush();
		}
		
		public function createConnection():void 
		{
			connecting = true;
			this.connect(GlobalConstants.SERVER_IP, GlobalConstants.SERVER_PORT);
			this.setListeners();
			
		}
		
		private function receivedData(e:ProgressEvent):void
		{
			trace("received data");
			var bytes:ByteArray = new ByteArray();
			readBytes(bytes);
			bytes.uncompress();
			
			var object:* = bytes.readObject() as Object;
			
			resolvePackage(object);		
		}
		
		private function resolvePackage(object:*):void
		{
			trace("Received Object"+object);
			switch (object.type)
			{
				case "player_sync":
					connectionHandler.receivedPlayerSync(object as PlayerSync);
					break;
				case "connect_accept":
					connectionHandler.receivedConnectAccept(object as ConnectAccept);
					break;
				case "connect_declined":
					connectionHandler.receivedConnectDeclined(object as ConnectDeclined);
					break;
				case "game_started":
					connectionHandler.gameStarted(object as GameStarted);
					break;
				case "game_options":
					connectionHandler.gameOptions(object as GameOptions);
					break;
				case "received_cards":
					connectionHandler.receivedCards(object as ReceivedCards);
					break;
				case"player_died":
					connectionHandler.playerDied(object as PlayerDied);
					break;
				case "get_damage":
					connectionHandler.getDamage(object as GetDamage);
					break;
				case "lose_damage":
					connectionHandler.lostDamage(object as LoseDamage);
					break;
				case "pickup_request":
					connectionHandler.pickupRequest(object as PickUpRequest);
					break;
				default: 
					trace(this, "Unsupported Object Received", object.type);
					break;
			}
		}
		
		private function onSecurityError(e:SecurityErrorEvent):void
		{
		}
	
	}

}