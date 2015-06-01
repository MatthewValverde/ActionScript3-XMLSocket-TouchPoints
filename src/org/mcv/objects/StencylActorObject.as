package org.mcv.objects
{
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	import org.gesturescript.tools.CenterOfObject;
	import org.gesturescript.tools.AverageDistanceOfPoints;
	import org.gesturescript.tools.CenterToPointAngleDeg;
	import org.gesturescript.tools.CenterToPointAngleRad;
	import org.gesturescript.tools.DistanceCenterToPoint;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	public class StencylActorObject extends Object
	{
		public var d:Dictionary = new Dictionary();
		public var actor:DisplayObject;
		
		public var isTouchDown:Boolean;
		public var isTouchRelease:Boolean;
		public var touchPointCount:int;
		public var tapCount:int;
		private var tapUint:uint;
		private var tapIsOn:Boolean;
		private var milisecondsIn:Number = 0;
		private var amountDown:int;
		//public var lastTouchPointID:String;
		public var longPressPointCount:int;
		private var longPressMilisecondsIn:Number = 0;
		
		public var padFromCenter:Point;
		public var orgCoord:Point;
		public var localOrg:Point;
		public var px:Number = 0;
		public var py:Number = 0;
		public var dx:Number = 0;
		public var dy:Number = 0;
		public var ds:Number = 0;
		public var dsx:Number = 0;
		public var dsy:Number = 0;
		public var dr:Number = 0;
		public var point:Dictionary;
		public var centerOfPoints:Point;
		public var localCenter:Point;
		public var orgCenter:Point;
		public var averageDistance:Number = 0;
		public var initialScale:Number = 0;
		public var target:*;
		
		public function StencylActorObject(displayObject:DisplayObject)
		{
			actor = displayObject;
			target = actor;
			point = new Dictionary();
		}
		
		public function addGesture(value:String, func:Function = null):void
		{
			if (func != null)
			{
				d[value] = func;
			}
			else
			{
				d[value] = value;
			}
		}
		
		public function removeGesture(value:String):void
		{
			delete d[value];
		}
		
		public function hasGesture(value:String):Boolean
		{
			if (d[value] != null)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		public function setPoint(tpo:TouchPointObject):void
		{
			touchPointCount++;
			point[tpo.id] = tpo;
			//lastTouchPointID = String(tpo.id);
			calculateDistanceOfPoints();
		}
		
		public function removePoint(tpo:TouchPointObject):void
		{
			touchPointCount--;
			delete point[tpo.id];
			//lastTouchPointID = String(tpo.id);
			calculateDistanceOfPoints();
		}
		
		public function fireGestureFunction(value:String):void
		{
			d[value]();
		}
		
		public function addTap():int
		{
			var now:Number = new Date().getTime();
			
			if (isNaN(milisecondsIn))
			{
				tapCount++;
				milisecondsIn = now;
				amountDown = 1;
				return amountDown;
			}
			
			if (now > (milisecondsIn + 400))
			{
				clearTapCount();
			}
			
			if (now < (milisecondsIn + 50))
			{
				amountDown++;
			}
			else
			{
				tapCount++;
				amountDown = 1;
			}
			
			milisecondsIn = now;
			
			return amountDown;
		}
		
		public function clearTapCount():void
		{
			tapCount = 0;
			amountDown = 0;
			milisecondsIn = NaN;
		}
		
		public function get addLongPress():int
		{
			var nowLong:Number = new Date().getTime();
			
			if (nowLong > (longPressMilisecondsIn + 100))
			{
				clearLongPress();
			}
			
			longPressPointCount++;
			
			longPressMilisecondsIn = nowLong;
			
			return longPressPointCount;
		}
		
		public function clearLongPress():void
		{
			longPressPointCount = 0;
		}
		
		private var _scaleHistory:Array = new Array();
		
		public function get scaleHistory():Array
		{
			return _scaleHistory;
		}
		
		public function set scaleHistory(value:*):void
		{
			_scaleHistory.unshift(value);
			
			ds = scaleHistory[1] ? scaleHistory[0].x - scaleHistory[1].x : 0;
			dsx = scaleHistory[1] ? scaleHistory[0].x - scaleHistory[1].x : 0;
			dsy = scaleHistory[1] ? scaleHistory[0].y - scaleHistory[1].y : 0;
		}
		
		private var _pointHistory:Array = new Array();
		
		public function get pointHistory():Array
		{
			return _pointHistory;
		}
		
		public function set pointHistory(value:*):void
		{
			_pointHistory.unshift(value);
			
			dx = pointHistory[1] ? pointHistory[0].x - pointHistory[1].x : 0;
			dy = pointHistory[1] ? pointHistory[0].y - pointHistory[1].y : 0;
		}
		
		public function setLocation():void
		{
			centerOfPoints = CenterOfObject.measure(point);
			pointHistory = centerOfPoints;
		}
		
		public function calculateDistanceOfPoints():void
		{
			centerOfPoints = CenterOfObject.measure(point);
			
			localOrg = target.globalToLocal(centerOfPoints);
			
			orgCoord = new Point(target.x, target.y);
			
			localCenter = target.parent.globalToLocal(centerOfPoints);
			
			orgCenter = centerOfPoints;
			
			averageDistance = AverageDistanceOfPoints.measure(centerOfPoints, point);
			
			initialScale = target.scaleX;
			
			_pointHistory = [];
			//_scaleHistory = [];
			//_rotateHistory = [];
			
			pointHistory = centerOfPoints;
			scaleHistory = new Point(target.scaleX, target.scaleY);
			//rotateHistory = (GestureScript.packageName == "flash") ? (this.target.rotation / (180 / Math.PI)) : this.target.rotation;
			padFromCenter = new Point((localCenter.x - orgCoord.x), (localCenter.y - orgCoord.y));
			
			var c:int;
			
			for each (var tpo:TouchPointObject in point)
			{
				var gesturePoint:Point = new Point(tpo.stageX, tpo.stageY);
				tpo.downScale = initialScale;
				tpo.distanceFromCenter = DistanceCenterToPoint.measure(centerOfPoints, gesturePoint);
				tpo.degreeAngle = CenterToPointAngleDeg.measure(centerOfPoints, gesturePoint);
				tpo.radianAngle = CenterToPointAngleRad.measure(centerOfPoints, gesturePoint);
				tpo.rotationDifference = (target.rotation / (180 / Math.PI)) - tpo.radianAngle;
				c++;
			}
		}
	
	}

}