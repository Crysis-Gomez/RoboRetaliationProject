package  
{
	import logger.Logger;
	import models.data.CardsData;
	import models.data.MapData;
	import models.data.MapsData;
	import models.data.RobotsData;
	import models.data.BoardElementsData;

	/**
	 * ...
	 * @author 
	 */
	public class GameData 
	{
		private static var robotsData:RobotsData = new RobotsData();
		private static var cardsData:CardsData = new CardsData();
		private static var boardElements:BoardElementsData = new BoardElementsData();
		private static var mapsData:MapsData = new MapsData();
		
		public static function loadGameData():void
		{
			Logger.getInstance().log("Loading GameData");
			
			robotsData.loadRobots();
			cardsData.loadCards();
			boardElements.loadBoardElements();
		}
		
		static public function addMap(mapData:MapData):void 
		{
			mapsData.addMap(mapData);
		}
		
		static public function clearMaps():void 
		{
			mapsData.clear();
		}
		
		public static function get robots():Array
		{
			return robotsData.getRobots();
		}
		
		public static function get cards():Array
		{
			return cardsData.getCards();
		}
		
		public static function get boardelements():Array
		{
			return boardElements.getBoardElements();
		}
		
		public static function get maps():Array
		{
			return mapsData.getMaps();
		}
	}

}