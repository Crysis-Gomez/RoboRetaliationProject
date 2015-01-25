package server.handlers 
{
	import flash.events.EventDispatcher;
	import server.SocketManager;
	/**
	 * ...
	 * @author 
	 */
	public class SocketHandler extends EventDispatcher
	{
		private var socket:SocketManager;
		
		public function SocketHandler(socket:SocketManager) 
		{
			this.socket = socket;
			
		}
		
		public function setGame(game:RoboRally):void 
		{
			
		}
		
	}

}