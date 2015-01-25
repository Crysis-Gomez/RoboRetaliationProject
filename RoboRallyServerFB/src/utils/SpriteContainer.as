package utils 
{
	import flash.display.Sprite;
	import mx.core.UIComponent;
	/**
	 * ...
	 * @author 
	 */
	public class SpriteContainer extends UIComponent
	{
		
		public function SpriteContainer(sprite:Sprite) 
		{
			super ();
			explicitHeight = sprite.height;
			explicitWidth = sprite.width;
			
			addChild (sprite);
		}
		
	}

}