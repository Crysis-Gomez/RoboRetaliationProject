package maps.elements 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import maps.Node;
	/**
	 * ...
	 * @author Jerry
	 */
	public class Wall extends Sprite
	{
		
		private var _id:int = 0;
		private var _type:String = "";
		private var _node:Node;
		
		[Embed(source = "wallt.png")] private var wallClass:Class;
		private var wallBitmap:Bitmap = new wallClass();
		
		[Embed(source = "wallLeft.png")] private var wallLeftClass:Class;
		private var wallLeftBitmap:Bitmap = new wallLeftClass();
		
		public function Wall(string:String,node:Node) 
		{
			type = string;
			_node = node;
		}
		
		
		public function horizontalDraw():void 
		{
		
			graphics.clear();
			graphics.beginBitmapFill(wallBitmap.bitmapData);
			graphics.drawRect(0, 0, 60, 10);
			graphics.endFill();
			
		}
		
		public function verticalDraw():void 
		{
			graphics.clear();
			graphics.beginBitmapFill(wallLeftBitmap.bitmapData);
			graphics.drawRect(0, 0, 10, 60);
			graphics.endFill();
		}
		
		
		
		public function removeNode():void 
		{
			if(_node.contains(this))_node.removeChild(this);
		}
		
		
		public function addToNode():void 
		{
			if (_node.contains(this)) return;
			_node.addChild(this);
			switch (type) 
			{
				case "up":
						this.x = 0;
						this.y = 0;
						horizontalDraw();
				break;
				
				
				case "down":
						this.x = 0;
						this.y = 50;
						horizontalDraw();
				break;
				
				case "left":
						this.x = 0;
						this.y = 0;
						verticalDraw();
					
					break;
				case "right":
						this.x = 50;
						this.y = 0;
						verticalDraw();
					break;
			}
			
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		public function set type(value:String):void 
		{
			_type = value;
		}

	}

}