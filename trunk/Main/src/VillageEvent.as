package
{
	import flash.events.Event;
	
	public class VillageEvent extends Event
	{
		public var farmer:Farmer;  // can hold a reference to a farmer if the event is relevant to a farmer. 
							// null otherwise.
		
		public function VillageEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, f:Farmer = null)
		{
			super(type, bubbles, cancelable);
			farmer = f;
		}
	}
}