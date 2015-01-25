package models.data
{
	import logger.Logger;
	public class BoardElementsData
	{
		private static var elements:Array = new Array();
		
		public function BoardElementsData()
		{
		}
		
		public function loadBoardElements():void
		{
			Logger.getInstance().log("Loading board elements");
			elements.push(createBoardElement("startElement"));
			elements.push(createBoardElement("conveyorBelt"));
			elements.push(createBoardElement("conveyorBelt2x"));
			elements.push(createBoardElement("conveyorBeltCorner"));
			elements.push(createBoardElement("rotateGear"));
			elements.push(createBoardElement("repairElement"));
			elements.push(createBoardElement("pit"));
			elements.push(createBoardElement("checkPoint"));
		}
		
		private function createBoardElement(typeElement:String):BoardElementData
		{
			var boardElement:BoardElementData = new BoardElementData();
			boardElement.type = typeElement;
			return boardElement;
		}
		
		public function getBoardElements():Array 
		{
			return elements
		}
		
	}
}