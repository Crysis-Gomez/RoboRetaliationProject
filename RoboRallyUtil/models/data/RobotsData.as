package models.data
{
	import flash.display.Bitmap;
	import logger.Logger;
	import models.data.RobotData;
	/**
	 * ...
	 * @author 
	 */
	public class RobotsData
	{
		private static var robots:Array = new Array();
		
		[Embed(source = "../../assets/robots/number5.png")] private var number5Class:Class;
		private var number5:Bitmap = new number5Class();
		[Embed(source = "../../assets/robots/r2d2.png")] private var r2d2Class:Class;
		private var r2d2:Bitmap = new r2d2Class();
		[Embed(source = "../../assets/robots/rob.png")] private var robClass:Class;
		private var rob:Bitmap = new robClass();
		[Embed(source = "../../assets/robots/wall-e.png")] private var walleClass:Class;
		private var walle:Bitmap = new walleClass();
		
		[Embed(source = "../../assets/robots/number5top.png")] private var number5topClass:Class;
		//private var number5top:Bitmap = new number5topClass();
		[Embed(source = "../../assets/robots/r2d2top.png")] private var r2d2topClass:Class;
		//private var r2d2top:Bitmap = new r2d2topClass();
		[Embed(source = "../../assets/robots/robtop.png")] private var robtopClass:Class;
		//private var robtop:Bitmap = new robtopClass();
		[Embed(source = "../../assets/robots/wall-etop.png")] private var walletopClass:Class;
		//private var walletop:Bitmap = new walletopClass();
		
		public function RobotsData() 
		{
			
		}
		
		public function loadRobots():void 
		{
			Logger.getInstance().log("Loading Robots");
			
			robots.push(createRobot(0, "Number 5", number5, number5topClass));
			robots.push(createRobot(1, "R2D2", r2d2, r2d2topClass));
			robots.push(createRobot(2, "Rob", rob, robtopClass));
			robots.push(createRobot(3, "Wall-E", walle, walletopClass));
		}
		
		public function getRobots():Array 
		{
			return robots
		}
		
		private function createRobot(id:Number, name:String, image:Bitmap, topimage:Class):RobotData 
		{
			var robotData:RobotData = new RobotData();
			robotData.id = id;
			robotData.name = name;
			robotData.image = image;
			robotData.topimage = topimage
			return robotData;
		}
		
		
	}

}