package masputih.patterns.mvc.controller.commands
{
	
	import masputih.patterns.commands.CommandEvent;
	import masputih.patterns.commands.ICommand;
	import masputih.patterns.commands.SimpleCommand;
	import masputih.patterns.mvc.controller.Controller;
	import flash.events.Event;
	import nl.demonsters.debugger.MonsterDebugger;
	
	/**
	 * Utility command to remove another command from a controller.
	 * @author Anggie Bratadinata
	 */
	public class RemoveCommand extends SimpleCommand
	{
		
		public static const NAME:String = "RemoveCommand";
		
		public function RemoveCommand() 
		{
		}
		
		/**
		 * Execute. Remove a command. 
		 * @param params [ command instance/name, dispatcher, eventType ]
		 * @param event  event that triggers this command in a controller
		 */
		override public function execute(params:Array = null, event:Event = null):void {
			super.execute(params, event);
			
			if (_receiver == null ) return;
			
			var c:Controller = _receiver as Controller;
			var cmd:String = getParams()[0];
			c.removeCommand(cmd, getParams()[1], getParams()[2], onCommandRemoved);
			
		}
		
		private function onCommandRemoved():void {
			MonsterDebugger.trace(this, "command removed");
			dispatchEvent(new CommandEvent(CommandEvent.COMPLETE));
		}
		
		override public function get name():String { return RemoveCommand.NAME; }
	}
	
}