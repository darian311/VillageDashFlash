package {
	import com.baseoneonline.flash.astar.AStar;
	import com.baseoneonline.flash.astar.AStarNode;
	import com.baseoneonline.flash.geom.IntPoint;
	import com.baseoneonline.flash.utils.StopWatch;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	
	import MapView;
	import TileMap;
	
	
	
	public class AStarTest extends Sprite
	{
		
		public function AStarTest()
		{
			//stage.scaleMode = StageScaleMode.NO_SCALE;
			//stage.align = StageAlign.TOP_LEFT;
			// 
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

	
	
		// The example map and it's view
		// could be one class as well. 
		private var map:TileMap;
		private var mapView:MapView;
		
		// Where the path will be drawn
		private var overlay:Sprite;
		
		// Size in pixels per tile
		private var tileSize:Number = 25
		
		// Show where we click
		private var startCursor:Shape;
		private var goalCursor:Shape;
		
		// Our start and goal positions
		private var start:IntPoint;
		private var goal:IntPoint;
		
		// Not very precise measuring tool
		private var stopwatch:StopWatch;
		
		/**
		 * 	Added to stage handler
		 * 	
		 */
		private function init(e:Event):void
		{
			// First create a map to work with,
			// This can be any kind of 2D tilemap as
			// long as it implements IAStarSearchable
			map = new TileMap(10,10);
			
			// Make a random tiles unwalkable
			placeRandomWalls(map,.01+Math.random()*.4);
			
			// Just a simple grid view
			mapView = new MapView(map, tileSize);
			addChild(mapView);
			mapView.draw();
	
			// Add the overlay to draw on
			overlay = new Sprite();
			addChild(overlay);
			
			// Create the cursors
			startCursor = createCursor(tileSize-2, 0x00FF00);
			addChild(startCursor);
			goalCursor = createCursor(tileSize-3, 0xFF0000);
			addChild(goalCursor);
			
			// A stopwatch
			stopwatch = new StopWatch("Last solve time:");
			addChild(stopwatch);
			
			// No fun without this
			this.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		/**
		 * 	Make a square to mark a position.
		 * 
		 */
		private function createCursor(size:Number, col:uint):Shape
		{
			var s:Shape = new Shape();
			var g:Graphics = s.graphics;
			g.lineStyle(1,col);
			g.drawRect(-size/2,-size/2, size, size);
			return s;
		}
		
		
		/**
		 * 	Place the cursors on their positions.
		 * 
		 */
		private function updateCursors():void
		{
			var p:Point;
			if (start) {
				p = mapToScreen(start);
				startCursor.x = p.x;
				startCursor.y = p.y;
			}
			if (goal) {
				p = mapToScreen(goal);
				goalCursor.x = p.x;
				goalCursor.y = p.y;
			}
		}
		
		/**
		 * 	Return a random position on the map that is walkable
		 * 
		 */
		private function getRandomWalkablePos(map:TileMap):IntPoint
		{
			while(true) {
				x = Math.floor(Math.random()*map.getWidth());
				y = Math.floor(Math.random()*map.getHeight());
				//trace(map.isWalkable(x,y));
				if (map.isWalkable(x,y)) return new IntPoint(x,y);
			}
			return null;
		}
		
		/**
		 * 	On which tile is a point on the screen?
		 * 
		 */
		private function screenToMap(p:Point):IntPoint
		{
			return new IntPoint( Math.floor(p.x/tileSize), Math.floor(p.y/tileSize) );
		}
		
		/**
		 * 	Return the center position of a tile in pixels
		 * 
		 */
		private function mapToScreen(p:IntPoint):Point
		{
			return new Point( (p.x*tileSize)+(tileSize/2), (p.y*tileSize)+(tileSize/2) );
		}
		
		
		/**
		 * 	Handle click, start solving 
		 * 
		 * 
		 */
		private function onClick(e:MouseEvent):void
		{
			// Clear, or we have rubble next time we click
			overlay.graphics.clear();
			
			// Pick a random position on the map the first time.
			if (!goal) goal = getRandomWalkablePos(map);
			
			// Shift: arrival point is now starting point
			start = goal;
			
			// Mark the clicked position as the goal
			goal = screenToMap(new Point(mouseX, mouseY));
			
			// Give feedback
			updateCursors();
			
			// Only calculate if the goal is not a wall
			if (map.isWalkable(goal.x,goal.y)) {
				
				// Start measuring the time
				// it will take to calculate a path
				stopwatch.start();
				
				// Say, little star, show me the way...
				// 
				var a:AStar = new AStar(map, start, goal);
				var solution:Array = a.solve();
				
				// How long did it take?
				stopwatch.display();
				
				// Draw all visited nodes (just for fun)
				for (var j:int=0; j<a.visited.length; j++) {
					var vn:AStarNode = a.visited[j];
					drawLine(vn, vn.parent, 0xFF00FF);
				}
				
				// Do we have a path?
				if (solution) {
					// YES! Loop and plot...
					var n:IntPoint = solution[0];
					for (var i:int=1; i<solution.length; i++) {
						var n2:IntPoint = n;
						n = solution[i];
						drawLine(n,n2,0xFFFFFF, 3);
					}
					drawLine(n,start,0xFFFFFF,3);
				}
				
			} else {
				// Alas, just plot a line
				drawLine(start, goal, 0x0000FF);
			}
			
		}
		
		/**
		 * 	Draw a line from a to b
		 * 
		 */
		private function drawLine(a:IntPoint, b:IntPoint, col:uint, width:Number=1):void {
			var pa:Point = mapToScreen(a);
			var pb:Point = mapToScreen(b);
			overlay.graphics.lineStyle(width,col);
			overlay.graphics.moveTo(pa.x, pa.y);
			overlay.graphics.lineTo(pb.x, pb.y);
		}
		
		/**
		 * Place random blocking tiles on the map
		 */
		private static function placeRandomWalls(map:TileMap, bias:Number=.1):void
		{
			for (var x:int=0; x<map.getWidth(); x++) {
				for (var y:int=0; y<map.getHeight(); y++) {
					map.setWalkable(x,y,Math.random() > bias);
				}
			}			
		}
		




	}
}
