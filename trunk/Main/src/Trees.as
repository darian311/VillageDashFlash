package 
{
	/**
	 * ...
	 * @author ian
	 */
	import as3isolib.display.scene.IsoGrid;
	import com.utilities.EmbedSecure;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import masputih.isometric.Box;
	import masputih.isometric.Tile;
	public class Trees extends Box
	{
		private var _art:EmbedSecure
		public function Trees(iso:IsoGrid,h:Number) 
		{
			super(iso, h)
			mainContainer.mouseEnabled=false
			fillColor = Math.random() * 0xFFFFFF;
			spans = [2,2]
			this.walkable = false;
			//var ht:Class = _art.grabClass("tree");
			var spr:Sprite = new Sprite();
			spr.addChild(new tree());
			spr.mouseEnabled = false;
			spr.mouseChildren = false;
			spr.useHandCursor = false;
			spr.buttonMode = false;
			spr.x -= spr.width / 2;
			spr.y -= (spr.height / 2) + 10;
			sprites = [spr];
			sprites[0].mouseEnabled = false;
		}
		
	}

}