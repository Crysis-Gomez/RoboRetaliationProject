package  
{
	import flash.geom.Point;
	import flash.net.registerClassAlias;
	import logger.Logger;
	import models.connection.*;
	import models.data.*;

	/**
	 * ...
	 * @author Robby Braaksma
	 */
	public class GlobalConstants 
	{
		static public const LOCAL_PLAY:Boolean = true;
		static public var TUTORIAL_PLAY:Boolean = true;
		
		//static public const SERVER_IP:String = "145.92.12.112";
		//static public const SERVER_IP:String = "145.92.76.49"
		//static public const SERVER_IP:String = "192.168.2.8";

		//static public const SERVER_IP:String = "145.92.12.232";
		//static public const SERVER_IP:String = "145.92.75.110";
		//static public const SERVER_IP:String = "192.168.1.7"
		static public var SERVER_IP:String = "127.0.0.1";
		static public const SERVER_PORT:int = 55555;
		
		static public const TIME_OUT:int = 100;//Equals 25 seconds
		static public const MAX_PLAYERS:int = 8;
		static public const MAPEDITABLE:Boolean = true;
		
		static public const COLORS:Array = new Array(0xFF0000, 0xFF8000, 0x008000, 0xFFFF00, 0x0000FF, 0x0080FF, 0x00FF00, 0x8000FF);
		static public var speed:int = 4; // value should be able to devide through 60 and be a round number
		static public var rotateSpeed:int = 2; //value should be able to devide through 90 and 180 and be a round number
		public static var MAPTESTABLE:Boolean = true;
		
		public function GlobalConstants() 
		{
			
		}
		public static function registerClasses():void
		{
			Logger.getInstance().log("Registerin Network Classes");
			
			registerClassAlias("connect_accept", ConnectAccept);
			registerClassAlias("connect_request", ConnectRequest);
			registerClassAlias("connect_declined", ConnectDeclined);
			registerClassAlias("player_ready", PlayerReady);
			registerClassAlias("player_data", PlayerData);
			registerClassAlias("game_started", GameStarted);
			registerClassAlias("received_cards", ReceivedCards);
			registerClassAlias("card_data", CardData);
			registerClassAlias("player_died", PlayerDied);
			registerClassAlias("get_damage", GetDamage);
			registerClassAlias("lose_damage", LoseDamage);
			registerClassAlias("reboot", Reboot);
			registerClassAlias("game_options", GameOptions);
			registerClassAlias("player_sync", PlayerSync);
			registerClassAlias("pickup_activate", PickUpRequest);
			registerClassAlias("pickup_accept", PickUpAccept);
			registerClassAlias("pickup_declined", PickUpDeclined);
			registerClassAlias("point", Point);
		}
	}

}