package masputih.isometric 
{
	import as3isolib.geom.Pt;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Anggie Bratadinata
	 */
	public class MathUtils
	{
		
		/**
		 * Convert a 2d screen coordinate to grid column and row
		 * @param point
		 * @return [column,row]
		 */
		public static function screenToGrid(view:World,point:Point):Array {
			
			var isoPt:Pt = view.localToIso(point);
			var csize:Number = view.grid.cellSize;
			var column:Number = Math.floor(isoPt.x / csize);
			var row:Number = Math.floor(isoPt.y / csize);
			
			return [column,row];
		}
		
	}

}