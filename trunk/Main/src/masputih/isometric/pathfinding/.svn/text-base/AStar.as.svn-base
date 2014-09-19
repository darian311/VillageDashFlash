package masputih.isometric.pathfinding {
	import flash.events.EventDispatcher;
	//import nl.demonsters.debugger.MonsterDebugger;
	
	/**
	 *
	 * 
	 */
	public class AStar extends EventDispatcher {
		
		
		
		private var _straightCost:Number = 1;
		private var _diagonalCost:Number = Math.SQRT2;
		
		private var _grid:AStarGrid;
		private var _startNode:Node;
		private var _endNode:Node;
		
		/**
		 * nodes that have been examined and assigned cost
		 */
		private var _open:Array;
		/**
		 * nodes whose neighbors are all have been examined
		 */
		private var _closed:Array;
		
		/**
		 * The found path.
		 */
		private var _path:Array;
		
		public function get path():Array { return _path; }
		
		public function get visited():Array {
			return _closed.concat(_open);
		}
		
		public function get grid():AStarGrid { return _grid; }

		/**
		 * Constructor: AStar
		 */
		public function AStar(grid:AStarGrid) {
			_grid = grid;
		}
		
		
		/**
		 * Find path on the grid
		 * @param grid AStarGrid
		 */
		public function findPath():void {
			_path = [];
			_open = [];
			_closed = [];
			
			if (_grid.getEndNode() == null || _grid.getStartNode() == null ) {
				
				//MonsterDebugger.trace(this, "no path");
				return;
			}
			
			_startNode = grid.getStartNode();
			_endNode = grid.getEndNode();
			
			_startNode.g = 0;
			_startNode.h = calculateCostFromNode(_startNode);
			_startNode.f = _startNode.g + _startNode.h;
			
			search();
		}
		
		private function calculateCostFromNode(node:Node):Number {
			
			var dx:Number = Math.abs(node.column - _endNode.column);
			var dy:Number = Math.abs(node.row - _endNode.row);
			
			/****************************************
				DIAGONAL : 
				Less nodes to inspect, more calculation per node
				Less natural path
			*****************************************/
			
			//var diag:Number = Math.min(dx , dy);
			//var straight:Number = dx + dy;
			//var cost:Number = (_diagonalCost * diag) + (_straightCost * (straight - 2 * diag)); 
			
			/****************************************
				MANHATTAN : 
				More nodes to inspect, less calculation per node
				More natural path
			*****************************************/
			var cost:Number = (dx + dy) * _straightCost;
			
			/****************************************
				EUCLIDEAN : between the other two
			*****************************************/
			//var cost:Number = Math.sqrt(dx * dx + dy * dy) * _straightCost;
			
			return cost;
		}
		
		/**
		 * Search path.
		 */
		private function search():void {
 			
			dispatchEvent(new AStarEvent(AStarEvent.SEARCH));
			
			var currentNode:Node = _startNode;
			
			while (currentNode != _endNode) {
				
				//neighbors = getNeighbors(currentNode);
				
				var neighbors:Array = [];
				var neighborNode:Node;
				
				/****************************************
					Get neighbor nodes
				*****************************************/
				var minCol:int = Math.max(0, currentNode.column - 1);
				var maxCol:int = Math.min(_grid.numCols - 1, currentNode.column+ 1);
				
				var minRow:int = Math.max(0, currentNode.row - 1);
				var maxRow:int = Math.min(_grid.numRows-1, currentNode.row + 1)
				
				for (var c:int = minCol; c <= maxCol; c++) {
					for (var r:int = minRow ; r <= maxRow ; r++) {
						neighbors.push(_grid.getNode(c, r));
					}
						
				}
				
				/****************************************
					Examine each neighbor
				*****************************************/
				for (var i:int = 0, len:int = neighbors.length; i < len; i++){
					
					neighborNode = neighbors[i];
				
					//exclude currentNode or non-walkable currentNode
					//also exclude path through 2 diagonal non-walkables
					if (neighborNode == currentNode || !neighborNode.walkable
						|| !_grid.getNode(currentNode.column, neighborNode.row).walkable
						|| !_grid.getNode(neighborNode.column, currentNode.row).walkable )  {
						continue;
					}
					
					//cost from the currentNode to the neighbor node on straight path
					var cost:Number = _straightCost;
					//if neighborNode is diagonal to the currentNode
					if (!((currentNode.row == neighborNode.row) || (currentNode.column == neighborNode.column))) {
						cost = _diagonalCost;
					}
					
					//A-star cost
					var g:Number = currentNode.g + cost;
					var h:Number = calculateCostFromNode(neighborNode);
					var f:Number = g + h;
					
					//if the neighborNode has already been inspected in the previous iteration
					if (_open.indexOf(neighborNode) != -1 || _closed.indexOf(neighborNode) != -1) {
						//if the previously assigned f of the neighborNode's is greater than 
						//the newly calculated f, the new node is a better path, 
						//change the cost of the neighborNode to the current one 
						//and set its parent to the current node
						if (neighborNode.f > f) {
							neighborNode.f = f;
							neighborNode.g = g;
							neighborNode.h = h;
							neighborNode.parent = currentNode;
						}
						
					}else {
						neighborNode.f = f;
						neighborNode.g = g;
						neighborNode.h = h;
						neighborNode.parent = currentNode;
						_open.push(neighborNode);
						
					}
					
				}
				
				//all valid neighbor nodes have been examined,
				//push the current currentNode into the closed list
				_closed.push(currentNode);
				
				if (_open.length == 0) {
					
					if(!_grid.forceClosestPath)
					{
						dispatchEvent(new AStarEvent(AStarEvent.NO_PATH));
						return ;
					}
					else
					{
						_closed.sortOn("h" , Array.NUMERIC);
						_endNode = _closed.shift() as Node;	
						break;
					} 
				}
				else
				{
					//sort the open list so that the lowest cost node is at front
					_open.sortOn("f", Array.NUMERIC);
					//next, examine the open node with the least cost
					currentNode = _open.shift() as Node;
				}			
				
			}
			
			buildPath()
			
			
		}
		
		private function getNeighbors(currentNode:Node):Array
		{
			var neighbors:Array = [];
				
			var minCol:int = Math.max(0, currentNode.column - 1);
			var maxCol:int = Math.min(_grid.numCols - 1, currentNode.column+ 1);
			
			var minRow:int = Math.max(0, currentNode.row - 1);
			var maxRow:int = Math.min(_grid.numRows-1, currentNode.row + 1)
			
			for (var c:int = minCol; c <= maxCol; c++) {
				for (var r:int = minRow ; r <= maxRow ; r++) {
					var n:Node = _grid.getNode(c, r);
					neighbors.push(n);
				}
					
			}
			return neighbors;
		}
		
		/**
		 * Build path.
		 */
		private function buildPath():void {
			
			var currentNode:Node = _endNode;
			
			_path = [];
			
			_path.push(currentNode);
			
			while (currentNode != _startNode) {
				currentNode = currentNode.parent;
				_path.unshift(currentNode);
			}
			
			dispatchEvent(new AStarEvent(AStarEvent.COMPLETE, _path));
			
		}
		

		
	}
	
}