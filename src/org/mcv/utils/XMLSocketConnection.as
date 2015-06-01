package org.mcv.utils
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.XMLSocket;
	import flash.events.Event;
	import flash.events.DataEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.utils.Dictionary;
	import org.mcv.events.TouchManagerEvent;
	import org.mcv.objects.CursorObject;
	import org.mcv.objects.OSC2DObject;
	import org.mcv.objects.TouchObject;
	import flash.system.Security;
	
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	public class XMLSocketConnection
	{
		private static var socket:XMLSocket;
		private static var cursorDict:Dictionary = new Dictionary();
		private static var aliveDict:Dictionary = new Dictionary();
		private static var _movementThresholdSq:int = 0.0;
		
		public static function connect():void
		{
			var to:TouchObject = new TouchObject();
			to.event = "XML CONNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN";
			//dispatch.dispatchEvent(new TouchManagerEvent(TouchManagerEvent.DOWN, to));
			
			socket = new XMLSocket();
			
			socket.addEventListener(Event.CLOSE, closeHandler, false, 0, true);
			socket.addEventListener(Event.CONNECT, connectHandler, false, 0, true);
			socket.addEventListener(DataEvent.DATA, dataHandler, false, 0, true);
			socket.addEventListener(IOErrorEvent.IO_ERROR, errorHandler, false, 0, true);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityHandler, false, 0, true);
			
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			//Security.loadPolicyFile("xmlsocket://127.0.0.1:3000");
			
			socket.connect("127.0.0.1", 3000);
		}
		
		private static function closeHandler(event:Event):void
		{
			log(event);
		}
		
		private static function connectHandler(event:Event):void
		{
			log(event);
		}
		
		private static function dataHandler(event:DataEvent):void
		{
			//log(event);
			try
			{
				var inXML:XML = new XML(String(event.data));
				if (inXML.localName() == "OSCPACKET")
					parseXml(inXML);
			}
			catch (e:Error)
			{
			}
		
		}
		
		private static function errorHandler(event:IOErrorEvent):void
		{
			log(event);
		}
		
		private static function securityHandler(event:SecurityErrorEvent):void
		{
			log(event);
		}
		
		private static function log(event:Event):void
		{
			trace(event);
			var to:TouchObject = new TouchObject();
			to.event = String(event);
			//dispatch.dispatchEvent(new TouchManagerEvent(TouchManagerEvent.DOWN, to));
		}
		
		/**
		 * Parse the messages from some XMLDocument-encoded OSC packet.
		 *
		 * @private
		 * @param node
		 */
		
		/*<OSCPACKET ADDRESS="127.0.0.1" PORT="3333" TIME="169.4179993">
		   <MESSAGE NAME="/tuio/2Dcur">
		   <ARGUMENT TYPE="s" VALUE="set"/>
		   <ARGUMENT TYPE="i" VALUE="91"/>
		   <ARGUMENT TYPE="f" VALUE="0.4981610"/>
		   <ARGUMENT TYPE="f" VALUE="0.5249294"/>
		   <ARGUMENT TYPE="f" VALUE="0.0711975"/>
		   <ARGUMENT TYPE="f" VALUE="-0.0491333"/>
		   <ARGUMENT TYPE="f" VALUE="0.0027905"/>
		   </MESSAGE>
		   <MESSAGE NAME="/tuio/2Dcur">
		   <ARGUMENT TYPE="s" VALUE="alive"/>
		   <ARGUMENT TYPE="i" VALUE="91"/>
		   </MESSAGE>
		   <MESSAGE NAME="/tuio/2Dcur">
		   <ARGUMENT TYPE="s" VALUE="fseq"/>
		   <ARGUMENT TYPE="i" VALUE="2168"/>
		   </MESSAGE>
		 </OSCPACKET>*/
		
		private static var osc2dObjectArray:Array = ["x", "y", "xSpeed", "ySpeed", "acceleration"];
		
		private static function parseXml(node:XML):void
		{
			var msgList:XMLList = node.MESSAGE;
			
			for (var i:int = 0; i < msgList.length(); i++)
			{
				var osc2DObject:OSC2DObject = new OSC2DObject();
				var paramsList:XMLList = msgList[i].ARGUMENT;
				var fCount:int = 0;
				
				for (var listIndex:int = 0; listIndex < paramsList.length(); listIndex++)
				{
					var type:String = String(paramsList[listIndex].@TYPE);
					var value:String = String(paramsList[listIndex].@VALUE);
					
					if (type == "f")
					{
						osc2DObject[String(osc2dObjectArray[fCount])] = Number(value);
						
						fCount++;
					}
					else if (type == "s")
					{
						osc2DObject.string = String(value);
					}
					else if (type == "i")
					{
						osc2DObject.touchID = int(value);
						osc2DObject.touchIDarray.push(int(value));
					}
				}
				
				read(osc2DObject);
			}
		}
		
		public static function read(osc2DObject:OSC2DObject):void
		{
			switch (osc2DObject.string)
			{
				case "fseq":
					
					break;
				
				case "set":
					
					var i:uint = 1;
					
					var s:Number = osc2DObject.touchID;
					var touchID:String = s.toString();
					
					var x:Number = osc2DObject.x;
					var y:Number = osc2DObject.y;
					
					var X:Number = osc2DObject.xSpeed;
					var Y:Number = osc2DObject.ySpeed;
					
					var m:Number = osc2DObject.acceleration;
					var cursor:CursorObject;
					
					if (!cursorDict[touchID])
					{
						cursor = cursorDict[touchID] = new CursorObject(s, x, y, X, Y, m);
						
						aliveDict[touchID] = true;
						
						dispatch.dispatchEvent(new TouchManagerEvent(TouchManagerEvent.DOWN, new TouchObject(s, cursor.x, cursor.y)));
					}
					else
					{
						cursor = cursorDict[touchID];
						var updated:Boolean = false;
						var delta:Number = cursor.x - x;
						if (delta * delta >= _movementThresholdSq)
						{
							updated = true;
						}
						else
						{
							delta = cursor.y - y;
							if (delta * delta >= _movementThresholdSq)
							{
								updated = true;
							}
						}
						
						if (updated)
						{
							cursor.update(x, y, X, Y, m);
							
							dispatch.dispatchEvent(new TouchManagerEvent(TouchManagerEvent.MOVE, new TouchObject(cursor.touchID, cursor.x, cursor.y)));
						}
					}
					
					break;
				
				case "alive":
					
					for (var id:String in aliveDict)
					{
						aliveDict[id] = false;
					}
					
					for (var q:int = 0; q < osc2DObject.touchIDarray.length; q++)
					{
						aliveDict[osc2DObject.touchIDarray[q]] = true;
					}
					
					for (var key:String in aliveDict)
					{
						if (aliveDict[key] == false)
						{
							dispatch.dispatchEvent(new TouchManagerEvent(TouchManagerEvent.UP, new TouchObject(cursorDict[key].touchID, cursorDict[key].x, cursorDict[key].y)));
							
							delete aliveDict[key];
							delete cursorDict[key];
						}
					}
					
					break;
			}
		}
		
		public static var dispatch:EventDispatcher = new EventDispatcher();
	
	}

}