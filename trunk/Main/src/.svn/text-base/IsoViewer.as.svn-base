package  
{
	import com.utilities.BitMapper;
	import com.utilities.Effect_Floater;
	import com.utilities.EmbedSecure;
	import com.utilities.Scoring_Floater;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import masputih.isometric.Tile;
	import masputih.isometric.World;
	import masputih.isometric.pathfinding.AStarEvent;
	import masputih.isometric.pathfinding.GridView;

	
	/**
	 * ...
	 * @author ian
	 */
	public class IsoViewer extends Sprite
	{
		public var world:World;
		public var main:Main;
		public var won:Boolean = false;
		public var timearray:Array;  // timers for farmer entry
		public var gv:GridView;
		private var _art:EmbedSecure
		private var _avatar:Avatar
		private var _messaging:Array = new Array();
		private var _messages:Class;
		private var _scorePoint:Point
		public var orderScore:Number;
		public var orderTime:Number;
		public var angerTime:Number;
		public var destTime:Number;
		public var orderXp:Number;
		public var rentScore:Number;
		public var rentXp:Number;
		private var _xpPoint:Point
		private var _floatingScoreArt:Array = new Array
		private var _numberArt:Class
	
		private var _stationsAr:Array = new Array()
		private var _storeLoc:Point;
		private var _currentFarmer:Farmer;
		private var _currentPlayer:Avatar;
		private var _players:Array = new Array();
		public var characterTypesAr:Array = new Array();
		public var playerTypeChoice:String;
		private var _characterPositionAr:Array = new Array();
		public var _characterAr:Array = new Array();
		private var _charactersInGame:uint = 0;
		private var _serviceTable:ServiceTable
		private var _trash:TrashUnit
		private var _innovationAr:Array=new Array()
		private var _plotbasedOrdersAr:Array = new Array();
		private var _messagingSprite:MovieClip
		private var _scoreVal:Number = 0;
		private var _xpVal:Number = 0;
		private var _movementAr:Array=new Array;
		
		private var playerSet:Boolean = false;
		private var c:int = 0;
		private var _counter:int =0;
		private var charPosIndex:int = 0;
		private var characterCount:int = 0;
		private var posAr:Array;

		
		public function IsoViewer( mainref:Main, art:EmbedSecure = null) 
		{
			
			trace("new IsoViewer" + this);
			characterTypesAr = [playerTypeChoice, "farmer_male", "farmer_male", "farmer_male", "farmer_male", "farmer_male"];
			this.main = mainref;
			
			_characterPositionAr=[[10,21],[24,22],[24,19],[24,16],[24,13],[24,10]];

			destTime = Main.currentSetting.event_delays[AllSettings.EVENT_ON_LEAVE_HAPPY];
			
			angerTime = Main.currentSetting.event_delays[AllSettings.EVENT_MAKE_ANGRY];
			orderTime = Main.currentSetting.event_delays[AllSettings.EVENT_ORDERTAKEN];

			world = new World(750, 550, 24, 27, 27,false,false);
			
			addChild(world);
			
			_stationsAr = [[8, 4], [16, 5], [3, 12], [16, 14], [16, 23]];
			
			
			//****add ground plots****
			for (var x:Number = 0; x < 5; x++) {
				var pltOrder:Innovation = new Innovation(world.grid,60,art);
				_plotbasedOrdersAr.push(pltOrder)
				_stationsAr[x].plotOrderObj = pltOrder
				
			}
			
			for (var d:Number = 0; d < 5; d++) {
				var tempFarmplot:FarmPlot = new FarmPlot(world.grid,art,_stationsAr[d][0],_stationsAr[d][1],d);
				tempFarmplot.plot.addEventListener(AllSettings.EVENT_CALL_VISITOR, callVisitor);
				tempFarmplot.plot.addEventListener(AllSettings.EVENT_CALL_PLAYER, callPlayer);
				tempFarmplot.plotOrderObj=_plotbasedOrdersAr[d]
				_stationsAr.push(tempFarmplot);
				tempFarmplot.moveToCell(_stationsAr[d][0], _stationsAr[d][1]);
				_plotbasedOrdersAr[d].moveToCell(_stationsAr[d][0]-1, _stationsAr[d][1]-1);
				world.addGroundObject(tempFarmplot);
				//world.addTile(tempFarmplot,_stationsAr[d][0], _stationAr[d][1]);
				world.addGroundObject(_plotbasedOrdersAr[d]);
				//
				var tempHut:Hut= new Hut(world.grid,60,art);
				//_stationsAr.push(tempFarm)
				tempHut.moveToCell(_stationsAr[d][0]-2,_stationsAr[d][1]-2)
				
				world.addGroundObject(tempHut);
				tempFarmplot.hut = tempHut
				
				world.set_walkable(_stationsAr[d][0]-3,_stationsAr[d][1]-2, false);
				world.set_walkable(_stationsAr[d][0]-2,_stationsAr[d][1]-3, false);
				world.set_walkable(_stationsAr[d][0]-3,_stationsAr[d][1]-3, false);
				
				
				var crops:Crops_Ground = new Crops_Ground(world.grid,art);
				// _stationsAr.push(crops);
				crops.moveToCell(_stationsAr[d][0], _stationsAr[d][1]);
				world.addGroundObject(crops);
				tempFarmplot.crops = crops
			}			
			
			
		
			
			_serviceTable = new ServiceTable(world.grid, 80, art,6,20);
			_serviceTable.plot.addEventListener(AllSettings.EVENT_CALL_PLAYER,callPlayerToOrderTable);
			_serviceTable.moveToCell(6,20);
			world.addGroundObject(_serviceTable);
			//
			_trash = new TrashUnit(world.grid, 80, art,19,23);
			_trash.plot.addEventListener(TrashUnit.EVENT_CALL_PLAYER,callPlayerToTrash);
			_trash.moveToCell(19,23);
			world.addGroundObject(_trash);
			
			var bitmapper:BitMapper=new BitMapper()
			var bitMapper2:BitMapper = new BitMapper();
			_messaging = bitMapper2.buildDataObject("messaging", 1, 3, new messaging());
			_floatingScoreArt = bitmapper.buildDataObject("floating score", 1, 11, new numbas());
			for (var a:Number = 0; a < 4; a++) {
				var trees:Trees = new Trees(world.grid,2);
				_stationsAr.push(crops);  // what is crops here? 
				trees.moveToCell(_stationsAr[a][0]+6, _stationsAr[a][1]-4);
				world.addGroundObject(trees);
			}
			//initialize inventory if not done so already
			if(!Main.inventory){
				Main.initInventory();
			}
			
			resetGame()
		}
		
		
		private function floatScore(amt:Number, targ:MovieClip):void {
			//this is totally hacked. I created my own version of Scoring_Floater called ScoreFloater just to make it easy to add to 
			// the relevant Farmer and hopefully get some logical placement of the floaty. 
			trace("FLOATSCORE:  "+amt + " "+targ);
			_scoreVal=amt;
			var scoreFloat:ScoreFloater;
			
			if (!won)
				dispatchEvent(new Event(AllSettings.EVENT_SCORE, true));
			
			trace("target Farmer: " + targ);
			scoreFloat = new ScoreFloater ( String(_scoreVal) , _floatingScoreArt, new Point(0 ,0));				
			targ.addChild(scoreFloat);
				
		
		}
		
		
		
		
		private function onLeaveHappy(event:Event):void {
			trace(event.target.avatar + " is leaving happy");
			characterCount--;
			addFarmer();
		}
		
		private function addFarmer():void
		{
			if (characterCount == 1)
			{
				if (_counter == _characterAr.length && !won)
				{
					dispatchEvent(new Event(AllSettings.EVENT_OVER, true));
				}
				charPosIndex = 1;
				
				while ( characterCount < 6 && _counter < _characterAr.length && !won )
				{
					var del:Timer = new Timer(1, characterCount);//this.timearray[_characterAr.length()-1]*1000);
					// to decide arbitrarily.  Put some values in an array, then use values to init timers.
					del.addEventListener(TimerEvent.TIMER_COMPLETE, remoteWalkCharacter);
					del.start();
					characterCount++;
					_counter++;
				}	
			}	
		}
		
		private function onLeaveAngry(event:Event):void {
			_messagingSprite=event.target as MovieClip;
			
			characterCount--;
			addFarmer();
		}
		
		private function updateGv(e:AStarEvent):void 
		{
			//used with small astar grid to see the path
			gv.showPath(e.path);
		}
		public function get scorePoz():Point {
			return _scorePoint
		}
		public function get xpPoz():Point {
			return _xpPoint
		}
		
		private function callVisitor(event:Event):void {
			//trace("calling visitor..");
			if(_currentFarmer && !event.target.myParent.visitorState)
			{
				storeLoc(event);
				if (_currentFarmer && _currentFarmer.state == "notActive") 
				{
					_currentFarmer.removeHot();
					_currentFarmer.state = "inTransit";
					var tempPlot:FarmPlot = event.target.myParent as FarmPlot;
					_currentFarmer.plot = tempPlot ;
					tempPlot.currentVisitor = _currentFarmer;
					// how to make villager happy again after being angry
					
					_currentFarmer.killAngerOnArrival();
					
					
					_currentFarmer.walkToCell(this.x, this.y, event.target.cellLocation.x, event.target.cellLocation.y - 2) 
					event.target.myParent.visitorState = true;
				} 
			}
		}
		
		
		private function callPlayer(event:Event):void {
			
			storeLoc(event);
			event.target.myParent.addStroke();
			var moveObj:Object = new Object();
			moveObj = { x:event.target.cellLocation.x, y:event.target.cellLocation.y,plot:event.target.myParent as FarmPlot,atTable:false,atTrash:false}
			if(_movementAr.length<4){
				_movementAr.push(moveObj);
			}
			checkAndPlaySequence(event);
		}
		
		// this actually managing the queue of destinations for the player
		private function checkAndPlaySequence(event:Event):void {
			
			if (_movementAr.length > 0 && _characterAr[0].activelyMoving==false) {
				_characterAr[0].activelyMoving = true
				var curMov:Object = _movementAr.shift();
				_characterAr[0].itemToGet=curMov.itemToGet
				_characterAr[0].plot = curMov.plot
				_characterAr[0].atTable = curMov.atTable
				_characterAr[0].atTrash=curMov.atTrash
				_characterAr[0].walkToCell(this.x, this.y,  curMov.x+ 4,  curMov.y- 1)}
		}
		
		private function callPlayerToOrderTable(event:Event):void {
			
			var moveObj:Object = new Object();
			if(!_characterAr[0].plot){
				return;
			}
			if(!_characterAr[0].plot.currentVisitor){ 
				//farmer left so too late.
				return;
			} 
			moveObj = { x:event.target.cellLocation.x, y:event.target.cellLocation.y,plot:_characterAr[0].plot.currentVisitor.plot,atTable:true,atTrash:false,itemToGet:_serviceTable.currentItemToGet as MovieClip}
			if(_movementAr.length<4){
				_movementAr.push(moveObj)}
			checkAndPlaySequence(event)
			
		}
		
		private function callPlayerToTrash(event:Event):void {		
			if(_characterAr[0] != null &&_characterAr[0].plot)
			{
				var tempPlot:FarmPlot;
				if (_characterAr[0].plot.currentVisitor != null)
					tempPlot= _characterAr[0].plot.currentVisitor.plot;
				else 
					tempPlot = null;
				var moveObj:Object = new Object();
				//XXXXXTODO
				moveObj = { x:event.target.cellLocation.x, y:event.target.cellLocation.y,plot:tempPlot,atTable:false,atTrash:true, itemToGet:null}
				if(_movementAr.length<5){
					_movementAr.push(moveObj)}
				checkAndPlaySequence(event)
			}
		}	
		
		
		//removes items that player is carrying  _characterAr[0] is the player avatar at the momment. 
		private function atTrash(event:Event):void
		{
			while (_characterAr[0].itemGot.numChildren > 0)
			{
				_characterAr[0].itemGot.removeChildAt(0);
			}	
		}
		
		
		private function atTable(event:Event):void {
			trace("atTable: "+event);
			//_serviceTable.enabler = true;
			
			_characterAr[0].atTable = true;
			//trace("_characterAr[0] at table: " + _characterAr[0]);
			if (_characterAr[0].itemGot.numChildren < 2 && _characterAr[0].state!= "inTransit") {
				Main.soundSet["collectItem"].play();
				var tableClip:MovieClip = _characterAr[0].itemToGet
				var bit:BitmapData = new BitmapData(70, 70, true, 0x000000);
				bit.draw(tableClip);
				var tempClip:MovieClip = new MovieClip();
				tempClip.name = String(_characterAr[0].itemToGet.currentFrame);
				tempClip.doppleganger = _characterAr[0].itemToGet;
				_characterAr[0].plot.currentVisitor.itemOnTable = _characterAr[0].itemToGet;
				tempClip.addChild(new Bitmap(bit));
				var bitM:Bitmap = new Bitmap(bit);
				bitM.smoothing = true;
				_characterAr[0].itemOnTable = tableClip;
				if (_characterAr[0].itemGot.numChildren < 1) {
					tempClip.x=80	
				}else {
					tempClip.x=40		
				}
				_characterAr[0].itemGot.addChild(tempClip);
				_characterAr[0].itemGot.alpha = 1;
				_characterAr[0].itemGot.visible = true;
				
				//////////////////////////
				tableClip.visible = false;
				trace("tableClip.x: "+ tableClip.x)
				_serviceTable.free_innovation(tableClip.x);
				
				_serviceTable.get_next_innovation();
			}
		}
		private function storeLoc(event:Event):void {
			trace("setting storeLoc...",mouseX, mouseY);
			_storeLoc = new Point(mouseX, mouseY);
		}
		private function currentfarmerSelector(event:Event):void {
			_currentFarmer = event.target.avatar ;
		}
		//--***************************--//
		//----farmer creation area-----// 
		public function setupCharacters():void 
		{
			var tm:Timer = new Timer(1000, Main.currentSetting.num_villagers+1);  // every 2 seconds a new char is created.
			tm.addEventListener(TimerEvent.TIMER, addCharacter);  // call addCharacter
			tm.addEventListener(TimerEvent.TIMER_COMPLETE, onCharacterCreationComplete);
			tm.start();
		}
		
		private function addCharacter(event:Event):void {
			var c:uint = 0;
			trace("addCharacter"+ (c++) +": "+event);
			var tempCharacter:Character;
			//set player 
			if (!playerSet)
			{
				// setup things for player character
				playerSet = true;
				tempCharacter = new Avatar(world.grid, main.avatarChoiceType, _art, world);
				tempCharacter.newContainer.addEventListener(AllSettings.EVENT_AT_TABLE, atTable);
				tempCharacter.newContainer.addEventListener(AllSettings.EVENT_AT_TRASH, atTrash);
				tempCharacter.newContainer.addEventListener(AllSettings.EVENT_ORDER_COMPLETED, completedOrder);

				tempCharacter.newContainer.addEventListener(AllSettings.EVENT_CHECK_MOVEMENT_SEQUENCER, checkAndPlaySequence);

			} else {
				//crappy organization here.  This is establishing everything for farmers.
				tempCharacter = new Farmer(world.grid, characterTypesAr[c], _art, world);
				tempCharacter.newContainer.addEventListener(AllSettings.EVENT_INPOSITION, farmerArrived);
				tempCharacter.newContainer.addEventListener(AllSettings.EVENT_ON_PLOT_START, onPlot);
				tempCharacter.newContainer.addEventListener(AllSettings.EVENT_ON_LEAVE_HAPPY, onLeaveHappy);
				tempCharacter.newContainer.addEventListener(AllSettings.EVENT_ON_LEAVE_ANGRY, onLeaveAngry);
				tempCharacter.newContainer.addEventListener(AllSettings.EVENT_PLACEORDER, farmerPlaceOrder);
				tempCharacter.newContainer.addEventListener(AllSettings.EVENT_RETRACTORDER, farmerRetractOrder);
				tempCharacter.newContainer.addEventListener(AllSettings.EVENT_CURRENTFARMER, currentfarmerSelector);
				tempCharacter.newContainer.addEventListener(AllSettings.EVENT_ORDERTAKEN, orderTaken);

			}
			c++;
			
			// do these need to be added to Farmer or Player
			tempCharacter.moveToCell(23, 5);
			world.addGroundObject(tempCharacter);
			_characterAr.push(tempCharacter);  // all characters pushed into array. make array up in start of class
			//use _characterAr.length to get index for timearray.
			if( characterCount <6 )
			{
				var del:Timer = new Timer(1, _characterAr.length);//this.timearray[_characterAr.length()-1]*1000);
				// to decide arbitrarily.  Put some values in an array, then use values to init timers.
				del.addEventListener(TimerEvent.TIMER_COMPLETE, remoteWalkCharacter);
				del.start();
				characterCount++;
				_counter++;
			}
		}
		
		private function farmerArrived(event:VillageEvent):void{
			event.farmer.farmerArrived(event);	
			//tutorial check

			
		}
		
		private function onPlot(event:Event):void {
			trace("onPlot: " + event.target);
			rentScore = Main.currentSetting.cashhash[AllSettings.EVENT_ON_PLOT_START];
			floatScore(rentScore, event.target as MovieClip);
		}
		
		
		private function onCharacterCreationComplete(event:Event):void {
			var count:uint = 0;
			trace("onCharacterCreationComplete"+ ++count);
			event.target.removeEventListener(TimerEvent.TIMER, addCharacter);
			event.target.removeEventListener(TimerEvent.TIMER_COMPLETE, onCharacterCreationComplete);
			//trace("charactercreation");
		}
		
		private function remoteWalkCharacter(event:Event):void 
		{
			var startPoint:Point = new Point( _characterPositionAr[charPosIndex][0], _characterPositionAr[charPosIndex][1]);
			_characterAr[_charactersInGame].gameStartPosition = startPoint;
			_characterAr[_charactersInGame].walkToCell(this.x, this.y,startPoint.x,startPoint.y);
			_charactersInGame++;
			charPosIndex++;
			dispatchEvent(new Event(AllSettings.EVENT_ARRIVED, true));
			
		}
		
		//WHy is this called farmer place order when it's the farmer placing the order? 
		// How is this func randomly picking an innovaiton to order?
		private function farmerPlaceOrder(event:Event):void {
			trace("farmerPlaceOrder event: "+event);
			_messagingSprite = event.target as MovieClip;
			//floatMessage("placeOrder");
			if(_characterAr[0].state != "inTransit"){
				//_serviceTable.enabler=true
			}			
		}
		
		
		
		private function farmerRetractOrder(event:Event):void {
			trace("farmerRetractOrder: " + event);
			if (_currentFarmer == event.target.avatar) {
				_currentFarmer = null;
			}
			_serviceTable.removeOneOfaType(Number(event.target.avatar.currentInnovation));
		}
		private function orderTaken(event:Event):void 
		{
			trace("orderTaken: "+ event);
			//trace("orderTaken...");
			Main.soundSet["take_order"].play()
			_serviceTable.enabler=true
			_serviceTable.showAndGetOrder(Main.inventory[event.target.avatar.currentInnovation]);
			//event.target.avatar.satisfied();

			
		}
		private function completedOrder(event:VillageEvent):void {
			trace("orderComplete: " +event);
			//_serviceTable.enabler = true;
			//currentfarmer is not reliable
			orderScore = Main.currentSetting.cashhash[AllSettings.EVENT_ORDER_COMPLETED];
			floatScore(orderScore, event["farmer"].newContainer);
			//update farmer state.
		 	event["farmer"].orderComplete(event);
		}
		
		public function resetGame():void {
			for (var D:Number = 0; D < _plotbasedOrdersAr.length; D++) {
				_plotbasedOrdersAr[D].mySprite.visible = false;
			}
		}
		
		public function set AvatarSkin(str:String):void {
			trace("set avatarskin: "+str);
			if (_avatar) { _avatar.setSkin(str) } else {
				playerTypeChoice = str;
				characterTypesAr[0] = str;
			}
			
		}
		public function get scoreVal():Number {
			return _scoreVal
		}
	
	}
	
}