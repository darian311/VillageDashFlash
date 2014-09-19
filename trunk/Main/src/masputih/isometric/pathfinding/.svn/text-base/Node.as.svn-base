package masputih.isometric.pathfinding {
	
	
	/**
	 * AStar node 
	 */
	public class Node  {

		
		public var column:int;
		public var row:int;
		
		/**
		 * total estimated cost to the destination node (g + h )
		 */
		public var f:Number;
		
		/**
		 * cost from starting node to the current node
		 */
		public var g:Number;
		/**
		 * estimated cost from the current node to destination
		 */
		public var h:Number;
		
		public var walkable:Boolean = true;
		
		public var parent:Node;
		
		public var data:*;
		
		public var hasVisited:Boolean = false;
		
		public function Node(column:int, row:int,data:* = null):void {
			
			this.column = column;
			this.row = row;
			this.data = data;
		}
		
		public function toString():String {
			return "[Node( column: " + column +", row: " + row + ")]";
		}
		
	}
	
}