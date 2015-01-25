package models.connection 
{
	import models.data.PlayerData;
	/**
	 * ...
	 * @author Robby Braaksma
	 */
	public class PlayerSync 
	{
		public const type:String = "player_sync";
		public var playerData:PlayerData;
		
		public function PlayerSync() 
		{
			
		}
		
	}

}