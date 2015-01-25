package logger 
{
	/**
	 * ...
	 * @author ...
	 */
	public class Logger 
	{
		private var logMessage:String = "";
		private static var instance:Logger;
		
		public function Logger(caller:Function = null)
		{
			if (caller != Logger.getInstance)
				throw new Error("Singleton is a singleton class, use getInstance() instead");
			if (Logger.instance != null)
				throw new Error("Only one Singleton instance should be instantieted");
				
		}
		
		static public function getInstance():Logger
		{
			if (instance == null)
				instance = new Logger(arguments.callee);
			return instance;
		}
		
		public function log(message:String):void
		{
			//trace(message);
			logMessage += message+"\n"
		}
		
		public function print():void
		{
			
		}
		
		public function getLog():String 
		{
			return logMessage;
		}
		
	}

}