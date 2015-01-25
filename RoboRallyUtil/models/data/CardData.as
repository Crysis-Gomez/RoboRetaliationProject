package models.data
{
	
	/**
	 * ...
	 * @author
	 */
	public class CardData
	{
		public var priority:uint;
		public var action:String;
		public var amount:Number;
		public var player:*;
		public var locked:Boolean = false;
		
		public function CardData()
		{
		
		}
		
		public function toString():String
		{
			return "" + priority + " " + action + " " + amount + "";
		}
	}

}