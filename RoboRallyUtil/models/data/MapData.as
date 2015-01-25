package models.data 
{
	/**
	 * ...
	 * @author 
	 */
	public class MapData 
	{
		private var _elements:Array = new Array();
		private var _walls:Array = new Array();
		private var  _name:String;
		
		public function MapData() 
		{
			
		}
		
		public function fromXML(mapXML:XML):void 
		{
			for each(var aElementXML:XML in mapXML.boardelements.*) {
				var boardElmentMapData:BoardElementMapData = new BoardElementMapData(aElementXML);
				elements.push(boardElmentMapData);
			}
			
			for each (var wallXML:XML in mapXML.walls.*) 
			{
		
				var wallData:WallElementData = new WallElementData(wallXML);
				walls.push(wallData);
				
			}

			for each (var name:XML in mapXML.name.*) {
				_name = name;
			}
		}
		
		
		public function get name():String
		{
			return _name;
		}
		
		public function get walls():Array
		{
			return _walls;
		}
	
		
		public function get elements():Array 
		{
			return _elements;
		}

		public function set walls(value:Array):void 
		{
			_walls = value;
		}
		
	}

}