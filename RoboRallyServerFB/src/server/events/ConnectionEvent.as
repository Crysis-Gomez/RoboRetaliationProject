package server.events 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author 
	 */
	public class ConnectionEvent extends Event
	{
		public var data:*;
		static public const PLAYER_DISCONNECT:String = "playerDisconnect";
		static public const PLAYER_READY:String = "playerReady";
		static public const PLAYER_SENDS_CARDS:String = "playerSendsCards";
		static public const PLAYER_REBOOT:String = "reboot";
		static public const PICKUP_ACCEPT:String = "pickupAccept";
		static public const PICKUP_DECLINED:String = "pickupDeclined";
		
		public function ConnectionEvent(type:String, data:* = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		
		}
		
	}

}