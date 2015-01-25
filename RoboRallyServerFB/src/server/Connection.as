package server
{
	import flash.events.TimerEvent;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import logger.Logger;
	import models.connection.PickUpAccept;
	import models.connection.PickUpDeclined;
	import models.connection.Reboot;
	import models.connection.ReceivedCards;
	//import models.connection.CardsPlayer;
	import models.connection.PlayerReady;
	import models.data.PlayerData;
	import server.handlers.ConnectionHandler;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * ...
	 * @author Robby Braaksma
	 */
	public class Connection
	{
		public var playerID:Number;
		private var _socketManager:SocketManager;
		private var _socket:Socket;
		private var _connectionID:String;
		private var _connectionAdress:String;
		private var _connectionPort:int;
		private var _logedIn:Boolean;
		private var _connectionHandler:ConnectionHandler;
		private var game:RoboRally;
		private var _playerData:PlayerData;
		private var receivedbytes:ByteArray = new ByteArray;
		
		public function Connection(socketManager:SocketManager, socket:Socket, connectionID:String, game:RoboRally)
		{
			this.game = game;
			_connectionID = connectionID;
			_socket = socket;
			_socketManager = socketManager;
			_connectionAdress = socket.remoteAddress;
			_connectionPort = socket.remotePort;
			
			_connectionHandler = new ConnectionHandler(this, game);
			
			_socket.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_socket.addEventListener(Event.CLOSE, onDisconnect);
			_socket.addEventListener(ProgressEvent.SOCKET_DATA, onDataReceived);
		
			
		}
		
		public function get socket():Socket
		{
			return _socket;
		}
		
		public function send(data:*):void
		{
			
			var bytes:ByteArray = new ByteArray();
			bytes.writeObject(data);
			bytes.compress();
			
			var timer:Timer = new Timer(20, 1);
			timer.start();
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, function():void
				{
					Logger.getInstance().log("Sending " + data + " to " + playerID + " ");
					_socket.writeBytes(bytes);
					_socket.flush();
				});
		}
		
		private function onIOError(e:IOErrorEvent):void
		{
			trace("IO Error Occured: " + e.errorID.toString());
		}
		
		private function onDisconnect(e:Event):void
		{
			_logedIn = false;
			connectionHandler.handleDisconnect(connectionID);
			_socketManager.removeConnection(connectionID);
		
		}
		
		private function onDataReceived(e:ProgressEvent):void
		{
			_socket.readBytes(receivedbytes, receivedbytes.length);
			try
			{
				receivedbytes.uncompress();
			}
			catch (e:Error)
			{
				return;
			}
			var object:* = receivedbytes.readObject() as Object;
			trace(object.type);
			
			switch (object.type)
			{
				case "connect_request": 
					connectionHandler.handleConnectRequest();
					break;
				case "player_ready": 
					_playerData = (object as PlayerReady).playerdata;
					_connectionHandler.handlePlayerReady((object as PlayerReady).playerdata);
					break;
				case "received_cards": 
					connectionHandler.handleReceivedCards((object as ReceivedCards).cards, _playerData);
					break;
				case "reboot":
					_connectionHandler.handleReboot(_playerData.id);
					break;
				case "pickup_accept":
					_connectionHandler.handlePickUpAccept(object as PickUpAccept);
					break;
				case "pickup_declined":
					_connectionHandler.handlePickUpDeclined(object as PickUpDeclined);
					break;	
				default: 
					trace("Received Unknown Package from: " + _connectionID, object.type);
					break;
			}
			receivedbytes = new ByteArray();
		}
		
		public function get connectionAdress():String
		{
			return _connectionAdress;
		}
		
		public function get connectionPort():int
		{
			return _connectionPort;
		}
		
		public function get connectionID():String
		{
			return _connectionID;
		}
		
		public function get socketManager():SocketManager
		{
			
			return _socketManager;
		}
		
		public function get connectionHandler():ConnectionHandler
		{
			return _connectionHandler;
		}
		
		public function get playerData():PlayerData
		{
			return _playerData;
		}
	}

}