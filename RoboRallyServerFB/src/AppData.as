package
{
	import models.connection.GameOptions;
	
	/**
	 * ...
	 * @author Robby Braaksma
	 */
	public class AppData
	{
		private var _gameOptions:GameOptions;
		static private var instance:AppData;
		
		public static function getInstance():AppData
		{
			if (instance == null)
			{
				instance = new AppData(arguments.callee);
			}
			return instance;
		}
		
		public function AppData(caller:Function = null)
		{
			if (caller != AppData.getInstance)
			{
				throw new Error("Singleton is a singleton class, use getInstance() instead");
			}
			if (AppData.instance != null)
			{
				throw new Error("Only one Singleton instance should be instantiated");
			}
		
		}
		
		public function setGameOptions(gameOptions:GameOptions):void 
		{
			_gameOptions = gameOptions;
			
		}
		
		public function get gameOptions():GameOptions 
		{
			return _gameOptions;
		}
	
	}
}