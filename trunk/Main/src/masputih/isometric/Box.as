package masputih.isometric {
	import as3isolib.display.primitive.IsoBox;
	import as3isolib.display.scene.IsoGrid;
	import as3isolib.graphics.SolidColorFill;
	import masputih.isometric.Tile;
	//import nl.demonsters.debugger.MonsterDebugger;
	
	/**
	 * ...
	 * @author Anggie Bratadinata
	 */
	public class Box extends Tile{
		
		protected var _isoBox:IsoBox;
		
		public function Box(grid:IsoGrid,height:Number = 20) {
			super(grid);
			this.height = height;
		
		}
		
		override protected function drawGeometry():void 
		{
			if (_isoBox) {
				removeChild(_isoBox);
			}
			
			_isoBox = new IsoBox();
			
			_isoBox.fill = new SolidColorFill(fillColor,.5);
			_isoBox.setSize(width, length, height);
			addChild(_isoBox);
		}
		
	}

}