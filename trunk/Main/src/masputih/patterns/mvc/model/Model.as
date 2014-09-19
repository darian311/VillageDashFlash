package masputih.patterns.mvc.model 
{
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Anggie Bratadinata
	 */
	public class Model extends EventDispatcher
	{
		
		public function Model() 
		{
			
		}
		
		public function update():void {
			dispatchEvent(new ModelEvent(ModelEvent.UPDATE));
		}
		
		public function get name():String {
			throw new Error("Unnamed model");
			return null;
		}
		
	}

}