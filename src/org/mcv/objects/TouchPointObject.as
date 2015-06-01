package org.mcv.objects
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	public class TouchPointObject extends Object
	{
		public var actor:DisplayObject;
		public var actorX:Number = 0;
		public var actorY:Number = 0;
		public var pointDownX:Number = 0;
		public var pointDownY:Number = 0;
		public var pointDownXDiff:Number = 0;
		public var pointDownYDiff:Number = 0;
		public var outXDelta:Number = 0;
		public var outYDelta:Number = 0;
		public var timeDelta:Number = 0;
		public var milisecondsIn:Number = 0;
		public var milisecondsOut:Number = 0;
		public var canBeLongPress:Boolean;
		public var id:int;
		
		public var dx:Number = 0;
		public var dy:Number = 0;
		public var stageX:Number = 0;
		public var stageY:Number = 0;
		public var localX:Number = 0;
		public var localY:Number = 0;
		public var localPoint:Point;
		public var downScale:Number = 0;
		
		public var distanceFromCenter:Number = 0;
		public var degreeAngle:Number = 0;
		public var radianAngle:Number = 0;
		public var rotationDifference:Number = 0;
		
		public function TouchPointObject(displayObject:DisplayObject, x:Number, y:Number, idValue:int = 0)
		{
			actor = displayObject;
			
			id = idValue;
			
			actorX = actor.x - (actor.width / 2);
			actorY = actor.y - (actor.height / 2);
			
			pointDownX = x;
			pointDownY = y;
			
			pointDownXDiff = pointDownX - actorX;
			pointDownYDiff = pointDownY - actorY;
			
			milisecondsIn = new Date().getTime();
			
			canBeLongPress = true;
			
			stageX = pointDownX;
			stageY = pointDownY;
			localPoint = actor.globalToLocal(new Point(stageX, stageY));
			localX = localPoint.x;
			localY = localPoint.y;
			downScale = actor.scaleX;
		}
		
		public function setLocation(x:Number, y:Number):void
		{
			stageX = x;
			stageY = y;
			
			pointHistory = new Point(stageX, stageY);
		}
		
		public function delta(x:Number, y:Number):Point
		{
			outXDelta = (x > pointDownX) ? (x - pointDownX) : (pointDownX - x);
			outYDelta = (y > pointDownY) ? (y - pointDownY) : (pointDownY - y);
			
			return new Point(outXDelta, outYDelta);
		}
		
		public function get time():Number
		{
			milisecondsOut = new Date().getTime();
			
			return milisecondsOut - milisecondsIn;
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
	}
}