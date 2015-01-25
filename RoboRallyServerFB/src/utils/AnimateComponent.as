package utils 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import maps.elements.base.BoardElement;
	import maps.elements.conveyorbelt.ConveyorBelt;
	/**
	 * ...
	 * @author Jerry
	 */
	public class AnimateComponent extends Sprite
	{
		private var objectBmp:Bitmap;
		private var current:Bitmap = new Bitmap();
		private var animateArray:Array = new Array();
		private var delay:int = 0;
		private var frameNumber:int = 0;
		private var point:Point = new Point(0, 0);
		private var rect:Rectangle;
		private var _parent:BoardElement;
		private var direction:String;
		private var stopAnimate:Boolean = false;
		private var aElementFinished:Function;
		private var finishedFunction:Function;
		private var length:uint;
		

		
		public function AnimateComponent(bit:Bitmap,width:int,height:int,parent:BoardElement) 
		{
			objectBmp = bit;
			rect = new Rectangle(0, 0, width, height);
			_parent = parent;
			init();
		}
		
		public function init():void 
		{
			current.smoothing = true;
			current.bitmapData = new BitmapData(60, 60);
			for (var i:int = 0; i < 3; i++)
			{
				rect.x = 60 * i;
				animateArray.push(new BitmapData(60, 60));
				animateArray[i].copyPixels(objectBmp.bitmapData, rect, point);
				
			}
		    current.bitmapData = animateArray[0];
		}
		
		public function start(aElementFinished:Function = null, length:uint = 0, finishedFunction:Function = null):void 
		{
			this.length = length;
			this.finishedFunction = finishedFunction;
			this.aElementFinished = aElementFinished;
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		
		
		public function get bitmap():Bitmap 
		{
			return objectBmp;
		}
		
		public function stop():void 
		{
			removeEventListener(Event.ENTER_FRAME, update);
			delay = 0;
			frameNumber = 0;
			current.bitmapData = animateArray[frameNumber];
			
			if (aElementFinished != null) {
				aElementFinished(length, finishedFunction);
			}
		}
		
		public function get currentBitmap():Bitmap
		{
			return current;
		}
		
	/*	public function setBitmap(bit:Bitmap):void 
		{
			objectBmp = bit;
			for (var i:int = 0; i < 3; i++)
			{
				rect.x = 60 * i;
				animateArray.push(new BitmapData(60, 60));
				animateArray[i].copyPixels(objectBmp.bitmapData, rect, point);
				
			}
		}*/
		
		private function update(e:Event):void 
		{
			
			delay++;
			if (delay > 3) {
				frameNumber++
				if (frameNumber >= 3) {
					frameNumber = 0;
					stop();
				}
				current.bitmapData = animateArray[frameNumber];
				delay = 0;
				_parent.draw();
			}

		}

	}

}