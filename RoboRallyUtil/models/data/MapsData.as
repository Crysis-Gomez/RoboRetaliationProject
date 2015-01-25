package models.data 
{
	/**
	 * ...
	 * @author 
	 */
	public class MapsData 
	{
		private var maps:Array = new Array();
		
		
		public function MapsData() 
		{
			
		}
		
		public function addMap(mapData:MapData):void 
		{
			maps.push(mapData);
		}
		
		public function clear():void 
		{
			maps = new Array();
		}
		
		public function getMaps():Array 
		{
			return maps;
		}
		
	}

}