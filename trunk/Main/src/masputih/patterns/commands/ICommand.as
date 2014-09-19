package masputih.patterns.commands {
	import flash.events.Event;

	/**
	 * ...
	 * @author Anggie Bratadinata
	 */
	public interface ICommand {
		
		function execute(params:Array = null,event:Event = null):void;
		function setReceiver(receiver:* = null):void;
		function setOnComplete(callback:Function = null):void;
		function setOnError(callback:Function = null):void;
		function setParams(params:Array):void;
		function getParams():Array;
		
		function get name():String;
	}

}