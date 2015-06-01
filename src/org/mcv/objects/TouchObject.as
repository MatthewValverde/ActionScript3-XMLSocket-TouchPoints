package org.mcv.objects
{	
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	public class TouchObject extends Object
	{
		public var touchID:int;
		public var touchX:Number;
		public var touchY:Number;
		public var event:String;
		public var isNativeTouch:Boolean;
		
		public function TouchObject(id:int = 0, x:Number = 0, y:Number = 0)
		{
			touchID = id;
			touchX = x;
			touchY = y;
		}
	
	}

}