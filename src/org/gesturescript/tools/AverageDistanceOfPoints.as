package org.gesturescript.tools
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	public class AverageDistanceOfPoints
	{
		public static function measure(center:Point, point:Dictionary):Number
		{
			var total:Number = 0;
			var count:int;
			
			for each (var pObject:Object in point)
			{
				total += DistanceCenterToPoint.measure(center, new Point(pObject.stageX, pObject.stageY));
				count++;
			}
			
			return total / count;
		}
	}

}