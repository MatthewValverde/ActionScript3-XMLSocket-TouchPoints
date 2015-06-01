package org.mcv.events 
{
	import flash.events.Event;
	import org.mcv.objects.TouchObject;
	
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	public class TouchManagerEvent extends Event 
	{
		public static var DOWN:String = "TouchSourceEvent.DOWN";
		public static var MOVE:String = "TouchSourceEvent.MOVE";
		public static var UP:String = "TouchSourceEvent.UP";
		
		public var touchObject:TouchObject;
		
		public function TouchManagerEvent(type:String, touchObjectValue:TouchObject = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
			touchObject = touchObjectValue;
		} 
		
		public override function clone():Event 
		{ 
			return new TouchManagerEvent(type, touchObject, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("TouchSourceEvent", "type", "touchObject", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}