package org.mcv.core
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.NetGroupSendMode;
	import flash.utils.Dictionary;
	import org.mcv.components.DebugDisplay;
	import org.mcv.objects.TouchObject;
	import org.mcv.utils.XMLSocketConnection;
	XMLSocketConnection;
	import org.mcv.events.TouchManagerEvent;
	TouchManagerEvent;
	import org.mcv.utils.NativeMultitouch;
	NativeMultitouch;
	import org.mcv.utils.MouseTouch;
	MouseTouch;
	
	import org.mcv.core.Fonts;
	Fonts;
	
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	
	public class TouchCoreBridge extends Sprite
	{
		public var debugDict:Dictionary = new Dictionary();
		public var debug:Boolean = true;
		
		private var stageWidth:Number = 0;
		private var stageHeight:Number = 0;
		
		private var currentStage:Stage;
		public var debugIsDark:Boolean;
		
		private var isNativeMultitouch:Boolean;
		
		public function TouchCoreBridge(flashStage:Stage = null, debugOn:Boolean = true, isDark:Boolean = true):void
		{
			debug = debugOn;
			debugIsDark = isDark;
			
			if (flashStage != null)
			{
				currentStage = flashStage;
				
				stageWidth = currentStage.stageWidth;
				stageHeight = currentStage.stageHeight;
			}
			else
			{
				if (stage)
				{
					init();
				}
				else
				{
					addEventListener(Event.ADDED_TO_STAGE, init);
				}
			}
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			currentStage = stage;
			
			stageWidth = currentStage.stageWidth;
			stageHeight = currentStage.stageHeight;
		}
		
		public function connect(isNativeMultitouch:Boolean = false):String
		{
			this.isNativeMultitouch = isNativeMultitouch;
			
			if (isNativeMultitouch)
			{
				NativeMultitouch.dispatch.addEventListener(TouchManagerEvent.DOWN, touchDownHandler);
				NativeMultitouch.dispatch.addEventListener(TouchManagerEvent.MOVE, touchMoveHandler);
				NativeMultitouch.dispatch.addEventListener(TouchManagerEvent.UP, touchUpHandler);
				NativeMultitouch.init(currentStage);
			}
			else
			{
				XMLSocketConnection.dispatch.addEventListener(TouchManagerEvent.DOWN, touchDownHandler);
				XMLSocketConnection.dispatch.addEventListener(TouchManagerEvent.MOVE, touchMoveHandler);
				XMLSocketConnection.dispatch.addEventListener(TouchManagerEvent.UP, touchUpHandler);
				XMLSocketConnection.connect();
				
				MouseTouch.dispatch.addEventListener(TouchManagerEvent.DOWN, touchDownHandler);
				MouseTouch.dispatch.addEventListener(TouchManagerEvent.MOVE, touchMoveHandler);
				MouseTouch.dispatch.addEventListener(TouchManagerEvent.UP, touchUpHandler);
				MouseTouch.init(currentStage);
			}
			
			return "CONNECT CALLED";
		}
		
		private function touchDownHandler(event:TouchManagerEvent):void
		{
			var touchObject:TouchObject = event.touchObject;
			var tox:Number = touchObject.touchX * currentStage.stageWidth;
			var toy:Number = touchObject.touchY * currentStage.stageHeight;
			var id:Number = touchObject.touchID;
			
			if (touchObject.isNativeTouch)
			{
				tox = touchObject.touchX;
				toy = touchObject.touchY
			}
			
			if (debug)
			{
				var shape:DebugDisplay = new DebugDisplay(String(id));
				shape.theme(debugIsDark);
				shape.x = tox;
				shape.y = toy;
				currentStage.addChild(shape);
				
				debugDict[id] = shape;
			}
			
			dispatchEvent(new TouchManagerEvent(TouchManagerEvent.DOWN, new TouchObject(id, tox, toy)));
		}
		
		private function touchMoveHandler(event:TouchManagerEvent):void
		{
			var touchObject:TouchObject = event.touchObject;
			var tox:Number = touchObject.touchX * currentStage.stageWidth;
			var toy:Number = touchObject.touchY * currentStage.stageHeight;
			var id:Number = touchObject.touchID;
			
			if (touchObject.isNativeTouch)
			{
				tox = touchObject.touchX;
				toy = touchObject.touchY
			}
			
			if (debug)
			{
				if (debugDict[id] != null)
				{
					debugDict[id].x = tox;
					debugDict[id].y = toy;
				}
			}
			
			dispatchEvent(new TouchManagerEvent(TouchManagerEvent.MOVE, new TouchObject(id, tox, toy)));
		}
		
		private function touchUpHandler(event:TouchManagerEvent):void
		{
			var touchObject:TouchObject = event.touchObject;
			var tox:Number = touchObject.touchX * currentStage.stageWidth;
			var toy:Number = touchObject.touchY * currentStage.stageHeight;
			var id:Number = touchObject.touchID;
			
			if (touchObject.isNativeTouch)
			{
				tox = touchObject.touchX;
				toy = touchObject.touchY
			}
			
			if (debug)
			{
				if (debugDict[id] != null)
				{
					currentStage.removeChild(debugDict[id]);
					delete debugDict[id];
				}
			}
			
			dispatchEvent(new TouchManagerEvent(TouchManagerEvent.UP, new TouchObject(id, tox, toy)));
		}
	}
}