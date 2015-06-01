package org.mcv.utils 
{
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import org.mcv.events.TouchManagerEvent;
	import org.mcv.objects.TouchObject;
	
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	public class NativeMultitouch extends EventDispatcher 
	{
		public static var dispatch:EventDispatcher = new EventDispatcher();
		
		public function NativeMultitouch(target:flash.events.IEventDispatcher=null) 
		{
			super(target);
		}
		
		public static function init(stage:Stage):void
		{			
			Multitouch.inputMode =  MultitouchInputMode.TOUCH_POINT;// : MultitouchInputMode.NONE;
			stage.addEventListener(TouchEvent.TOUCH_BEGIN, touchDownHandler);
			stage.addEventListener(TouchEvent.TOUCH_MOVE, touchMoveHandler);
			stage.addEventListener(TouchEvent.TOUCH_END, touchUpHandler);
			
			trace("yo");
		}
		
		private static function touchDownHandler(event:TouchEvent):void
		{
			var touchObject:TouchObject = new TouchObject(event.touchPointID, event.stageX, event.stageY);
			touchObject.isNativeTouch = true;
			dispatch.dispatchEvent(new TouchManagerEvent(TouchManagerEvent.DOWN, touchObject));
		}
		
		private static function touchMoveHandler(event:TouchEvent):void
		{
			var touchObject:TouchObject = new TouchObject(event.touchPointID, event.stageX, event.stageY);
			touchObject.isNativeTouch = true;
			
			dispatch.dispatchEvent(new TouchManagerEvent(TouchManagerEvent.MOVE, touchObject));
		}
		
		private static function touchUpHandler(event:TouchEvent):void
		{
			var touchObject:TouchObject = new TouchObject(event.touchPointID, event.stageX, event.stageY);
			touchObject.isNativeTouch = true;
			
			dispatch.dispatchEvent(new TouchManagerEvent(TouchManagerEvent.UP, touchObject));
		}
	}

}