package org.mcv.utils 
{
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	import org.mcv.objects.TouchPointObject;
	
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	public class TouchPointDictionary 
	{		
		public static var d:Dictionary = new Dictionary();
		
		public static function add(id:int, actor:DisplayObject, pointDownX:Number, pointDownY:Number):TouchPointObject
		{
			var idString:String = String(id);
			var tpo:TouchPointObject = new TouchPointObject(actor, pointDownX, pointDownY, id);
			d[idString] = tpo;
			
			return tpo;
		}
		
		public static function getByKey(value:String):TouchPointObject
		{
			return d[value];
		}
		
	}

}