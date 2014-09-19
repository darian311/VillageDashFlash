package masputih.isometric {

	import as3isolib.core.IsoDisplayObject;
	import as3isolib.display.IsoView;
	import as3isolib.display.scene.IsoGrid;
	import as3isolib.display.scene.IsoScene;
	import as3isolib.graphics.Stroke;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	//import nl.demonsters.debugger.MonsterDebugger;
	import masputih.isometric.*;
	import masputih.isometric.pathfinding.AStar;
	import masputih.isometric.pathfinding.AStarGrid;

	/**
	 * The isometric world.
	 * @author Anggie Bratadinata
	 */
	public class World extends IsoView {
		
		protected var _aStar:AStar;
		protected var _aStarGrid:AStarGrid;
		protected var _movableTile:MovableTile;
		
		protected var _grid:IsoGrid;
		protected var _groundScene:IsoScene;
		
		protected var _isPanning:Boolean;
		protected var _mouseDown:Boolean;
		
		protected var _panFrom:Point;
		protected var _panTo:Point;
		private var _mouseActive:Boolean = false;
		/**
		 * 
		 * @param width			The width of the world
		 * @param height		The height of the world
		 * @param cellsize		Grid cellsize
		 * @param cols			Number of columns in the grid
		 * @param rows			Number of rows in the grid
		 * @param showGrid		Toggle grid visibility
		 * @param showOrigin	Toggle 0,0,0 marker
		 */
		public function World(width:Number = 640, height:Number = 480, cellsize:int = 20, cols:int = 10, rows:int = 10,mouseActive:Boolean=false,showGrid:Boolean = true, showOrigin:Boolean = true) {
			_mouseActive=mouseActive
			setSize(width, height);

			//isometric grid
			_grid = new IsoGrid();
			_grid.includeInLayout = showGrid;
			_grid.showOrigin = showOrigin;
			_grid.stroke = new Stroke(.25, 0x808080);
			_grid.setGridSize(cols, rows);
			_grid.cellSize = cellsize;
		    
			//astar
			_aStarGrid = new AStarGrid(_grid.gridSize[0], _grid.gridSize[1])
			
			//ground scene
			_groundScene = new IsoScene();
			_groundScene.addChild(_grid);

			addScene(_groundScene);

			//pan to the center
			pan(0, cellsize * cols * .5);
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		protected function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			if(_mouseActive){
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp)
			};
			//this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			//this.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		/**********************************************
		 * MOUSE HANDLERS 
		 **********************************************/
		
		protected function onMouseUp(e:MouseEvent):void 
		{
			
			_mouseDown = false;
			
			if (_isPanning) {
				_isPanning = false;
				return;
			}
			if(_mouseActive){
			var cr:Array = MathUtils.screenToGrid(this, new Point(mouseX, mouseY));
			_movableTile.walkToCell(mouseX,mouseY,cr[0], cr[1])};
		}
		
		protected function onMouseDown(e:MouseEvent):void 
		{
			_mouseDown = true;
			
			//assume panning is initiated
			_panFrom = new Point(stage.mouseX, stage.mouseY);
		}
		
		protected function onMouseMove(e:MouseEvent):void 
		{
			if (_mouseDown) {
				
				_isPanning = true;
				
				_panTo = new Point(stage.mouseX, stage.mouseY);
				
				pan((_panFrom.x - _panTo.x)/currentZoom, (_panFrom.y -  _panTo.y)/currentZoom);
				
				_panFrom = _panTo;
				e.updateAfterEvent();
				
				
			}
		}
		
		
		/**********************************************
		 * RENDER 
		 **********************************************/
		protected function onEnterFrame(e:Event):void {
			render(true);
			
			
			
		}
		
		/**
		 * Add an isometric object to the world.
		 * @param obj		Tile object
		 * @param position	3 element array containing a designated position in the grid [column,row,z]
		 */
		public function addGroundObject(obj:Tile, position:Array = null):void {
			
			var col:Number = 0;
			var row:Number = 0;
			var z:Number = 0;
			
			if (position != null) {
				try {
					col = position[0] || 0;
					row = position[1] || 0;
					z = position[2] || 0;
					obj.moveToCell(col, row,z);
				}catch (e:Error) {
					
				};
			}
			
			obj.aStarGrid = _aStarGrid;
			_groundScene.addChild(obj);
			
			if (obj is MovableTile) {
				_movableTile = MovableTile(obj);
			}
			
		}
		
		
		/**********************************************
		 * GETTERS/SETTERS 
		 **********************************************/
		
		public function get grid():IsoGrid {
			return _grid;
		}
		
		public function get aStarGrid():AStarGrid { return _aStarGrid; }
		
		
		public function set_walkable(column:int, row:int, value:Boolean):void 
		{
			_aStarGrid.setWalkable(column, row, value);
		}
		
		
	}

}

