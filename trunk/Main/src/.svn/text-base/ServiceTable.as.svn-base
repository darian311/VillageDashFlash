package 
{
	import as3isolib.display.scene.IsoGrid;
	
	import com.utilities.EmbedSecure;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import masputih.isometric.Box;
	/**
	 * ...
	 * @author ian
	 */
	public class ServiceTable extends Box{
		
		
		private var _art:EmbedSecure;
		private var _artSprite:MovieClip;
		private var _innovationAr:Array = new Array();
		private var _innovationDic:Dictionary = new Dictionary();
		private var _curNum:Number = 0
		public var plot:MovieClip = new MovieClip()
		public var cellLocation:Object = new Object()
		private var _currentItemToGet:MovieClip
		private var _currentSearchNum:Number=0
		public var myName:String = "table"
		private var _cellX:Number
		private var _cellY:Number;
		private var _itemToDelay:innovations;
		private var _timerInAction:Boolean = false;
		private var _itemDelayArray:Array = new Array();
		private var _itemsUsed:Dictionary = new Dictionary();
		private var _itemsOnDisplay:Array = new Array();
		private var _visible_items:int = 0;
		private var _innovation_sprite_holders:int = 20;  // why is this 20 when only two items are displayed at service table???
		private var _used_sprites:Object = new Object();
		private var _order_array:Array = new Array();
		private var _innovation_spots:Object = new Object();
		
		public function ServiceTable(iso:IsoGrid,boxHeight:Number,art:EmbedSecure,cellX:Number,cellY:Number) 
		{
			
			_cellX = cellX
			_cellY=cellY
			cellLocation = { x:cellX, y:cellY };
			_art=art
			super(iso, boxHeight)
			this.myName="table"
			fillColor = Math.random() * 0xFFFFFF;
			spans = [1, 1]
			walkable = false
			
			//erik
			//var tableArt:Class = _art.grabClass("service_table");
			
			_artSprite = new service_table()
			
			//_artSprite.y +=30
			//_artSprite.truck.gotoAndStop("UP_THERE");
			
			_artSprite.mouseEnabled=false
			sprites = [_artSprite]
			//_artSprite.buttonMode = true;
			//_artSprite.useHandCursor=true
			//_artSprite.addEventListener(MouseEvent.MOUSE_OVER, addStroke)
			//_artSprite.addEventListener(MouseEvent.MOUSE_OUT, removeStroke)
			setupInnovationSpriteHolders()
			plot.myParent=this
		}
		
		private function setupInnovationSpriteHolders():void {
			for (var D:Number = 0; D < _innovation_sprite_holders; D++) {
				var E:int;
				var tempItem:MovieClip = _artSprite["in_" + ((D%5)+1)]
				tempItem.buttonMode = true
				tempItem.useHandCursor = true
				//tempItem.user=false
				tempItem.visible = false
				tempItem.addEventListener(MouseEvent.MOUSE_OVER, addStroke)
				tempItem.addEventListener(MouseEvent.MOUSE_OUT, removeStroke)
				tempItem.addEventListener(MouseEvent.MOUSE_DOWN, clicked);
				_innovationAr.push(tempItem)
				_innovationDic[D] = new Object();
				_innovationDic[D].pos = D + 1; 
				_innovationDic[D].id = "in_" + (D + 1) ;
				_innovationDic[D].sprite = tempItem;
				var spot_object:Object;
				if ( D == 2)
				{
					spot_object = {x: tempItem.x, y: tempItem.y, mc: tempItem, used: "no" }
					_innovation_spots["a"] = spot_object;
				}
				if ( D == 4 )
				{
					spot_object = {x: tempItem.x, y: tempItem.y, mc: tempItem, used: "no" }
					_innovation_spots["b"] = spot_object;
				}
			}
		}
		
		// Displays ordererd innovaiton at service table once it's produced.
		// There's 2 spots to track for vacancy called a and b. 
		// what does this fucntion if both spots filled?
		private function place_innovation(mc:MovieClip):void
		{
			if ( _innovation_spots["a"].used == "no" )
			{
				mc.x = _innovation_spots["a"].x;
				mc.y = _innovation_spots["a"].y;
				_innovation_spots["a"].used = "yes";
			}
			else
			{
				mc.x = _innovation_spots["b"].x;
				mc.y = _innovation_spots["b"].y;
				_innovation_spots["b"].used = "yes";
			}
		}
		
		
		public function free_innovation(x_pos:Number):void
		{
			trace("ServiceTable free_innovation spot a: "+_innovation_spots["a"].x );
			if ( _innovation_spots["a"].x == x_pos )
			{
				trace("Free a");
				_innovation_spots["a"].used = "no";
			}
			else if ( _innovation_spots["b"].x == x_pos )
			{
				trace("free b");
				_innovation_spots["b"].used = "no";
			}
		}
		public function showAndGetOrder(innovation_key_frame:Number):void {
			trace("showAndGetOrder: "+innovation_key_frame );
			for (var D:Number = 0; D < _innovation_sprite_holders; D++) {
				if (_used_sprites[D] != true && _itemsUsed[_innovationAr[D]] != true) {
					//_innovationAr[D].visible = true;
					//delayVisibility(_innovationAr[D]);
					var innovationToShow:innovations = _innovationAr[D];
					_innovationAr[D].cellAdjuster = D%5
					_innovationAr[D].mouseEnabled=true
					_curNum = D
					_currentItemToGet = _innovationAr[D]
					_used_sprites[D] = true;
					//_itemsUsed[_innovationAr[D]] = true;
					//trace("showing an item" + D)
					break;
				}
			}
			
			var order_object:Object = {id: _curNum, key_frame: innovation_key_frame, mc: innovationToShow };
			
			_order_array.push(order_object);
			
			if( _timerInAction == true )
			{
				_itemDelayArray.push(innovationToShow);
			}
			else
			{
				delayVisibility(innovationToShow);
			}
		}
		private function delayVisibility(item:innovations = null):void
		{
			//_itemToDelay = item;
			
			
			
			//trace("delayVisibility with item: " + item.name);
			if( _timerInAction == false && _visible_items < 2 )
			{
				_timerInAction = true;
				
				var order_object:Object = _order_array.shift();
				_itemToDelay = order_object.mc;
				
				_itemToDelay.gotoAndStop(order_object.key_frame);
				place_innovation(_itemToDelay);
				var delay:Timer = new Timer(2000, 1);
				delay.addEventListener(TimerEvent.TIMER_COMPLETE, displayItem);
				delay.start();
			}
			else
			{
				//itemDelayArray.push(_itemToDelay);
				//trace("pushing item: " + _itemToDelay);
			}
		}
		
		private function displayItem(event:Event = null):void
		{
			if( event != null )
			{
				// drive truck
				if(_artSprite.truck.currentLabel == "UP_THERE" )
				{
					//drive_truck_down();	
				}
				if( _visible_items < 2 ) 
				{
					// set item visible
					_visible_items++;
					( _itemToDelay as MovieClip ).visible = true;
				}
				_timerInAction = false;
			}	
			// make sure items on hold get faded in
			if( _order_array.length > 0 && _visible_items < 2 ) 
			{
				delayVisibility();
			}
			if( _order_array.length == 0 && _visible_items == 0 ) 
			{
				//drive_truck_up();	
			}
		}
		private function isVis(element:MovieClip, index:int, array:Array):Boolean {
			if(element.currentFrame==_currentSearchNum){element.visible=false}
			return (element.currentFrame==_currentSearchNum)
		}
		public function get_next_innovation():void
		{
			//trace("get_next_innovation()..." + _itemDelayArray.length + " "  + _visible_items);
			_visible_items--;
			displayItem();
		}
		
		public function drive_truck_up():void
		{
			_artSprite.truck.gotoAndPlay("UP");	
		}
		
		public function drive_truck_down():void
		{
			_artSprite.truck.gotoAndPlay("DOWN");	
		}
		
		public function removeOneOfaType(num:Number):void {
			_currentSearchNum=num
			// trace("FIRED"+_innovationAr.some(isVis))
			
			//your code here
			for (var D:Number = 0; D < 5; D++) {
				if (_innovationAr[D].currentFrame == num && _innovationAr[D].visible==true) {
					_innovationAr[D].visible = false
					for (var Z:Number = 0; Z < 100; Z++) {
						_innovationAr[D].visible=false}
					break}
			}
			
		}
		
		public function get curNumber():Number {
			return _curNum
		}
		public function hideItem(num:Number):void {
			if(_innovationAr[num]){
				_innovationAr[num].visible = true}
		}
		private function addStroke(event:Event):void {
			trace("ServiceTable addstroke." + event.target)
			Main.soundSet["select3"].play()
			var filt:Array = new Array();
			var g:GlowFilter = new GlowFilter(0xFFFF00, 1, 3, 3, 100);
			filt.push(g);
			event.target.filters = filt;
		}
		private function removeStroke(event:Event):void {
			var filt:Array = new Array();
			event.target.filters = new Array()		}
		
		
		private function clicked(event:Event):void {
			trace("ServiceTable onCLick" + event.type);
			removeStroke(event)
			Main.soundSet["selectItem"].play()
			_currentItemToGet=event.currentTarget as MovieClip
			driveAvatar();
		}
		
		public function get currentItemToGet():MovieClip {
			
			return _currentItemToGet 
		}
		public function set currentItemToGet(str:MovieClip):void {
			_currentItemToGet= null
		}
		public function set enabler(bol:Boolean):void {
			_artSprite.mouseChildren=bol
		}
		
		
		private function driveAvatar():void {
			trace("ServicTable.driveAvatar ");
			Main.soundSet["selectItem"].play()
			cellLocation = { x:_cellX, y:_cellY+_currentItemToGet.cellAdjuster };
			plot.cellLocation = cellLocation;
			plot.dispatchEvent(new Event(AllSettings.EVENT_CALL_PLAYER, true));
			
		}
		
		
		public function get artSprite():MovieClip {
			return _artSprite
		}
		
	}
	
}