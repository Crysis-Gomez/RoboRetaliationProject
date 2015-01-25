package maps.elements.pit 
{
	import flash.display.Bitmap;
	import maps.elements.base.BoardElement;
	
	/**
	 * ...
	 * @author Jerry
	 */
	public class Pit extends BoardElement 
	{
		
		[Embed(source = "assets/pit3.png")] private var pitClass:Class;
		
		private var pitBitmap:Bitmap = new pitClass();
		private var _id:int = 0;
		
		public function Pit(selectable:Boolean, deletable:Boolean) 
		{
			super(selectable, deletable);
			type = "pit";
		}
		
		
		override public function draw():void 
		{
			super.draw();
			graphics.clear();
			graphics.beginBitmapFill(pitBitmap.bitmapData);
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