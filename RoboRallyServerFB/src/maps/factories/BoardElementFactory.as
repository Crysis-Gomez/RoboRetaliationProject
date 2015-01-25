package maps.factories 
{
	import maps.elements.base.BoardElement;
	import maps.elements.checkpoint.CheckPoint;
	import maps.elements.conveyorbelt.ConveyorBelt;
	import maps.elements.conveyorbelt.ConveyorBeltCorner;
	import maps.elements.conveyorbelt2x.ConveyorBelt2x;
	import maps.elements.gear.RotateGear;
	import maps.elements.conveyorbelt2x.ConveyorBelt2x;
	import maps.elements.pickup.PickUp;
	import maps.elements.pit.Pit;
	import maps.elements.repair.RepairElement;
	import maps.elements.start.StartElement;
	import models.data.BoardElementData;
	/**
	 * ...
	 * @author 
	 */
	public class BoardElementFactory
	{
		static private var instance:BoardElementFactory;
		
		public function BoardElementFactory(caller:Function = null)
		{
			if (caller != BoardElementFactory.getInstance)
				throw new Error("Singleton is a singleton class, use getInstance() instead");
			if (BoardElementFactory.instance != null)
				throw new Error("Only one Singleton instance should be instantieted");
		}
		
		static public function getInstance():BoardElementFactory
		{
			if (instance == null)
				instance = new BoardElementFactory(arguments.callee);
			return instance;
		}
		
		public function getBoardElement(type:String, deletable:Boolean, selectable:Boolean):BoardElement 
		{
			var element:BoardElement
			switch(type) {
				case "startElement":
					element = new StartElement(selectable, deletable);
					break;
				case "conveyorBelt":
					element = new ConveyorBelt(selectable, deletable);
					
					break;
				case "conveyorBelt2x":
					element = new ConveyorBelt2x(selectable, deletable);
					
					break;
				case "conveyorBeltCorner":
					
					element = new ConveyorBeltCorner(selectable, deletable);
					break;
					
				case "rotateGear":
					
					element = new RotateGear(selectable, deletable);
				
					
					break;
				case "repairElement":
					
					element = new RepairElement(selectable, deletable);
					break;
					
				case "pit":
					
					element = new Pit(selectable, deletable);
					break;
					
				case "checkPoint":
					
					element = new CheckPoint(selectable, deletable);
					
					break;
				case "pickUp":
					element = new PickUp(selectable, deletable);
					break;
				default:
					return null;
					trace("unsupported board element");
					break;
			}
			element.deletable = deletable;
			element.selectable = selectable;
			return element
		}
		
	}

}