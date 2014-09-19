package com.utilities
{
	//import com.Game;
	
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Ian Stokes www.unit2design.com 2010
	 */
	public class Scoring_counter extends Sprite
	{
		public var Bitz : Bitmap = new Bitmap ()
		public var capsule : Sprite = new Sprite ()
		private var maxFrame : Number = 0
		private var seqAr : Array = new Array ()
		private var _externalArt :Array
		private var storedLength : Number = 0
		private var _intervalHit:Number = 1000
		private var _intervalHit2:Number = 2000
		private var _intervalHit3:Number=3000
		private var _accel : Number = 0
		private var _myTm : Timer
		private var _currentCnt : Number = 0
		private var _numzArray : Array = new Array ()
		private var _targetScore : Number = 0
		private var _mode:String
		private var _sndDel:Timer
		private var _sndName:String
		private var _sndName2:String
		private var _sndUsed:String
		private var _goodsoundTimer:Timer = new Timer(110)
		private var _badsoundTimer:Timer=new Timer(100)
		private var _beepSoundChannel:SoundChannel = new SoundChannel()
		private var _maxPointsSoundC:SoundChannel = new SoundChannel()
		private var _maxPointsSoundD:SoundChannel = new SoundChannel()
		private var _maxPointsSoundE:SoundChannel = new SoundChannel()
		private var _active:Boolean=false
		public static const SCORECOUNTFINISHED_EVENT:String = "score count finished"
		public static const OUTOFPOINT_EVENT:String = "out of points"
		
		public function Scoring_counter (incomingNum : String, externalArt :Array, parent : Sprite) : void
		{
			_goodsoundTimer.addEventListener(TimerEvent.TIMER,snd)
			_badsoundTimer.addEventListener(TimerEvent.TIMER,sndBad)
			//_game.addEventListener("reset", reset);
			_externalArt = externalArt
			prepareFrames (externalArt)
			parent.addChild (capsule)
			for (var cnt : Number = 0; cnt < incomingNum.length; cnt ++)
			{
				var tempBit : Bitmap = new Bitmap (_externalArt [10])
				tempBit.x += cnt * ((tempBit.width / 2)+6 )
				_numzArray.push (tempBit)
				capsule.addChild (tempBit)
				capsule.x =0
				capsule.y = 0
				storedLength = cnt
			}
			capsule.addChild (tempBit)
			
		}
		public function hush():void {
			trace("HUSH")
		_beepSoundChannel.stop()	
		}
		private function reset(event:Event):void{
			trace("*******counter reset**********")
		_myTm.stop()
	   
		for(var D:Number=0;D<capsule.numChildren;D++){
		Bitmap(capsule.getChildAt(D)).bitmapData=_externalArt [10]}
		_targetScore=0
		_currentCnt=0
		_myTm.start()
		}
		public function get currentScore():Number {
			return _targetScore
		
		}
		public function driveHome(num:Number):void {
		if(!_active){
		_targetScore += num
		_currentCnt = _targetScore
		_goodsoundTimer.stop()
		_badsoundTimer.stop()
		var temTm:Timer = new Timer (20,num)
			temTm.addEventListener (TimerEvent.TIMER, counter)
		    temTm.start()
		
			dispatchEvent(new Event(SCORECOUNTFINISHED_EVENT,true))
		}
		}
		public function rst():void{
		
		for(var D:Number=0;D<capsule.numChildren;D++){
		Bitmap(capsule.getChildAt(D)).bitmapData=_externalArt [10]}
		_targetScore=0
		_currentCnt=0
		_intervalHit= 1000
		_intervalHit2= 2000
		_intervalHit3 = 3000
		_goodsoundTimer.stop()
		_badsoundTimer.stop()
		}
		
		public function setCounter(score:Number):void{
		
		for(var D:Number=0;D<capsule.numChildren;D++){
		Bitmap(capsule.getChildAt(D)).bitmapData=_externalArt [10]}
		_targetScore=score
		_currentCnt=score
		_intervalHit= 1000
		_intervalHit2= 2000
		_intervalHit3 = 3000
		_goodsoundTimer.stop()
		_badsoundTimer.stop()
		}
		
		public function updatePoints (num :Number,mode:String="gameplay") : void
		{
			_active=true
			_goodsoundTimer.start()
			_mode=mode
			var temTm:Timer = new Timer (20,num)
			temTm.addEventListener (TimerEvent.TIMER, counter)
			temTm.start()
		
			_targetScore = num
		
			
		}
		
		public function addPoints (num :Number,mode:String="gameplay") : void
		{
			_active=true
			_goodsoundTimer.start()
			_mode=mode
			if(num>10){
			}
			var temTm:Timer = new Timer (20,num)
			temTm.addEventListener (TimerEvent.TIMER, counter)
		    temTm.start()
			if(num>0){
			if (_currentCnt >= 0) { _targetScore += num }}
			if (num < 0) {
			if (_currentCnt >= 0) { _targetScore +=num }}	
			
		}
		public function removePointz (num :Number) : void
		{
			_active=true
			_badsoundTimer.start()
			var temTm:Timer = new Timer (20,num)
			temTm.addEventListener (TimerEvent.TIMER, counter)
		    temTm.start()
			
			if (_targetScore >= 0) { _targetScore -= num } else {
				
			
				temTm.stop()}
			if (_targetScore == 0) {
			dispatchEvent(new Event(OUTOFPOINT_EVENT,true))	
			}
			
		}
		public function removePoints (num : Number) : void
		{
		removePointz(num)
		}
		public function addPointsAdj (num : Number,speed:Number) : void
		{
			_active=true
			_goodsoundTimer.start()
			if(_targetScore>=0){_targetScore += num}
		}
		private function snd(event:Event):void{
			if (_currentCnt != (_targetScore)) {
			_beepSoundChannel.stop()
			//Main.blip.play()
			
			//_beepSoundChannel=Main.soundSet["blip"].play()
			
			}
		
			
		}
		private function sndBad(event:Event):void{
			if (_currentCnt != (_targetScore)) {
			_beepSoundChannel.stop()	
			//_beepSoundChannel=Main.soundDictionary["badblip"].play()
			
			}
		
			
		}
		public function counter (event : Event=null) : void
		{
		//Main.soundDictionary["special4"].play() 
			 if (_intervalHit < _currentCnt) {
				  _maxPointsSoundD.stop()
				  _maxPointsSoundC.stop()
				  _maxPointsSoundE.stop()
				 // if(_mode=="gameplay"){
				  //_maxPointsSoundC=Main.soundDictionary["maxpoints"].play()}
				 _intervalHit+=1000
			 }
			 if (_intervalHit2 < _currentCnt) {
				 _maxPointsSoundD.stop()
				  _maxPointsSoundC.stop()
				  _maxPointsSoundE.stop()
				  // if(_mode=="gameplay"){
				  // _maxPointsSoundD=Main.soundDictionary["midpoints"].play()}
				 _intervalHit2+=2000
			 }
			 if (_intervalHit3 < _currentCnt) {
				  _maxPointsSoundD.stop()
				  _maxPointsSoundC.stop()
				  _maxPointsSoundE.stop()
				   //if(_mode=="gameplay"){
				  // _maxPointsSoundD=Main.soundDictionary["bigpoints"].play()}
				 _intervalHit3+=3000
			 }
		if (_currentCnt > _targetScore) { _currentCnt -= 1 }
		if (_currentCnt < _targetScore) {
			if (_currentCnt + 5000 < _targetScore) {
			_currentCnt += 2000 	
			}
			if (_currentCnt + 1500 < _targetScore) {
			_currentCnt += 1000 	
			}
			if (_currentCnt + 100 < _targetScore) {
			_currentCnt += 50 	
			}else {
			_currentCnt += 1 	
			}
			
			
			
			
			
			}
		if (_currentCnt == _targetScore) {
			_active=false
			_goodsoundTimer.stop()
			_badsoundTimer.stop()
			event.target.removeEventListener (TimerEvent.TIMER, counter)
			dispatchEvent(new Event(SCORECOUNTFINISHED_EVENT,true))
			event.target.stop()}
		
		
		var CharCount : Number = String (_currentCnt).length
		for (var S:Number = 0; S < _numzArray.length;S++){
			_numzArray [S].bitmapData=_externalArt [10]}
		for (var D : Number = 0; D < CharCount; D ++)
		{
			
			if (_targetScore) {
			if (_currentCnt < 10) {
			_numzArray [D + 1].bitmapData = _externalArt [String (_currentCnt).substr (D, 1)]
			_numzArray[D].bitmapData = _externalArt [0] 	
			}else{	
			_numzArray [D].bitmapData = _externalArt [String (_currentCnt).substr (D, 1)]} } else {
		    _numzArray [D + 1].bitmapData = _externalArt [String (_currentCnt).substr (D, 1)]
			
			}
			
		}
		if (_currentCnt < 1) {
			event.target.stop()
			rst()}
		}
		public function prepareFrames (dataWrap : Object) : void
		{
			for (var bit : String in dataWrap)
			{
				maxFrame ++
				seqAr.push (dataWrap ["bit" + maxFrame])
			}
			
			Bitz.smoothing = false
		}
		public function kill () : void
		{
			if (_myTm)
			{
				_myTm.stop ()
			}
			capsule.parent.removeChild (capsule)
		}
		
}
}