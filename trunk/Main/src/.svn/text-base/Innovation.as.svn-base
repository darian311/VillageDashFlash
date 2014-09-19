package 
{
	import as3isolib.display.scene.IsoGrid;
	import com.utilities.EmbedSecure;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import masputih.isometric.Box;
	import masputih.isometric.Tile;
	/**
	 * ...
	 * @author ian
	 */
	public class Innovation extends Box
	{
		private var _art:EmbedSecure
		public var mySprite:MovieClip
		public function Innovation(iso:IsoGrid,h:Number,art:EmbedSecure = null) 
		{
			_art = art;
			super(iso, h)
			fillColor = Math.random() * 0xFFFFFF;
			spans = [2, 2]
			//this.z=10
			this.walkable = false
			//var ht:Class = _art.grabClass("innovations");
			mySprite=new innovations();
			mySprite.mouseEnabled = false;
			mySprite.mouseChildren=false
			mySprite.x -= 75
			mySprite.y = 0
			mainContainer.mouseChildren=false
			mainContainer.mouseEnabled=false
			sprites = [mySprite]
		
		}
		public function set frame(num:uint):void {
			//mySprite.gotoAndStop(num)
		}
	}

}