package masputih.isometric.pathfinding {
	
	import masputih.isometric.pathfinding.*;
	import de.polygonal.ds.SLinkedList;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 *
	 * 
	 * Serves as a visual representation of a grid of nodes used in a pathfinding solution.
	 */
	public class GridView extends Sprite {
	
		public static const NAME:String = "gridView";
		
		public var cellSize:int = 20;
		private var _grid:AStarGrid;
		
		/**
		 * Constructor.
		 */
		public function GridView(grid:AStarGrid) {
			name = NAME;
			_grid = grid;
			drawGrid();
			
			alpha = .5;
			
		}
		
		/**
		 * Draws the given grid, coloring each cell according to its state.
		 */
		public function drawGrid():void {
			
			graphics.clear();
			
			for(var i:int = 0; i < _grid.numCols; i++)
			{
				for(var j:int = 0; j < _grid.numRows; j++)
				{
					var node:Node = _grid.getNode(i, j);
					graphics.lineStyle(0,0xCCCCCC,.5);
					graphics.beginFill(getColor(node),1);
					graphics.drawRect(i * cellSize, j * cellSize, cellSize, cellSize);
					graphics.endFill()
				}
			}
			
		}
		
		/**
		 * Determines the color of a given node based on its state.
		 */
		private function getColor(node:Node):uint {
			
			if(!node.walkable) return 0;
			if(node == _grid.getStartNode()) return 0xFFCC66;
			if(node == _grid.getEndNode()) return 0xFF80FF;
			return 0xffffff;
		}
		
		/**
		 * Highlights all nodes that have been visited.
		 */
		public function showVisited(astar:AStar):void {
			
			var visited:Array = astar.visited;
			////trace(visited.length);
			for(var i:int = 0; i < visited.length; i++)
			{
				if (visited[i] == _grid.getStartNode()) continue;
				
				graphics.beginFill(0xcccccc,1);
				graphics.drawRect(Node(visited[i]).column * cellSize, Node(visited[i]).row * cellSize, cellSize, cellSize);
				graphics.endFill();
			}
		}
		
		/**
		 * Highlights the found path.
		 */
		public function showPath(path:Array):void {
			
			//redraw grid
			drawGrid();
			for(var i:int = 0; i < path.length; i++)
			{
				graphics.lineStyle(0);
				graphics.beginFill(0x008040,1);
				graphics.drawRect(Node(path[i]).column * cellSize, Node(path[i]).row * cellSize, cellSize, cellSize );
				graphics.endFill()
			}
		}
	}
}