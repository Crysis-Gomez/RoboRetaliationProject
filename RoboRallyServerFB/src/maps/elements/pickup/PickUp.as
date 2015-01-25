package maps.elements.pickup 
{
	import flash.display.Bitmap;
	import maps.elements.base.BoardElement;
	
	/**
	 * ...
	 * @author Robby Braaksma
	 */
	public class PickUp extends BoardElement 
	{
		private var _pickUpType:String;
		
		[Embed(source = "PickUp.png")] private var pickUpClass:Class;
		private var pickUpBitmap:Bitmap = new pickUpClass();
		
		public function PickUp(selectable:Boolean, deletable:Boolean) 
		{
			super(selectable, deletable);
			type = "pickUp";
			var id:int = Math.floor(Math.random() * 2);
			switch(id) {
				case 0:
					_pickUpType = "LightsOff"
					break;
				case 1:
					_pickUpType = "SwitchDirection"
					break;
				default:
					trace("NO PICK UP SHOULDNT HAPPEN");
					break;
				
			}
		}
		override public function draw():void 
		{
			super.draw();
			graphics.clear();
			//graphics.beginFill(0xDD9B11);
			graphics.beginBitmapFill(pickUpBitmap.bitmapData);
			graphics.drawRect(10, 10, 40, 40);
			graphics.endFill();
		}
		
		public function get pickUpType():String 
		{
			return _pickUpType;
		}
		
	}

}