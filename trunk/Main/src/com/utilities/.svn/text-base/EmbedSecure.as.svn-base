package com.utilities 
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Ian Stokes www.unit2design.com 2010
	 */
	public class EmbedSecure extends MovieClip 
	{
		static public const ARTREADY_EVENT : String = " artready";
		public var loader:Loader
		
		public function EmbedSecure(art:Class) 
		{
			loader= new Loader ();
			loader.loadBytes (new art ());
		    loader.contentLoaderInfo.addEventListener (Event.COMPLETE, artR);	
		}
		
		private function artR(event:Event):void 
		{
	   	 dispatchEvent(new Event(ARTREADY_EVENT,true));
		}
	
	
		public function grabClass(str:String):Class
		{
			return loader.contentLoaderInfo.applicationDomain.getDefinition(str) as Class 
		}
		
		public function grabClassDict(ar:Array):Dictionary
		{
			var tempDic:Dictionary = new Dictionary();
			for (var D:Number = 0; D < ar.length; D++)
			{
				tempDic[ar[D]] = loader.contentLoaderInfo.applicationDomain.getDefinition(ar[D]) as Class;
			}
			return tempDic;
		}
		
}
}