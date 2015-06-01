package org.mcv.utils
{
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Stage;
	import flash.geom.Point;
	import org.mcv.components.DebugDisplay;
	import org.mcv.utils.TouchObjectDictionary;
	
	public class HitObjectTest
	{
		
		/**
		 * Searches display list for top most instance of InteractiveObject.
		 * Checks if mouseEnabled is true and (optionally) parent's mouseChildren.
		 * @param stage				Stage object.
		 * @param point				Global point to test.
		 * @param mouseChildren		If true also checks parents chain for mouseChildren == true.
		 * @param startFrom			An index to start looking from in objects under point array.
		 * @return					Top most InteractiveObject or Stage.
		 */
		public static function getTopTarget(stage:Stage, point:Point, startFrom:uint = 0):DisplayObjectContainer
		{
			var targets:Array = stage.getObjectsUnderPoint(point);
			if (!targets.length)
				return stage;
			
			var startIndex:int = targets.length - 1 - startFrom;
			if (startIndex < 0)
				return stage;
			
			for (var i:int = startIndex; i >= 0; i--)
			{
				var target:DisplayObjectContainer = targets[i];
				
				if (target is DebugDisplay)
				{
					continue;
				}
				
				if (target != stage as Stage)
				{
					//if (TouchObjectDictionary.getByKey(target.name) != null)
					//{
					return target;
						//}
					
				}
			}
			
			return stage;
		}
	
	}
}