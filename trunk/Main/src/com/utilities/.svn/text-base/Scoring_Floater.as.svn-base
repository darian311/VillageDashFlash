package com.utilities
{
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events. *;
	import flash.utils.Timer;
	public class Scoring_Floater extends Sprite
	{
		public var Bitz : Bitmap = new Bitmap ()
		public var capsule : Sprite = new Sprite ()
		private var maxFrame : Number = 0
		private var seqAr : Array = new Array ()
		private var _externalArt : Array
		private var storedLength : Number = 0
		
		private var _accel : Number = 0
		private var _myTm : Timer
		private var _loc:Object
		public function Scoring_Floater ( incomingNum : String,externalArt :Array, parent : Sprite,loc:Object) : void
		{
			//trace("scoring floater triggering",loc.x,loc.y)
			_externalArt = externalArt
			prepareFrames (externalArt)
			capsule.scaleX = .6
			capsule.scaleY = .6
			parent.addChild (capsule)
			_loc=loc
			//capsule.graphics.beginFill(0xffffff)
			//capsule.graphics.drawRect(0, 0, 50, 50)
			//capsule.graphics.endFill()
			
			//var bttest:Bitmap = new Bitmap(externalArt[0])
			//bttest.x+=bttest.width
			//capsule.addChild(bttest)
			
			if (incomingNum.substr (0,1) == "-")
			{
				var tempBit : Bitmap = new Bitmap (_externalArt [10])
				capsule.addChild (tempBit)
				var tempNum : Number = 1
			}else
			{
				tempNum = 0
			}
			for (var cnt : Number = tempNum; cnt < incomingNum.length; cnt ++)
			{
				//seqAr [Number (incomingNum.substr (cnt, 1))]
				tempBit = new Bitmap (_externalArt[Number (incomingNum.substr (cnt, 1))])
				tempBit.x += cnt * 20
				capsule.addChild (tempBit)
				capsule.x -= (tempBit.width/3)
				storedLength = cnt
				//trace("BITTZ" + Number (incomingNum.substr (cnt, 1)))
				
			}
			tempBit = new Bitmap (seqAr [13])
			tempBit.x += (incomingNum.length) * 20
			capsule.addChild (tempBit)
			capsule.y = _loc.y
			capsule.x=_loc.x
			capsule.mouseEnabled=false
			capsule.mouseChildren=false
			//capsule.cacheAsBitmap=true
			_myTm = new Timer (20)
			_myTm.addEventListener (TimerEvent.TIMER, float)
			_myTm.start ()
		}
		public function prepareFrames (dataWrap : Object) : void
		{
			for (var bit : String in dataWrap)
			{
				maxFrame ++
				seqAr.push (dataWrap ["bit" + maxFrame])
			}
			//Bitz.x=-(dataWrap["bit"+1].width/2)
			//Bitz.y=-(dataWrap["bit"+1].height/2)
			//capsule.addChild(Bitz)
			Bitz.smoothing = false
		}
		public function kill () : void
		{
			if (_myTm)
			{
				_myTm.stop ()
			}
			if (capsule.parent) {
			//capsule.parent.parent.removeChild(capsule.parent)	
			capsule.parent.removeChild (capsule)}
		}
		private function float (event : Event) : void
		{
			//trace("floating")
			
			
			_accel +=.1
			capsule.y -= (_accel)
			capsule.x += 5 * Math.sin ((_accel * 6) / 5)
			if (capsule.alpha > 0)
			{
				//capsule.alpha -= (_accel / 200)
			}
			if (capsule.y < - 400)
			{
				//trace(capsule.y)
				kill ()
			}
			
			
		}
	}
}
