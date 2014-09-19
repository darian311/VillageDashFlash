package com.utilities 
{
	import away3d.core.project.MovieClipSpriteProjector;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import gs.TweenLite;
	
	/**
	 * ...
	 * @author Ian Stokes www.unit2design.com 2010
	 */
	public class QuickEffect extends Sprite 
	{
		
		public function QuickEffect(clp:MovieClip,lifeTimer:Number) 
		{
			clp.x -= clp.width / 2;
			clp.y -= clp.height / 2;
			addChild(clp);
			TweenLite.to(this, .6, { delay:lifeTimer, alpha:0, onComplete:kill } );
		}
		private function kill():void {
			this.parent.removeChild(this);
		}
	}
	
}