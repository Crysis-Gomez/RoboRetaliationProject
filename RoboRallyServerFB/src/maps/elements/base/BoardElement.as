package maps.elements.base 
{
	import core.Game;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.text.ReturnKeyLabel;
	import logger.Logger;
	import maps.elements.player.base.PlayerBoardElement;
	import maps.elements.player.Player;
	import maps.tools.MapEditingTools;
	import spark.effects.AnimateFilter;
	/**
	 * ...
	 * @author 
	 */
	public class BoardElement extends Sprite
	{
		private var inEditingTools:Boolean;
		public var deletable:Boolean;
		public var selectable:Boolean;
		private var _selected:Boolean;
		private var _xPos:int;
		private var _yPos:int;
		public var type:String;
	
		
		public function BoardElement(selectable:Boolean, deletable:Boolean) 
		{
			this.selectable = selectable;
			this.deletable = deletable;
	
			if (selectable == true) {
				if (deletable == false) 
				{
					inEditingTools = true;
					this.addEventListener(MouseEvent.CLICK, onClick);
				}
				
			}
			draw()
		}
		
		
		private function onClick(e:Event):void 
		{
			if (selected) {
				deselect();
			} else {
				select();
			}
		}
		
		public function deselect():void 
		{
			selected = false;
			if (!inEditingTools) {
				MapEditingTools.getInstance().removeProperties();
			}
		}
		
		public function select():void 
		{
			selected = true;
			if (!inEditingTools) {
				MapEditingTools.getInstance().showProperties(this);
			}
		}
		
		public function toXML():String 
		{
			//Function should be overwritten !
			return "";
		}
		
		public function setPos(xPos:int, yPos:int):void 
		{
			_yPos = yPos;
			_xPos = xPos;
		}	
		
		public function draw():void
		{
			//Should be overwritten
		}
		
		public function setPropertie(propertie:*):void 
		{
			//Should be overwritten
		}
		
		public function doAction(robot:PlayerBoardElement, aElementFinished:Function, finishedFunction:Function, length:uint, registerIndex:int):void 
		{
			Logger.getInstance().log("Activating " + type +" on x: " + xPos + " y :" + yPos + " in " + registerIndex);
			//should be overwritten
		}
		
		public function getDirection():int 
		{
			//should be overwritten
			return 0;
		}
		
		public function switchDirection(aItemFinished:Function, itemsPlayed:Array,game:Game):void 
		{
			//should be overwritten
		}
		
		public function highlight():void 
		{
			filters = [new GlowFilter(0xFFFFFF,0.8,10,10)];
		}
		
		public function unhighlight():void 
		{
			filters = null;
		}
		
		
		public function get selected():Boolean 
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void 
		{
			_selected = value;
			if (selected) {
				filters = [new GlowFilter(0x000000)];
				if (inEditingTools) {
					MapEditingTools.selectedItem = this;
				}
			} else {
				filters = null;
				if (inEditingTools) {
					MapEditingTools.selectedItem = null;
				}
			}
			
		}
		
		public function get xPos():int 
		{
			return _xPos;
		}
		
		public function get yPos():int 
		{
			return _yPos;
		}
		
	}

}