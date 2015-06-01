package org.mcv.objects
{
	
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	public class CursorObject
	{
		
		public function CursorObject(touchID:int, x:Number, y:Number, xSpeed:Number, ySpeed:Number, acceleration:Number)
		{
			this.touchID = touchID;
			this.x = x;
			this.y = y;
			this.xSpeed = xSpeed;
			this.ySpeed = ySpeed;
			this.acceleration = acceleration;
		}
		
		public function update(x:Number, y:Number, xSpeed:Number, ySpeed:Number, acceleration:Number):void
		{
			this.x = x;
			this.y = y;
			this.xSpeed = xSpeed;
			this.ySpeed = ySpeed;
			this.acceleration = acceleration;
		}
		
		public var touchID:uint;
		public var x:Number;
		public var y:Number;
		public var xSpeed:Number;
		public var ySpeed:Number;
		public var acceleration:Number;
	
	}

}