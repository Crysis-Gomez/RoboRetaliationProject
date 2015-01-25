package server
{
	import flash.events.Event;
	import flash.events.ServerSocketConnectEvent;
	import flash.net.ServerSocket;
	import flash.utils.Dictionary;
	import logger.Logger;
	import server.handlers.SocketHandler;
	
	/**
	 * ...
	 * @author Robby Braaksma
	 */
	public class SocketManager
	{
		public var socketHandler:SocketHandler;
		static private var instance:SocketManager;
		private var _serverPort:int;
		private var _serverIP:String;
		private var serverSocket:ServerSocket = new ServerSocket();
		private var connections:Dictionary = new Dictionary();
		private var connectionCount:uint;
		private var game:RoboRally;
		
		public function SocketManager(caller:Function = null)
		{
			if (caller != SocketManager.getInstance)
				throw new Error("Singleton is a singleton class, use getInstance() instead");
			if (SocketManager.instance != null)
				throw new Error("Only one Singleton instance should be instantieted");
				
			socketHandler = new SocketHandler(this);
		}
		
		static public function getInstance():SocketManager
		{
			if (instance == null)
				instance = new SocketManager(arguments.callee);
			return instance;
		}
		
		


		
		public function initializeServer():void
		{
			
			if (serverSocket.bound)
			{
				Logger.getInstance().log("Server already initialized");
				return;
			}
			serverSocket.bind(GlobalConstants.SERVER_PORT, GlobalConstants.SERVER_IP);

			serverSocket.addEventListener(ServerSocketConnectEvent.CONNECT, incommingConnection);
			serverSocket.listen();
			
			
			Logger.getInstance().log("Server initialized on IP: " + serverSocket.localAddress + " on Port: " + serverSocket.localPort);
		
		}

		private function incommingConnection(e:ServerSocketConnectEvent):void
		{
			
			var connectionID:String = "ID_" + new Date().getTime().toString();
			
			var aConnection:Connection = new Connection(this, e.socket, connectionID, game);
			connections[connectionID] = aConnection;
			
			
			Logger.getInstance().log("Added new connection from" + aConnection.connectionAdress + ":" + aConnection.connectionPort.toString() + "With: " + aConnection.connectionID + "\n");
			
			connectionCount++;
			
		}
		
		public function removeConnection(connectionID:String):void
		{
			delete connections[connectionID]; //removes the key
			connectionCount--
			Logger.getInstance().log("Removed connection: " + connectionID + "\n");
		}
		
		public function setGame(game:RoboRally):void 
		{
			this.game = game;
			socketHandler.setGame(game);
		}
	}

}