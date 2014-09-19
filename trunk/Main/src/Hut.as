package 
{
	import as3isolib.display.scene.IsoGrid;
	import com.utilities.EmbedSecure;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import masputih.isometric.Box;
	import masputih.isometric.Tile;

	/**
	 * ...
	 * @author ian
	 */
	public class Hut extends Box
	{
		private var _art:EmbedSecure
		public function Hut(iso:IsoGrid,h:Number,art:EmbedSecure) 
		{
			_art = art;
			super(iso, h)
			mainContainer.mouseEnabled=false
			fillColor = Math.random() * 0xFFFFFF;
			spans = [2,2]
			//this.z=10
			this.walkable = false;
			//var ht:Class = _art.grabClass("hutcopy");
			
			//Darian: used to be a sprite but changed it to MovieClip to match other swc assets
			var hut_instance:MovieClip = new hut();
			// was flickering; probably extra empty frame and looping
			hut_instance.stop();
			//hut.addChild(new Bitmap(new hutcopy(1, 1)));
			hut_instance.mouseEnabled = false;
			hut_instance.mouseChildren = false
			hut_instance.useHandCursor = false
			hut_instance.buttonMode=false
			hut_instance.x -= hut_instance.width / 2
			hut_instance.y -= (hut_instance.height / 2)+10
			sprites = [hut_instance]
			sprites[0].mouseEnabled=false
		}
		
	}

}