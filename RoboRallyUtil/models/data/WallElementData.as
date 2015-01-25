package models.data 
{
	/**
	 * ...
	 * @author Jerry
	 */
	public class WallElementData 
	{
		private var _x:int;
		private var _y:int;
		private var _type:String;
		private var _gotLaser:String;
		
		public function WallElementData(aElementXML:XML) 
		{
			_x 		= aElementXML.x;
			_y 		= aElementXML.y;
			type    = aElementXML.checkWall;
			_gotLaser = aElementXML.checkLaser;
			//if ((aElementXMl as String).match("checkLaser")) trace("gootlasers");
		}
		

		
		public function get x():int 
		{
			return _x;
		}
		
		public function get y():int 
		{
			return _y;
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		public function set type(value:String):void 
		{
			_type = value;
		}
		
		public function get gotLaser():String 
		{
			return _gotLaser;
		}
		
		public function set gotLaser(value:String):void 
		{
			_gotLaser = value;
		}
		
	}

}