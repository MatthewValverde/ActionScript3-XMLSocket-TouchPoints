package org.mcv.utils 
{
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import org.mcv.events.TouchManagerEvent;
	import org.mcv.objects.TouchObject;
	
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	public class MouseTouch extends EventDispatcher 
	{
		public static var dispatch:EventDispatcher = new EventDispatcher();
		
		public static var touchID:int//; = -10000;
		
		private static var stage:Stage;
		
		public function MouseTouch(target:flash.events.IEventDispatcher=null) 
		{
			super(target);
		}
		
		public static function init(stageObject:Stage):void
		{			
			stage = stageObject;
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, touchDownHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, touchUpHandler);
		}
		
		private static function touchDownHandler(event:MouseEvent):void
		{
			touchID--;
			
			var touchObject:TouchObject = new TouchObject(touchID, event.stageX, event.stageY);
			touchObject.isNativeTouch = true;
			dispatch.dispatchEvent(new TouchManagerEvent(TouchManagerEvent.DOWN, touchObject));
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, touchMoveHandler);
		}
		
		private static function touchMoveHandler(event:MouseEvent):void
		{
			var touchObject:TouchObject = new TouchObject(touchID, event.stageX, event.stageY);
			touchObject.isNativeTouch = true;
			
			dispatch.dispatchEvent(new TouchManagerEvent(TouchManagerEvent.MOVE, touchObject));
		}
		
		private static function touchUpHandler(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, touchMoveHandler);
						
			var touchObject:TouchObject = new TouchObject(touchID, event.stageX, event.stageY);
			touchObject.isNativeTouch = true;
			
			dispatch.dispatchEvent(new TouchManagerEvent(TouchManagerEvent.UP, touchObject));
		}
	}

}