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
	public class Crops_Ground extends Tile
	{
		private var _art:EmbedSecure
		public var plot:MovieClip
		public function Crops_Ground(iso:IsoGrid,art:EmbedSecure) 
		{
			_art = art;
			super(iso)
			fillColor = Math.random() * 0xFFFFFF;
			spans = [2, 2]
			walkable = false

			plot=new crops_low()
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