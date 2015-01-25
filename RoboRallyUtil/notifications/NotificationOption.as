package notifications 
{
	/**
	 * ...
	 * @author RB
	 */
	public class NotificationOption 
	{
		public var data:*;
		public var text:String;
		public var callback:Function;
		
		public function NotificationOption(text:String, callback:Function, data:* = null)
		{
			this.data = data;
			this.text = text;
			this.callback = callback;
			
		}
		
	}

}