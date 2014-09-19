package masputih.isometric.pathfinding {
	
	import de.polygonal.ds.Array2;
	
	/**
	 *
	 * 
	 */
	public class AStarGrid{
		
		public var numRows:int;
		public var numCols:int;
		
		public var forceClosestPath:Boolean;
		
		private var _startNode:Node;
		private var _endNode:Node;
		private var _nodes:Array2;
		

		public function AStarGrid(columns:int = 20, rows:int = 20) {
			
			numCols = columns;
			numRows = rows;
			
			_nodes = new Array2(numCols, numRows);
			
			for (var i:int = 0; i < numCols; i++ ) {
				for (var j:int = 0; j < numRows; j++) {
					_nodes.set(i,j, new Node(i, j));
				}
			}
		}
		
		/**
		 * Clone this grid.
		 * 
		 */
		public function clone():AStarGrid {
			var ag:AStarGrid = new AStarGrid(numCols, numRows);
			for (var i:int = 0; i < numCols; i++ ) {
				for (var j:int = 0; j < numRows; j++) {
					ag.nodes.set(i,j, _nodes.get(i,j));
				}
			}
			
			if (getStartNode() != null) {
				ag.setStartNode(getStartNode().column, getStartNode().row);
			}
			
			if (getEndNode() != null) {
				ag.setEndNode(getEndNode().column, getEndNode().row);
			}
			
			return ag;
		}
		
		public function setStartNode(column:int, row:int):void {
			if (column < 0 || row < 0 || column > _nodes.width-1 || row > _nodes.height -1) {
				_startNode = null;
				return;
			}
			_startNode = _nodes.get(column,row) as Node;
		}
		
		public function getStartNode():Node { return _startNode; }

		public function setEndNode(column:int, row:int):void {
			if (column < 0 || row < 0 || column > _nodes.width-1 || row > _nodes.height -1) {
				_endNode = null;
				return;
			}
			_endNode = _nodes.get(column,row) as Node;
		}
		
		public function getEndNode():Node { return _endNode; }
		
		
		/**
		 * Set a node walkable/unwalkable
		 * @param column
		 * @param row		
		 * @param value		Boolean
		 */
		public function setWalkable(column:int, row:int, value:Boolean):void {
			Node(_nodes.get(column,row)).walkable = value;
		}
		
		/**
		 * Get a node in a column & row.
		 *
		 */
		public function getNode(column:int, row:int):Node {
			return _nodes.get(column,row) as Node;
		}
		
		/**
		 * Extra (meta) data for a node to carry.
		 * @param column
		 * @param row
		 * @param value
		 */
		public function setNodeData(column:int, row:int, value:*):void {
			Node(_nodes.get(column,row)).data = value;
		}
		
		/**
		 * Get all nodes.
		 */
		public function get nodes():Array2 { return _nodes; }
		
		
	}
	
}