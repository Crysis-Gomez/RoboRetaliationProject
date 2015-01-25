package models.connection 
{
	/**
	 * ...
	 * @author Robby Braaksma
	 */
	public class PickUpRequest 
	{
		public const type:String = "pickup_request";
		public var pickuptype:String;
		public var uid:Number;
		public var arg:*;
		
		public function PickUpRequest() 
		{
			
		}
		
	}

}