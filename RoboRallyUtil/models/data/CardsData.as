package models.data 
{
	import flash.display.Bitmap;
	import logger.Logger;
	/**
	 * ...
	 * @author 
	 */
	public class CardsData 
	{
		private static var cards:Array = new Array();
		private static var roundOneCards:Array = new Array();
		
		[Embed(source = "../../assets/cards/10.png")] private var cardPriority10Class:Class;
		[Embed(source = "../../assets/cards/20.png")] private var cardPriority20Class:Class;
		[Embed(source = "../../assets/cards/30.png")] private var cardPriority30Class:Class;
		[Embed(source = "../../assets/cards/40.png")] private var cardPriority40Class:Class;
		[Embed(source = "../../assets/cards/50.png")] private var cardPriority50Class:Class;
		[Embed(source = "../../assets/cards/60.png")] private var cardPriority60Class:Class;
		[Embed(source = "../../assets/cards/70.png")] private var cardPriority70Class:Class;
		[Embed(source = "../../assets/cards/80.png")] private var cardPriority80Class:Class;
		[Embed(source = "../../assets/cards/90.png")] private var cardPriority90Class:Class;
		[Embed(source = "../../assets/cards/100.png")] private var cardPriority100Class:Class;
		[Embed(source = "../../assets/cards/110.png")] private var cardPriority110Class:Class;
		[Embed(source = "../../assets/cards/120.png")] private var cardPriority120Class:Class;
		[Embed(source = "../../assets/cards/130.png")] private var cardPriority130Class:Class;
		[Embed(source = "../../assets/cards/140.png")] private var cardPriority140Class:Class;
		[Embed(source = "../../assets/cards/150.png")] private var cardPriority150Class:Class;
		[Embed(source = "../../assets/cards/160.png")] private var cardPriority160Class:Class;
		[Embed(source = "../../assets/cards/170.png")] private var cardPriority170Class:Class;
		[Embed(source = "../../assets/cards/180.png")] private var cardPriority180Class:Class;
		[Embed(source = "../../assets/cards/190.png")] private var cardPriority190Class:Class;
		[Embed(source = "../../assets/cards/200.png")] private var cardPriority200Class:Class;
		[Embed(source = "../../assets/cards/210.png")] private var cardPriority210Class:Class;
		[Embed(source = "../../assets/cards/220.png")] private var cardPriority220Class:Class;
		[Embed(source = "../../assets/cards/230.png")] private var cardPriority230Class:Class;
		[Embed(source = "../../assets/cards/240.png")] private var cardPriority240Class:Class;
		[Embed(source = "../../assets/cards/250.png")] private var cardPriority250Class:Class;
		[Embed(source = "../../assets/cards/260.png")] private var cardPriority260Class:Class;
		[Embed(source = "../../assets/cards/270.png")] private var cardPriority270Class:Class;
		[Embed(source = "../../assets/cards/280.png")] private var cardPriority280Class:Class;
		[Embed(source = "../../assets/cards/290.png")] private var cardPriority290Class:Class;
		[Embed(source = "../../assets/cards/300.png")] private var cardPriority300Class:Class;
		[Embed(source = "../../assets/cards/310.png")] private var cardPriority310Class:Class;
		[Embed(source = "../../assets/cards/320.png")] private var cardPriority320Class:Class;
		[Embed(source = "../../assets/cards/330.png")] private var cardPriority330Class:Class;
		[Embed(source = "../../assets/cards/340.png")] private var cardPriority340Class:Class;
		[Embed(source = "../../assets/cards/350.png")] private var cardPriority350Class:Class;
		[Embed(source = "../../assets/cards/360.png")] private var cardPriority360Class:Class;
		[Embed(source = "../../assets/cards/370.png")] private var cardPriority370Class:Class;
		[Embed(source = "../../assets/cards/380.png")] private var cardPriority380Class:Class;
		[Embed(source = "../../assets/cards/390.png")] private var cardPriority390Class:Class;
		[Embed(source = "../../assets/cards/400.png")] private var cardPriority400Class:Class;
		[Embed(source = "../../assets/cards/410.png")] private var cardPriority410Class:Class;
		[Embed(source = "../../assets/cards/420.png")] private var cardPriority420Class:Class;
		[Embed(source = "../../assets/cards/430.png")] private var cardPriority430Class:Class;
		[Embed(source = "../../assets/cards/440.png")] private var cardPriority440Class:Class;
		[Embed(source = "../../assets/cards/450.png")] private var cardPriority450Class:Class;
		[Embed(source = "../../assets/cards/460.png")] private var cardPriority460Class:Class;
		[Embed(source = "../../assets/cards/470.png")] private var cardPriority470Class:Class;
		[Embed(source = "../../assets/cards/480.png")] private var cardPriority480Class:Class;
		[Embed(source = "../../assets/cards/490.png")] private var cardPriority490Class:Class;
		[Embed(source = "../../assets/cards/500.png")] private var cardPriority500Class:Class;
		[Embed(source = "../../assets/cards/510.png")] private var cardPriority510Class:Class;
		[Embed(source = "../../assets/cards/520.png")] private var cardPriority520Class:Class;
		[Embed(source = "../../assets/cards/530.png")] private var cardPriority530Class:Class;
		[Embed(source = "../../assets/cards/540.png")] private var cardPriority540Class:Class;
		[Embed(source = "../../assets/cards/550.png")] private var cardPriority550Class:Class;
		[Embed(source = "../../assets/cards/560.png")] private var cardPriority560Class:Class;
		[Embed(source = "../../assets/cards/570.png")] private var cardPriority570Class:Class;
		[Embed(source = "../../assets/cards/580.png")] private var cardPriority580Class:Class;
		[Embed(source = "../../assets/cards/590.png")] private var cardPriority590Class:Class;
		[Embed(source = "../../assets/cards/600.png")] private var cardPriority600Class:Class;
		[Embed(source = "../../assets/cards/610.png")] private var cardPriority610Class:Class;
		[Embed(source = "../../assets/cards/620.png")] private var cardPriority620Class:Class;
		[Embed(source = "../../assets/cards/630.png")] private var cardPriority630Class:Class;
		[Embed(source = "../../assets/cards/640.png")] private var cardPriority640Class:Class;
		[Embed(source = "../../assets/cards/650.png")] private var cardPriority650Class:Class;
		[Embed(source = "../../assets/cards/660.png")] private var cardPriority660Class:Class;
		[Embed(source = "../../assets/cards/670.png")] private var cardPriority670Class:Class;
		[Embed(source = "../../assets/cards/680.png")] private var cardPriority680Class:Class;
		[Embed(source = "../../assets/cards/690.png")] private var cardPriority690Class:Class;
		[Embed(source = "../../assets/cards/700.png")] private var cardPriority700Class:Class;
		[Embed(source = "../../assets/cards/710.png")] private var cardPriority710Class:Class;
		[Embed(source = "../../assets/cards/720.png")] private var cardPriority720Class:Class;
		[Embed(source = "../../assets/cards/730.png")] private var cardPriority730Class:Class;
		[Embed(source = "../../assets/cards/740.png")] private var cardPriority740Class:Class;
		[Embed(source = "../../assets/cards/750.png")] private var cardPriority750Class:Class;
		[Embed(source = "../../assets/cards/760.png")] private var cardPriority760Class:Class;
		[Embed(source = "../../assets/cards/770.png")] private var cardPriority770Class:Class;
		[Embed(source = "../../assets/cards/780.png")] private var cardPriority780Class:Class;
		[Embed(source = "../../assets/cards/790.png")] private var cardPriority790Class:Class;
		[Embed(source = "../../assets/cards/800.png")] private var cardPriority800Class:Class;
		[Embed(source = "../../assets/cards/810.png")] private var cardPriority810Class:Class;
		[Embed(source = "../../assets/cards/820.png")] private var cardPriority820Class:Class;
		[Embed(source = "../../assets/cards/830.png")] private var cardPriority830Class:Class;
		[Embed(source = "../../assets/cards/840.png")] private var cardPriority840Class:Class;
		
		private var cardpriority10:Bitmap = new cardPriority10Class();
		private var cardpriority20:Bitmap = new cardPriority20Class();
		private var cardpriority30:Bitmap = new cardPriority30Class();
		private var cardpriority40:Bitmap = new cardPriority40Class();
		private var cardpriority50:Bitmap = new cardPriority50Class();
		private var cardpriority60:Bitmap = new cardPriority60Class();
		private var cardpriority70:Bitmap = new cardPriority70Class();
		private var cardpriority80:Bitmap = new cardPriority80Class();
		private var cardpriority90:Bitmap = new cardPriority90Class();
		private var cardpriority100:Bitmap = new cardPriority100Class();
		private var cardpriority110:Bitmap = new cardPriority110Class();
		private var cardpriority120:Bitmap = new cardPriority120Class();
		private var cardpriority130:Bitmap = new cardPriority130Class();
		private var cardpriority140:Bitmap = new cardPriority140Class();
		private var cardpriority150:Bitmap = new cardPriority150Class();
		private var cardpriority160:Bitmap = new cardPriority160Class();
		private var cardpriority170:Bitmap = new cardPriority170Class();
		private var cardpriority180:Bitmap = new cardPriority180Class();
		private var cardpriority190:Bitmap = new cardPriority190Class();
		private var cardpriority200:Bitmap = new cardPriority200Class();
		private var cardpriority210:Bitmap = new cardPriority210Class();
		private var cardpriority220:Bitmap = new cardPriority220Class();
		private var cardpriority230:Bitmap = new cardPriority230Class();
		private var cardpriority240:Bitmap = new cardPriority240Class();
		private var cardpriority250:Bitmap = new cardPriority250Class();
		private var cardpriority260:Bitmap = new cardPriority260Class();
		private var cardpriority270:Bitmap = new cardPriority270Class();
		private var cardpriority280:Bitmap = new cardPriority280Class();
		private var cardpriority290:Bitmap = new cardPriority290Class();
		private var cardpriority300:Bitmap = new cardPriority300Class();
		private var cardpriority310:Bitmap = new cardPriority310Class();
		private var cardpriority320:Bitmap = new cardPriority320Class();
		private var cardpriority330:Bitmap = new cardPriority330Class();
		private var cardpriority340:Bitmap = new cardPriority340Class();
		private var cardpriority350:Bitmap = new cardPriority350Class();
		private var cardpriority360:Bitmap = new cardPriority360Class();
		private var cardpriority370:Bitmap = new cardPriority370Class();
		private var cardpriority380:Bitmap = new cardPriority380Class();
		private var cardpriority390:Bitmap = new cardPriority390Class();
		private var cardpriority400:Bitmap = new cardPriority400Class();
		private var cardpriority410:Bitmap = new cardPriority410Class();
		private var cardpriority420:Bitmap = new cardPriority420Class();
		private var cardpriority430:Bitmap = new cardPriority430Class();
		private var cardpriority440:Bitmap = new cardPriority440Class();
		private var cardpriority450:Bitmap = new cardPriority450Class();
		private var cardpriority460:Bitmap = new cardPriority460Class();
		private var cardpriority470:Bitmap = new cardPriority470Class();
		private var cardpriority480:Bitmap = new cardPriority480Class();
		private var cardpriority490:Bitmap = new cardPriority490Class();
		private var cardpriority500:Bitmap = new cardPriority500Class();
		private var cardpriority510:Bitmap = new cardPriority510Class();
		private var cardpriority520:Bitmap = new cardPriority520Class();
		private var cardpriority530:Bitmap = new cardPriority530Class();
		private var cardpriority540:Bitmap = new cardPriority540Class();
		private var cardpriority550:Bitmap = new cardPriority550Class();
		private var cardpriority560:Bitmap = new cardPriority560Class();
		private var cardpriority570:Bitmap = new cardPriority570Class();
		private var cardpriority580:Bitmap = new cardPriority580Class();
		private var cardpriority590:Bitmap = new cardPriority590Class();
		private var cardpriority600:Bitmap = new cardPriority600Class();
		private var cardpriority610:Bitmap = new cardPriority610Class();
		private var cardpriority620:Bitmap = new cardPriority620Class();
		private var cardpriority630:Bitmap = new cardPriority630Class();
		private var cardpriority640:Bitmap = new cardPriority640Class();
		private var cardpriority650:Bitmap = new cardPriority650Class();
		private var cardpriority660:Bitmap = new cardPriority660Class();
		private var cardpriority670:Bitmap = new cardPriority670Class();
		private var cardpriority680:Bitmap = new cardPriority680Class();
		private var cardpriority690:Bitmap = new cardPriority690Class();
		private var cardpriority700:Bitmap = new cardPriority700Class();
		private var cardpriority710:Bitmap = new cardPriority710Class();
		private var cardpriority720:Bitmap = new cardPriority720Class();
		private var cardpriority730:Bitmap = new cardPriority730Class();
		private var cardpriority740:Bitmap = new cardPriority740Class();
		private var cardpriority750:Bitmap = new cardPriority750Class();
		private var cardpriority760:Bitmap = new cardPriority760Class();
		private var cardpriority770:Bitmap = new cardPriority770Class();
		private var cardpriority780:Bitmap = new cardPriority780Class();
		private var cardpriority790:Bitmap = new cardPriority790Class();
		private var cardpriority800:Bitmap = new cardPriority800Class();
		private var cardpriority810:Bitmap = new cardPriority810Class();
		private var cardpriority820:Bitmap = new cardPriority820Class();
		private var cardpriority830:Bitmap = new cardPriority830Class();
		private var cardpriority840:Bitmap = new cardPriority840Class();
		
		public static var priorities:Array = new Array( );
		
		public function CardsData() 
		{
			
		}
		
		public function loadCards():void 
		{	
			Logger.getInstance().log("Load Cards");
			cards.push(createCard(10, "rotate", 180));//0
			cards.push(createCard(20, "rotate", 180));
			cards.push(createCard(30, "rotate", 180));
			cards.push(createCard(40, "rotate", 180));
			cards.push(createCard(50, "rotate", 180));
			cards.push(createCard(60, "rotate", 180));
			cards.push(createCard(70, "rotate", -90));
			cards.push(createCard(80, "rotate", 90));
			cards.push(createCard(90, "rotate", -90));
			cards.push(createCard(100, "rotate", 90));
			cards.push(createCard(110, "rotate", -90));//10
			
			cards.push(createCard(120, "rotate", 90));
			cards.push(createCard(130, "rotate", -90));
			cards.push(createCard(140, "rotate", 90));
			cards.push(createCard(150, "rotate", -90));
			cards.push(createCard(160, "rotate", 90));
			cards.push(createCard(170, "rotate", -90));
			cards.push(createCard(180, "rotate", 90));
			cards.push(createCard(190, "rotate", -90));
			cards.push(createCard(200, "rotate", 90));
			cards.push(createCard(210, "rotate", -90));//20
			
			cards.push(createCard(220, "rotate", 90));
			cards.push(createCard(230, "rotate", -90));
			cards.push(createCard(240, "rotate", 90));
			cards.push(createCard(250, "rotate", -90));
			cards.push(createCard(260, "rotate", 90));
			cards.push(createCard(270, "rotate", -90));
			cards.push(createCard(280, "rotate", 90));
			cards.push(createCard(290, "rotate", -90));
			cards.push(createCard(300, "rotate", 90));
			cards.push(createCard(310, "rotate", -90));//30
			
			cards.push(createCard(320, "rotate", 90));
			cards.push(createCard(330, "rotate", -90));
			cards.push(createCard(340, "rotate", 90));
			cards.push(createCard(350, "rotate", -90));
			cards.push(createCard(360, "rotate", 90));
			cards.push(createCard(370, "rotate", -90));
			cards.push(createCard(380, "rotate", 90));
			cards.push(createCard(390, "rotate", -90));
			cards.push(createCard(400, "rotate", 90));
			cards.push(createCard(410, "rotate", -90));
			
			cards.push(createCard(420, "rotate", 90));//41
			
			cards.push(createCard(430, "back", 1));
			cards.push(createCard(440, "back", 1));
			cards.push(createCard(450, "back", 1));
			cards.push(createCard(460, "back", 1));
			cards.push(createCard(470, "back", 1));
			cards.push(createCard(480, "back", 1));
			
			cards.push(createCard(490, "forward", 1));
			cards.push(createCard(500, "forward", 1));
			cards.push(createCard(510, "forward", 1));//50
			
			cards.push(createCard(520, "forward", 1));
			cards.push(createCard(530, "forward", 1));
			cards.push(createCard(540, "forward", 1));
			cards.push(createCard(550, "forward", 1));
			cards.push(createCard(560, "forward", 1));
			cards.push(createCard(570, "forward", 1));
			cards.push(createCard(580, "forward", 1));
			cards.push(createCard(590, "forward", 1));
			cards.push(createCard(600, "forward", 1));
			cards.push(createCard(610, "forward", 1));//60
			cards.push(createCard(620, "forward", 1));
			cards.push(createCard(630, "forward", 1));
			cards.push(createCard(640, "forward", 1));
			cards.push(createCard(650, "forward", 1));
			cards.push(createCard(660, "forward", 1));
			
			cards.push(createCard(670, "forward", 2));
			cards.push(createCard(680, "forward", 2));
			cards.push(createCard(690, "forward", 2));
			cards.push(createCard(700, "forward", 2));
			cards.push(createCard(710, "forward", 2));//70
			cards.push(createCard(720, "forward", 2));
			cards.push(createCard(730, "forward", 2));
			cards.push(createCard(740, "forward", 2));
			cards.push(createCard(750, "forward", 2));
			cards.push(createCard(760, "forward", 2));
			cards.push(createCard(770, "forward", 2));
			cards.push(createCard(780, "forward", 2));
			
			cards.push(createCard(790, "forward", 3));//78
			cards.push(createCard(800, "forward", 3));
			cards.push(createCard(810, "forward", 3));
			cards.push(createCard(820, "forward", 3));
			cards.push(createCard(830, "forward", 3));
			cards.push(createCard(840, "forward", 3));
			
			priorities.push(null);
			for (var i:int = 10; i < 850; i += 10) {
				priorities.push(this["cardpriority" + i]);
			}
		}
		
		public function getCards():Array 
		{
			return cards
		}
		
		private function createCard(priority:uint, action:String, amount:Number):CardData 
		{
			var cardData:CardData = new CardData();
			cardData.priority = priority;
			cardData.action = action;
			cardData.amount = amount;
			
			return cardData;
		}
		
	}

}