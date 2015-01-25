package maps 
{
	import flash.display.Sprite;
	import flash.xml.XMLNode;
	/**
	 * ...
	 * @author 
	 */
	public class Grid extends Sprite
	{
		private var _nodes:Array = new Array();
		private var map:Map;
		
		public function Grid(map:Map) 
		{
			this.map = map;
			loadNodes();
		}
		
		public function getNode(gridPosX:int, gridPosY:int):Node 
		{
			try {
				return _nodes[gridPosX][gridPosY];
			} catch (e:Error) {
				return null;
			}
			return null;
		}
		
		private function loadNodes():void 
		{
			for (var i:int = 0; i < 16; ++i) {
				_nodes[i] = new Array();
				for (var j:int = 0; j < 12; ++j) {
					var node:Node = new Node(i, j, this, map);
					_nodes[i][j] = node;
				}
			}
		}
		
		public function get nodes():Array 
		{
			return _nodes;
		}
	}

}