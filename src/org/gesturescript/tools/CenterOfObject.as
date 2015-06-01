package org.gesturescript.tools
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	public class CenterOfObject
	{
		public static function measure(point:Dictionary):Point
		{
			var pointCount:int;
			var centerX:Number = 0;
			var centerY:Number = 0;
			var p:Point
			
			for each (var pObject:Object in point)
			{
				centerX += pObject.stageX;
				centerY += pObject.stageY;
				
				pointCount++;
			}
			
			if (pointCount <= 1)
				p = new Point((centerX), (centerY));
			else
				p = new Point((centerX / pointCount), (centerY / pointCount))
			
			return p;
		}
	}

}