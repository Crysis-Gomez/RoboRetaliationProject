package connection
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Robby Braaksma
	 */
	public class ConnectionEvent extends Event
	{
		public var data:*;
		static public const TIME_OUT:String = "timeOut";
		static public const CONNECT_ACCEPTED:String = "connectAccepted";
		static public const CONNECT_DECLINED:String = "connectDeclined";
		static public const CONNECT_FAILED:String = "connectFailed";
		static public const GAME_STARTED:String = "gameStarted";
		static public const RECEIVED_CARDS:String = "receivedCards";
		static public const PLAYER_DIED:String = "playerDied";
		static public const CONNECT_CLOSE:String = "connectClose";
		static public const GET_DAMAGE:String = "getDamage";
		static public const LOST_DAMAGE:String = "lostDamage";
		static public const REBOOT:String = "reboot";
		static public const GAME_OPTIONS:String = "gameOptions";
		static public const PLAYER_SYNC:String = "playerSync";
		static public const PICKUP_REQUEST:String = "pickupRequest";
		
		public function ConnectionEvent(type:String, data:* = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		
		}
	
	}

}