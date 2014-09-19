package com.utilities
{
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events. *;
	import flash.utils.Timer;
	public class Effect_Floater
	{
		public var Bitz : Bitmap = new Bitmap ()
		public var capsule : Sprite = new Sprite ()
		private var maxFrame : Number = 0
		private var seqAr : Array = new Array ()
		private var _externalArt : Object
		private var storedLength : Number = 0
		
		private var _accel : Number = 0
		private var _frm : Number = 0
		private var _myTm : Timer
		private var _Animation : Boolean = false
		private var _speed : Number = 0
		public function Effect_Floater ( externalArtObject : Object, parent : Sprite, loc : Object, specificFrm : String = "undefined", speed : Number =.3,scale:Number=1) : void
		{
			_frm = Number (specificFrm)
			_speed = speed
			if (specificFrm == "undefined")
			{
				_frm = 0
			}else
			{
				_Animation = true
			}
			
			_externalArt = externalArtObject
			//trace(_externalArt)
			prepareFrames (_externalArt)
			
			parent.addChild (capsule)
			
			Bitz.y = loc.y
			Bitz.x = loc.x
			
			Bitz.bitmapData = seqAr [_frm]
			//trace(seqAr [_frm])
			capsule.addChild (Bitz)
			capsule.mouseEnabled=false
			capsule.mouseChildren = false
			Bitz.scaleX = scale
			Bitz.scaleY = scale
			if (scale > 1) {
			Bitz.x -= scale * 30
			Bitz.y-=scale*30
			}
			//_game.activeCharacterslist.push (this)
			_myTm = new Timer (20)
			_myTm.addEventListener (TimerEvent.TIMER, float)
			//capsule.cacheAsBitmap=true
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
				_myTm.removeEventListener (TimerEvent.TIMER, float)
			}
			if(capsule.parent){
			capsule.parent.removeChild (capsule)}
		}
		private function float (event : Event) : void
		{
			if ( ! _Animation)
			{
				_frm ++
				if (_frm > seqAr.length)
				{
					_frm = 0
				}
			}
			
			Bitz.bitmapData = _externalArt [_frm]
			_accel += _speed
			capsule.y -= (_accel*2)
			capsule.x = 5 * Math.sin ((_accel * 9) /2)
			if (capsule.alpha > 0)
			{
				//capsule.alpha -= (_accel / 200)
			}
			if (capsule.y < - 400)
			{
				
				kill ()
			}
		}
	}
}
