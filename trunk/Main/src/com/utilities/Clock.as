package com.utilities
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events. *;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Ian Stokes www.unit2design.com 2010
	 */
	public class Clock extends Sprite
	{
		public var Bitz : Bitmap = new Bitmap ();
		public var capsule : Sprite = new Sprite ();
		private var maxFrame : Number = 0;
		private var seqAr : Array = new Array ();
		private var _externalArt : Object;
		private var storedLength : Number = 0;
		private var _accel : Number = 0;
		private var _myTm : Timer;
		private var _numzArray : Array = new Array ();
		private var _targetScore : Number = 0;
		private var _minutes : Number = 0;
		private var _seconds : Number = 0;
		private var _milliseconds : Number = 0;
		private var _tm : Timer;
		private var secondsKill : Boolean = false;
		private var _flashCounter : Boolean = false;
		private var _ten : Number = 0;
		public static const LEVELEND_EVENT:String = "level end";
		public function Clock ( incomingTime : String, externalArt : Object, parent : Sprite, loc : Object) : void
		{
		    _ten = 0;
			this.name = "clock";
			_externalArt = externalArt;
			prepareFrames (externalArt);
			parent.addChild (capsule);
			for (var cnt : Number = 0; cnt < incomingTime.length; cnt ++)
			{
				if (String (incomingTime.substr (cnt, 1)) == ":")
				{
					var tempBit : Bitmap = new Bitmap (_externalArt [11])
				}else
				{
					tempBit = new Bitmap (_externalArt [10]);
				}
				tempBit.x += cnt * ((tempBit.width / 2) + 5);
				_numzArray.push (tempBit);
				capsule.addChild (tempBit);
				capsule.x = loc.x;
				capsule.y = loc.y;
				storedLength = cnt;
			}
			_tm = new Timer (10);
			_tm.addEventListener (TimerEvent.TIMER, counter);
			trace("clock setup");
		}
		public function startClock (str : String) : void
		{
			_milliseconds = Number (str.substr (str.length - 2, 2));
			_seconds = Number (str.substr (str.length - 5, 2));
			_minutes = Number (str.substr (0, 2));
			if (_minutes < 1)
			{
				secondsKill = true;
			}else
			{
				secondsKill = false;
			}
			_tm.start ();
		}
		public function condimentBoost():void{
			_seconds += ((Math.random() * 4) + 1);
		}
		public function dockTime():void {
			if(_seconds>5){
			_seconds-=5}	
		}
		public function reset(event:Event=null):void{
			_tm.stop ();
			_tm.reset();
			_milliseconds = 0;
			_seconds = 0;
			_minutes = 0	
			counter (event);
		}
		public function stopClock () : void
		{
			_tm.stop ();
			//dispatchEvent(new Event(LEVELEND_EVENT, true));
		}
		
		public function get tm () : Timer
		{
			return _tm
		}
		public function pause (bol : Boolean) : void
		{
			if (bol)
			{
				_tm.stop ();
			}else
			{
				_tm.start ();
			}
		}
		public function resetClock (str : String) : void
		{
			_tm.stop ();
			///
			_tm.start ();
		}
		private function test () : void
		{
		}
		public function counter (event :Event=null) : void
		{
			_milliseconds -= 1;
			if (_milliseconds > 0)
			{
			}else
			{
				_seconds -= 1;
				if(_seconds<6){
				//Main.frameSounds["tick"].play()
				}
				_ten += 1;
				if (_ten > 9)
				{
					flashIt ();
					_ten = 0;
				}
				_milliseconds = 59;
			}
			if (_milliseconds < 10)
			{
				var millTemp : String = "0" + _milliseconds
			}else
			{
				millTemp = String (_milliseconds)
			}
			/////
			if (_seconds > 0)
			{
			}else
			{
				_minutes -= 1
				if ( ! secondsKill)
				{
					_seconds = 59;
				}
			}
			if (_seconds < 10)
			{
				var secTemp : String = "0" + _seconds;
			}else
			{
				secTemp = String (_seconds);
			}
			if (_minutes > 0)
			{
			}else
			{
				secondsKill = true;
				_minutes = 0;
			}
			if (_minutes < 10)
			{
				var minTemp : String = "0" + _minutes;
			}else
			{
				minTemp = String (_minutes)
			}
			if (_minutes < 1 && _seconds < 1)
			{
				stopClock ();
				_minutes = 0;
				minTemp = String (_minutes);
				_seconds = 0;
				secTemp = String (_seconds);
				_milliseconds = 0;
				millTemp = String (_milliseconds);
				
			}
			_numzArray [0].bitmapData = _externalArt [Number (minTemp.substr (0, 1))];
			_numzArray [1].bitmapData = _externalArt [Number (minTemp.substr (1, 1))];
			_numzArray [3].bitmapData = _externalArt [Number (secTemp.substr (0, 1))];
			_numzArray [4].bitmapData = _externalArt [Number (secTemp.substr (1, 1))];
			//_numzArray [6].bitmapData = _externalArt [Number (millTemp.substr (0, 1))];
			//_numzArray [7].bitmapData = _externalArt [Number (millTemp.substr (1, 1))];
		}
		public function prepareFrames (dataWrap : Object) : void
		{
			for (var bit : String in dataWrap)
			{
				maxFrame ++;
				seqAr.push (dataWrap ["bit" + maxFrame]);
			}
			Bitz.smoothing = false;
		}
		public function kill () : void
		{
			if (_myTm)
			{
				_myTm.stop ();
			}
			capsule.parent.removeChild (capsule);
		}
		public function get minutes():Number {
			return _minutes;
		}
		public function get seconds():Number {
			return _seconds;
		}
		private function flasher (event : Event) : void
		{
			if ( ! _flashCounter)
			{
				//ColorBox.tint (capsule, 0xFF0000, 150)
				_flashCounter = true
			}else
			{
				//ColorBox.colorReset (capsule)
				_flashCounter = false
			}
		}
		private function flashIt () : void
		{
			//_game.SFX ("clockflash")
			var flashz : Timer = new Timer (20, 6)
			flashz.addEventListener (TimerEvent.TIMER, flasher)
			flashz.start ()
		}
		public function displayTime(str:String):void {
			_tm.stop ();
		    _tm.reset();
			_milliseconds = Number (str.substr (str.length - 2, 2));
			_seconds = Number (str.substr (str.length - 5, 2));
			_minutes = Number (str.substr (0, 2));
			if (_minutes < 1)
			{
				secondsKill = true;
			}else
			{
				secondsKill = false;
			}
			//_tm.start ()
			 counter ();
		}
		public function start():void {
			_tm.start ();
		}
	}
}
