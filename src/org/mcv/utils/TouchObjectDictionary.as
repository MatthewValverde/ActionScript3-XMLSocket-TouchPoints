package org.mcv.utils
{
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	import org.mcv.objects.StencylActorObject;
	
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	
	public class TouchObjectDictionary
	{		
		public static var d:Dictionary = new Dictionary();
		
		public static function add(displayObject:DisplayObject, name:String):String
		{			
			d[name] = new StencylActorObject(displayObject);
			
			return name;
		}
		
		public static function getByKey(value:String):StencylActorObject
		{
			return d[value];
		}
	
	}

}