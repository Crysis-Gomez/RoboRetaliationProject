package models.data 
{
	/**
	 * ...
	 * @author 
	 */
	public class BoardElementMapData 
	{
		private var _type:String;
		private var _propertie:int;
		private var _x:int;
		private var _y:int;
		
		public function BoardElementMapData(aElementXML:XML) 
		{
			_type = aElementXML.type;
			_propertie = aElementXML.propertie;
			_x = aElementXML.x;
			_y = aElementXML.y;
			
			
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		public function get propertie():int 
		{
			return _propertie;
		}
		
		public function get x():int 
		{
			return _x;
		}
		
		public function get y():int 
		{
			return _y;
		}
	}
}