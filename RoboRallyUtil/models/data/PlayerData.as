package models.data 
{
	/**
	 * ...
	 * @author 
	 */
	public class PlayerData 
	{
		public var id:int;
		public var name:String;
		public var robotID:int;
		private var _damage:int = 0;
		private var _lives:int = 3;
		public var stageCount:int = 0;
		
		public function PlayerData() 
		{
			
		}
		
		public function get damage():int 
		{
			return _damage;
		}
		
		public function set damage(value:int):void 
		{
			_damage = value;
		}
		
		public function get lives():int 
		{
			return _lives;
		}
		
		public function set lives(value:int):void 
		{
			_lives = value;
		}
		
		
		
	}

}