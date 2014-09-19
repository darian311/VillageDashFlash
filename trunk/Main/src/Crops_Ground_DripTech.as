package
{
	import as3isolib.display.scene.IsoGrid;
	
	import com.utilities.EmbedSecure;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import masputih.isometric.Tile;
	/**
	 * ...
	 * @author ian
	 */
	public class Crops_Ground_DripTech extends Crops_Ground
	{
		private var _art:EmbedSecure
		public function Crops_Ground_DripTech(iso:IsoGrid) 
		{
			var mc:MovieClip = new MovieClip();
			super(iso, _art)
			fillColor = Math.random() * 0xFFFFFF;
			spans = [2, 2]
			walkable = false
			//var plt:Class = _art.grabClass("crops_low");
			plot = new crops_driptech()
			plot.mouseEnabled = false;
			plot.mouseChildren=false
			
			//plot.x -= plot.width/2
			plot.y +=30
			//plot.mouseEnabled=false
			plot.alpha=0
			sprites = [plot]
			mainContainer.mouseChildren=false
			mainContainer.mouseEnabled=false
		}
		
	}

}