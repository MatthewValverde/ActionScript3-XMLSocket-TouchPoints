package org.gesturescript.tools
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	public class CenterToPointAngleDeg
	{
		public static function measure(center:Point, point:Point):Number
		{
			return Math.atan2((point.y - center.y), (point.x - center.x)) * (180 / Math.PI);
		}
	}

}