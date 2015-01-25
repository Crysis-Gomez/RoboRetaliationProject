package core.events
{
	import flash.events.Event;
	
	public class GameEvent extends Event
	{
		static public const PLAYER_CONNECTED:String = "playerConnected";
		static public const GAME_STARTABLE:String = "gameStartable";
		static public const PLAYER_READY:String = "playerReady";
		static public const PLAYER_PLAYED_CARDS:String = "playerPlayedCards";
		
		public var data:*;
		
		public function GameEvent(type:String, data:* = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
	}
}