package notifications
{
	
	/**
	 * ...
	 * @author Jerry
	 */
	public class NotificationManager 
	{
		static private var instance:NotificationManager;
		private var navigator:*;
		private var notificationActive:Boolean;
		private var notification:Notification;
		
		public function NotificationManager(caller:Function = null) 
		{
			if (caller != NotificationManager.getInstance)
				throw new Error("Singleton is a singleton class, use getInstance() instead");
			if (NotificationManager.instance != null)
				throw new Error("Only one Singleton instance should be instantieted");
		}
		
		static public function getInstance():NotificationManager 
		{
			if (instance == null) instance = new NotificationManager(arguments.callee);
			return instance;
		}
		
		
		public function initialize(navigator:*):void 
		{
			this.navigator = navigator;
		}
		
		
		public function notify(message:String, options:Array, timeActive:int = 0):void 
		{
			if (notificationActive) return;
			
			notification = new Notification();
			
			(notification as Notification).setData(this, message, options);
			try {
				navigator.activeView.addElement(notification);
			} catch (e:Error) {
				if (navigator != null) {
	
				navigator.addElement(notification);
				}
			}
			
			notificationActive = true;
			
		}
		
		public function removeNotification():void 
		{
			try {
				navigator.activeView.removeElement(notification);
			} catch (e:Error) {
				if (navigator.contains(notification)) {
					navigator.removeElement(notification);
				}
			}
			
			notificationActive = false;
			
			
			
			
			
		}
		
	}

}