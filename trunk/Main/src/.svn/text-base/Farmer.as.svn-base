//yoyo

package
{
	
	import as3isolib.display.scene.IsoGrid;
	import as3isolib.geom.IsoMath;
	import as3isolib.geom.Pt;
	
	import com.greensock.TweenLite;
	import com.utilities.EmbedSecure;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.trace.Trace;
	import flash.utils.Timer;
	
	import masputih.isometric.*;
	
	
	public class Farmer extends Character
	{	
		// what's the best way to implement a finite state machine? 
		// turning states into constants. 

		private static var settings:Level;
		public var angertime:Number;  //time that farmer waits until becoming angry
		public var ordertime:Number;  // time that farmer waits until orderin
		public var leavetime:Number;  // time that farmer waits until leaving after getting angry. 
		public var happytime:Number;  // time farmer leaves after receiving all needs. trigger on orderComplete
		private var shk:Timer;
		private var destinationTimer:Timer;
		private var angerTimer:Timer;
		private var orderTimer: Timer;
		private var hutTimer:Timer;
		private var orderCompleted:Boolean = false;
		
		public function Farmer(iso:IsoGrid, typ:String="farmer_male", artz:EmbedSecure=null, world:World=null)
		{
			super(iso,typ,artz,world);
			settings = Main.currentSetting;
			angertime = settings.event_delays[AllSettings.EVENT_MAKE_ANGRY];
			ordertime = settings.event_delays[AllSettings.EVENT_PLACEORDER];
			happytime = settings.event_delays[AllSettings.EVENT_ON_LEAVE_HAPPY];
			
			_myOrder = art.orderPopup;
			_myOrder.alpha = 0;
			//_myOrder.addEventListener(Event.ENTER_FRAME, drv);
			this.newContainer.buttonMode = true;
			this.newContainer.mouseChildren = false;
			this.newContainer.buttonMode = true;
			this.newContainer.addEventListener(MouseEvent.MOUSE_OVER, addStroke);
			this.newContainer.addEventListener(MouseEvent.MOUSE_OUT, removeStroke);
			this.newContainer.addEventListener(MouseEvent.MOUSE_DOWN, makeHot);
			reset();
			
			this.newContainer.avatar = this;
			this.newContainer.orderNumber = undefined;
			leaveState = "happy";
			state = "waitingForPlot";
			
			
		}
		
		override public function onAnimationStart():void
		{
			if (_myPlot!=null) 
			{
				_myPlot.strokeState = true;
				_myPlot.addStroke();
			}
		}
		
		public override function onAnimationComplete():void {
			trace("Farmer.onAnimationComplete...");
			// erik 
			if (_myPlot!=null) {
				_myPlot.strokeState = false;
				_myPlot.removeStroke();
			}
			
			dirInc=0
			sprites[0].gotoAndStop("stand")
			
			if (_myPlot!=null && _state != "notActive" && _state != "inTransit") 
			{
				_myPlot.visitorState=true
				enabled = false
			}
			enabled=true;
			// looks like inposition doesn't refer to a specific state but the completion of movement. 
			this.container.dispatchEvent(new VillageEvent(AllSettings.EVENT_INPOSITION, true, false, this)) ;
			//farmer should happy about arriving
		}
		//could be arrived in town or arrived on plot the wqy the function is designed. 
		public function farmerArrived(event: VillageEvent):void{
			timeAtDestination();
		}
		
		// what does this function do?
		
		public function timeAtDestination() : void 
		{
			//WE don't actually us ordertime, angertime or num now. This is set in AllSettings now.
			trace("timeAtDestination: "+happytime +" ordertime:"+ordertime+" angertime:"+angertime);
			
			if (state == "inTransit") 
			{ 	
				enabled = false
				plot.visitorState=true
				killAngerTimer();
				//Farmers Timers
				Main.soundSet["tribal_beat"].play()
				orderTimer = new Timer(ordertime * 1000, 1);
				
				// ERIK  add delay for hut
				hutTimer = new Timer(4000, 1);
				hutTimer.addEventListener(TimerEvent.TIMER_COMPLETE, showHut);
				hutTimer.start();
				//TweenLite.to(plot.hut.container,.3,{alpha:1})
				
				art.dispatchEvent(new Event(AllSettings.EVENT_ON_PLOT_START, true))
				orderTimer.addEventListener(TimerEvent.TIMER_COMPLETE,placeOrder);
				orderTimer.start()
			}	
				
			else if (state =="waitingForPlot") {
				state = "notActive";
				satisfied();
			}
			
			if (state == "left Game") 
			{
				walkToCell(this.x, this.y, _startPosition.x, _startPosition.y);
				state = "notActive";

			}
		}
		
		
		
		
		public function resetAngerTimers():void{
			if(angerTimer) angerTimer.stop();
			if(destinationTimer) destinationTimer.stop();
			angerTimer = new Timer(angertime * 1000, 1);
			destinationTimer = new Timer(happytime * 1000, 1);
			angerTimer.addEventListener(TimerEvent.TIMER_COMPLETE, makeAngry);
			destinationTimer.addEventListener(TimerEvent.TIMER_COMPLETE, leaveGame);
			angerTimer.start() ;
			destinationTimer.start();
		}
		
		public function killAngerTimer():void
		{
			if(angerTimer){
				angerTimer.stop();
				angerTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, makeAngry);
			}
			angerTimer = null;
			
		}
		public function killDestinationTimer():void{
			if(destinationTimer){
				destinationTimer.stop();
				destinationTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, leaveGame);
			}
		}
		public function killOrderTimer():void{
			if(orderTimer){
				orderTimer.stop();
				orderTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, placeOrder);
			}
		}
		
		public  function leaveGame(event:Event):void 
		{
			enabled = false;
			if (plot) {
				plot.reset()}
			
			if (_leaveState == "happy") {
				art.dispatchEvent(new Event(AllSettings.EVENT_ON_LEAVE_HAPPY, true)) 
				
			} else if (_leaveState == "angry") {
				art.dispatchEvent(new Event(AllSettings.EVENT_ON_LEAVE_ANGRY, true)) 
				
			}
			this.newContainer.dispatchEvent(new Event(AllSettings.EVENT_RETRACTORDER, true))
			reset()
			state = "";
			TweenLite.to(_myOrder, .5, { alpha:0 } );
			//removeStroke();
			var del:Timer = new Timer(3000, 1)
			// need to de hardcode this and use time from on leave angry and leave happy
			del.addEventListener(TimerEvent.TIMER_COMPLETE, delayedLeaveForCoinDrop);
			del.start();
		}
		
		// what does this function do?
		public function delayedLeaveForCoinDrop(event:Event):void 
		{
			walkToCell(this.x, this.y, 22, 0);
		}
		
		
		public function showHut(event:Event):void
		{
			TweenLite.to(plot.hut.container,.3,{alpha:1});
		}
		
		public function placeOrder(event:Event):void {
			Main.soundSet["complete"].play()
			art.dispatchEvent(new Event(AllSettings.EVENT_PLACEORDER, true))
			TweenLite.to(_myOrder, .5, { alpha:1 } )
			_myPlot.orderState = true
			_orderStage=1
			killOrderTimer();
			satisfied();  // this resets angertimers from beginning of order placement.
		}
		
		public function reset():void 
		{
			if (plot) {
				plot.crops.plot..alpha=0
				plot.crops.plot.gotoAndStop(1)
			}
			this.newContainer.dispatchEvent(new Event(AllSettings.EVENT_RETRACTORDER, true))
			// _currentInnovation is now the index of the array so needs to be zero thru length -1
			
			_currentInnovation = Math.round(Math.random() * (Main.inventory.length-1));
			trace("popup gonna be"+ Main.inventory[_currentInnovation] + " currentInnovation:"+ _currentInnovation);
			art.orderPopup.gotoAndStop(Main.inventory[_currentInnovation] as Number);
			itemOnTable = null;
			orderStage = 0;
			orderPresentOnTable = false;
			enabled = true;
			_myPlot = null;
			leaveState = "happy";
			state = "left Game";;
			plotCompleted = false;
			killAngerTimer();
			killOrderTimer();
			killDestinationTimer();
		}
		
		public	function makeAngry(event:Event):void {
			trace("Farmer.makeAngry: "+ event.target);
			if(orderCompleted){ return;}
			sprites[0].gotoAndStop("angry")
			shk = new Timer(30, 80);
			shk.addEventListener(TimerEvent.TIMER, shake);
			shk.addEventListener(TimerEvent.TIMER_COMPLETE, killShake);
			shk.start();
			_leaveState = "angry";
		}
		
		public function shake(event:Event):void 
		{
			art.y=_spriteOriginY-Math.round(Math.random()*5)
		}
		
		public function killShake(event:Event):void 
		{
			shk.stop();
			event.target.removeEventListener(TimerEvent.TIMER, shake)
			event.target.removeEventListener(TimerEvent.TIMER_COMPLETE, killShake)
			art.y=_spriteOriginY
				
		}	
		
		//this might not be right need to find effective way to kill/stop these timers so they won't trigger errantly
		
		public  function killAngerOnArrival():void 
		{
			satisfied();
		}
		
	
		
		
		
		public function satisfied():void
		{
			trace("statisfied " + this);
			sprites[0].gotoAndStop("stand");
			if(angerTimer){
				angerTimer.stop();
				leaveState = "happy";
			}
			resetAngerTimers();
		}
		
		
		public function makeHappy():void
		{
			sprites[0].gotoAndStop("stand");
			if(angerTimer){
				angerTimer.stop();
				leaveState = "happy";
			}
		
		}
		
		public function orderTaken():void 
		{
			trace("Farmer.orderTaken " + this);
			if (_myPlot) 
			{
				if (!orderPresentOnTable) 
				{
					this.newContainer.dispatchEvent(new Event(AllSettings.EVENT_ORDERTAKEN, true))
					orderPresentOnTable = true
					TweenLite.to(_myOrder, .5, { alpha:.5 })
					//also make happy
					satisfied();
				}
				
			}
		}
		
		public  function  orderComplete(event:Event):void{
			trace("orderComplete " +this);
			orderCompleted = true;
			makeHappy();
			killAngerTimer();
			killOrderTimer();
			killShake(event);
			destinationTimer = new Timer(happytime* 1000, 1);
			destinationTimer.addEventListener(TimerEvent.TIMER_COMPLETE, leaveGame);
			destinationTimer.start();
		}
		
		public function waterCrops():void 
		{
			plot.crops.plot.gotoAndPlay(2);
		}		
		
	}
}	