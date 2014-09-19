package 
{
	import as3isolib.display.scene.IsoGrid;
	
	import com.utilities.EmbedSecure;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	
	import masputih.isometric.MathUtils;
	import masputih.isometric.Tile;
	

	/**
	 * ...
	 * @author ian
	 */
	public class FarmPlot extends Tile 
	{
		private var _art:EmbedSecure
		public var plot:MovieClip = new MovieClip();
		public var cellLocation:Object=new Object()
	
		private var _visitorState:Boolean = false
		private var _playerVisitationState:Boolean = false
		private var _currentVisitor:Farmer
		private var _playerPresent:Boolean=false
		private var _orderState:Boolean = false
		private var _orderPlaced:Boolean=false
		private var _orderTaken:Boolean=false
		private var _plotOrderObj:Innovation
		private var _myHut:Hut
		private var _crops:Crops_Ground;
		private var _avatarApproaching:Boolean = false;
		private var _keepStroke:Boolean = false;
		public var myName:String="farm"
		public function FarmPlot(iso:IsoGrid,art:EmbedSecure,cellX:Number,cellY:Number,num:Number) 
		{
			myName=String("farm"+num)
			cellLocation = { x:cellX, y:cellY };
			_art = art;
			
			super(iso)
			
			fillColor = Math.random() * 0xFFFFFF;
			spans = [5, 5]
				
			
			plot= new PlotClear();	
			
			plot.x -= plot.width/2
			plot.y -= plot.height / 2
			this.container.buttonMode = true;
		    this.container.useHandCursor=true
		
			plot.myParent=this;
			sprites = [plot];
			
			//experimenting w mouseover target to see if it improves the mouseover behavior	
			this.container.addEventListener(MouseEvent.MOUSE_OVER, addStroke)
			this.container.addEventListener(MouseEvent.MOUSE_OUT, removeStroke);
			//this.plot.addEventListener(MouseEvent.MOUSE_OVER, addStroke)
			//this.plot.addEventListener(MouseEvent.MOUSE_OUT, removeStroke);
			
			
		    this.container.mouseChildren=false
			//this.container.addEventListener(MouseEvent.CLICK, clicked);
			this.container.addEventListener(MouseEvent.MOUSE_DOWN, clicked);
			
		}
		public function addStroke(event:Event = null):void {
		//	if (event) trace("add plot stroke" + event.target);
			//Main.soundSet["button_over"].play()
			var filt:Array = new Array();
			var g:GlowFilter = new GlowFilter(0xFFFF00, 1, 4, 4, 100);
			filt.push(g);
			mainContainer.filters = filt;
			
		}
		public function removeStroke(event:Event = null):void 
		{
			if( _keepStroke == false )
			{
				//trace("plot removeStroke");
				var filt:Array = new Array();
				mainContainer.filters = new Array()	
			
			}	
		}
			
		private function clicked(event:Event):void {
			Main.soundSet["plot_select"].play()
			driveAvatar();
		}
		
		private function driveAvatar():void {
			trace("driving avatar" );
			_avatarApproaching = true;
			//trace("***********DRIVE AVATAR"+_visitorState)
			plot.cellLocation =cellLocation;
			if (_visitorState == false ) 
			{
				plot.dispatchEvent(new Event(AllSettings.EVENT_CALL_VISITOR, true)) 
				trace("FarmPlot.driveAvatar just dispatched EVENT_CALL_VISITOR");

			} else {
				strokeState = true;
				addStroke();
				plot.dispatchEvent(new Event(AllSettings.EVENT_CALL_PLAYER, true))
				trace("FarmPlot.driveAvatar just dispatched EVENT_CALL_PLAYER");
			}
			
			// erik
			if(_visitorState == true)
			{
				//trace("addStroke...> ");
				addStroke();
			}
			
			
			
			//var cr:Array = MathUtils.screenToGrid(, new Point(this.x, this.y));
			//trace(ce)
		}
		
		public function get strokeState():Boolean {
			return _keepStroke;
		}
		public function set strokeState(bol:Boolean):void {
			_keepStroke=bol
		}
		public function get visitorState():Boolean {
			return _visitorState
		}
		public function set visitorState(bol:Boolean):void {
			//trace(myName+"visitor state"+bol)
			_visitorState=bol
		}
		public function get orderState():Boolean {
			return _orderState
		}
		public function set orderState(bol:Boolean):void {
			//trace("resetting orderState state"+bol)
			_orderState = bol;
		}
		public function get orderTaken():Boolean {
			return _orderTaken
		}
		public function set orderTaken(bol:Boolean):void {
			trace("resetting visitor state"+bol)
			_orderTaken = bol;
		}
		public function get playerVisitationState():Boolean {
			return _playerVisitationState;
		}
		//public function set playerVisitationState(bol:Boolean):void {
			
			//_playerVisitationState = bol;
		//}
		public function get currentVisitor():Farmer{
			return _currentVisitor;
		}
		public function set currentVisitor(av:Farmer):void {
			
			_currentVisitor = av;
		}
		public function get plotOrderObj():Innovation{
			return _plotOrderObj;
		}
		public function set plotOrderObj(inn:Innovation):void {
			
			_plotOrderObj = inn;
		}
		public function get playerPresent():Boolean{
			return _playerPresent
		}
		public function set playerPresent(bol:Boolean):void {
			
			_playerPresent=bol
		}
		public function set enabler(bol:Boolean):void {
		this.container.mouseEnabled=bol	
		}
		public function reset():void {
		
		_visitorState = false
		//trace("****resetting****"+myName+"   "+_visitorState)
		_playerVisitationState = false
		_currentVisitor = null
		_playerPresent = false
		_orderState = false
		_orderPlaced = false
		_orderTaken = false
		_myHut.container.alpha=0;
		enabler = true
		if (_plotOrderObj) {
			_plotOrderObj.mySprite.visible = false;
		}
		
		}
		public function set hut(ht:Hut):void {
			_myHut = ht
			_myHut.container.alpha=0;
		}
		public function get hut():Hut {
			return _myHut
		}
		public function set crops(cp:Crops_Ground):void {
			_crops = cp
			//_myHut.container.alpha=0
		}
		public function get crops():Crops_Ground {
			return _crops
		}
	}

}