package org.mcv.components
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	
	public class DebugDisplay extends Sprite
	{
		private var textField:Text;
		
		public function DebugDisplay(value:String)
		{
			super();
			
			mouseChildren = false;
			
			textField = new Text(value, 12, "OpenSans");
			addChild(textField);
			textField.mouseEnabled = false;
			textField.x = 20
		}
		
		public function theme(bool:Boolean):void
		{
			var color:uint = 0x111111;
			
			if (!bool)
			{
				color = 0xeeeeee;
			}
			
			graphics.clear();
			graphics.lineStyle(2, color);
			graphics.beginFill(color, .5);
			graphics.drawCircle(0, 0, 15);
			graphics.endFill();
			
			textField.textColor = color;
		}
	
	}
}