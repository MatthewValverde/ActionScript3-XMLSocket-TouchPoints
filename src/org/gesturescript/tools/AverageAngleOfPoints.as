package org.gesturescript.tools
{
	
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	public class AverageAngleOfPoints
	{
		public static function measure(target:*):Number
		{
			var x:Number = 0;
			var y:Number = 0;
			
			for each (var point:Object in target.point)
			{
				var angle:Number = (Math.atan2((point.stageY - target.centerOfPoints.y), (point.stageX - target.centerOfPoints.x))) + point.rotationDifference;
				
				x += Math.cos(angle);
				y += Math.sin(angle);
			}
			
			return Math.atan2(y, x);
		}
	}

}