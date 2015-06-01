package org.mcv.objects
{
	
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	public class OSC2DObject
	{
		
		public function OSC2DObject()
		{
		
		}
		
		/**
		 * Object message string
		 */
		public var string:String;
		
		/**
		 * Object id
		 */
		public var touchID:uint;
		
		public var touchIDarray:Array = new Array();
		
		/**
		 * Object x coordinate
		 */
		public var x:Number;
		
		/**
		 * Object y coordinate
		 */
		public var y:Number;
		
		/**
		 * Object z coordinate
		 */
		public var z:Number;
		
		/**
		 * Object X speed
		 */
		public var xSpeed:Number;
		
		/**
		 * Object Y speed
		 */
		public var ySpeed:Number;
		
		/**
		 * Motion acceleration
		 */
		public var acceleration:Number;
		
		/**
		 * Object frame id
		 */
		public var frameID:uint;
	
	/*public function OSC2DObject(string:String, touchID:int, x:Number, y:Number, xSpeed:Number, ySpeed:Number, acceleration:Number)
	   {
	   this.string = string;
	   this.touchID = touchID;
	   this.x = x;
	   this.y = y;
	   this.xSpeed = xSpeed;
	   this.ySpeed = ySpeed;
	   this.acceleration = acceleration;
	 }*/
	
	}

}