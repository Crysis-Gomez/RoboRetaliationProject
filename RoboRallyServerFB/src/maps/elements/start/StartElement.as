package maps.elements.start 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import maps.elements.base.BoardElement;
	/**
	 * ...
	 * @author 
	 */
	public class StartElement extends BoardElement
	{
		private var _id:int = 0;
		
		[Embed(source = "assets/startPoint1.png")] private var startElement1Class:Class;
		[Embed(source = "assets/startPoint2.png")] private var startElement2Class:Class;
		[Embed(source = "assets/startPoint3.png")] private var startElement3Class:Class;
		[Embed(source = "assets/startPoint4.png")] private var startElement4Class:Class;
		[Embed(source = "assets/startPoint5.png")] private var startElement5Class:Class;
		[Embed(source = "assets/startPoint6.png")] private var startElement6Class:Class;
		[Embed(source = "assets/startPoint7.png")] private var startElement7Class:Class;
		[Embed(source = "assets/startPoint8.png")] private var startElement8Class:Class;
		[Embed(source = "assets/startPointX.png")] private var startElementXClass:Class;
		
		
		
		private var startElement1Bitmap:Bitmap = new startElement1Class();
		private var startElement2Bitmap:Bitmap = new startElement2Class();
		private var startElement3Bitmap:Bitmap = new startElement3Class();
		private var startElement4Bitmap:Bitmap = new startElement4Class();
		private var startElement5Bitmap:Bitmap = new startElement5Class();
		private var startElement6Bitmap:Bitmap = new startElement6Class();
		private var startElement7Bitmap:Bitmap = new startElement7Class();
		private var startElement8Bitmap:Bitmap = new startElement8Class();
		private var startElementXBitmap:Bitmap = new startElementXClass();
		
		private var bitmaps:Array = new Array(startElementXBitmap, startElement1Bitmap, startElement2Bitmap, startElement3Bitmap, startElement4Bitmap, startElement5Bitmap, startElement6Bitmap, startElement7Bitmap, startElement8Bitmap);
		public function StartElement(selectable:Boolean, deletable:Boolean) 
		{
			super(selectable, deletable);
			type = "startElement";
		}
		
		override public function draw():void 
		{
			super.draw();
			graphics.clear();
			graphics.beginBitmapFill((bitmaps[id] as Bitmap).bitmapData);
			graphics.drawRect(0, 0, 60, 60);
			graphics.endFill();
			
		}
		
		public function get id():int 
		{
			return _id;
		}
		
		public function set id(value:int):void 
		{
			_id = value;
			if (id > 8 || id < 0) {
				id = 0;
			}
			draw();
		}
		
		override public function toXML():String 
		{
			var xmlString:String = "";
			xmlString += "<boardelement>";
			xmlString += "<type>" + type + "</type>";
			xmlString += "<propertie>" + id + "</propertie>";
			xmlString += "<x>" + xPos + "</x>";
			xmlString += "<y>" + yPos + "</y>";
			xmlString += "</boardelement>";
			
			
			return xmlString;
		}
		
		override public function setPropertie(propertie:*):void 
		{
			id = propertie;
		
		}
		
	}

}