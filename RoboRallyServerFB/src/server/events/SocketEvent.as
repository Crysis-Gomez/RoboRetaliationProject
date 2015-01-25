package server.events 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author 
	 */
	public class SocketEvent extends Event
	{
		static public const CLIENT_CONNECTED:String = "clientConnected";
		public var data:*;
		
		public function SocketEvent(type:String, data:* = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		
		}
		
	}

}