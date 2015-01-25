package utils
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import models.data.MapData;
	
	/**
	 * ...
	 * @author
	 */
	public class MapLoader
	{
		private var filesList:Array;
		private var mapLoadComplete:Function;
		private var count:int = 0;
		
		public function MapLoader(filesList:Array, mapLoadComplete:Function)
		{
			this.mapLoadComplete = mapLoadComplete;
			
			if (filesList != null)
			{
				this.filesList = filesList;
				for (var i:int = 0; i < filesList.length; i++)
				{
					loadMapFile(filesList[i].nativePath);
				}
			}
		}
		
		public function loadMapFile(path:String):void
		{
			var loader:URLLoader = new URLLoader(new URLRequest(path));
			loader.addEventListener(Event.COMPLETE, onComplete);
		}
		
		private function onComplete(e:Event):void
		{
			count++;
			var mapXML:XML = XML((e.target as URLLoader).data);
			
			var mapData:MapData = new MapData();
			mapData.fromXML(mapXML);
			
			GameData.addMap(mapData);
			
			if (filesList != null)
			{
				if (filesList.length == count)
				{
					mapLoadComplete();
				}
			}else {
				mapLoadComplete();
			}
		}
	
	}

}