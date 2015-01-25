package particles
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import maps.Map;
	/**
	 * ...
	 * @author Jerry
	 */
	public class Particle extends Sprite
	{
		
		public var life:Number = 0;
		protected var living:Number = 0;
		public var position:Point;
		protected var velocity:Point;
		private var color:uint;
		private var map:Map;
		private var destroyed:Boolean = false;
		private var size:Number = 0;
		private var glowFilter:GlowFilter;
		
		
		public function Particle() 
		{
			
		}
		
		public function initialize(map:Map,life:Number,position:Point,velocity:Point,color:uint,particleSize:Number):void 
		{
			living = 0;
			this.map = map;
			this.life = life;
			this.position = position;
			this.velocity = velocity;
			this.color = color;
			this.map.addChild(this);
			this.addEventListener(Event.ENTER_FRAME, update);
			this.x = position.x;
			this.y = position.y;
			this.size = particleSize;
			glowFilter = new GlowFilter(color, 1, 6, 6);
			this.filters = [glowFilter];
			
		}
		
		private function update(e:Event):void 
		{
			life --;
			if (life <= 0) destroy();
			this.x += velocity.x;
			this.y += velocity.y;
			this.alpha-=0.03;
			draw();
		}
		
		
		public function destroy():void 
		{
			if(!destroyed){
				this.removeEventListener(Event.ENTER_FRAME, update);
				this.map.removeChild(this);
				destroyed = true;
			}
		}
		
		
		public function draw():void 
		{
			graphics.clear();
			graphics.beginFill(color);
			//graphics.drawCircle(0, 0, size);
			graphics.drawRect(0, 0, size, size);
			graphics.endFill();
		}
		
	}

}