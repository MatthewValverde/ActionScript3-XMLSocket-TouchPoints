package org.gesturescript.tools
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	public class DistanceCenterToPoint
	{
		public static function measure(center:Point, point:Point):Number
		{
			return Math.sqrt(((center.x - point.x) * (center.x - point.x)) + ((center.y - point.y) * (center.y - point.y)));
		}
	}
}