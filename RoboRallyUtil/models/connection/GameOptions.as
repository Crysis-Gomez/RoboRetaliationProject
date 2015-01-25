package models.connection 
{
	/**
	 * ...
	 * @author Robby Braaksma
	 */
	public class GameOptions
	{
		public const type:String = "game_options"
		
		public var enablePickups:Boolean = false;
		//public var enablePickups:Boolean = false;
		//Chance that a pickup will appear at a phase
		public var chanceOfPickup:Number = 50;
		//public var timeToSelectAPickup:int = 10; //in seconds
		
		public var timer:int = 0;
		//public var timer:int = 30;
		//public var timer:int = 60;
		//public var timer:int = 120;
		
		public function GameOptions() 
		{
			
		}
		
	}

}