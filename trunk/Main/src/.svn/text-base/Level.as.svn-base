// yoyo
package 
{
	/*******************************************************************************
	 *
	* Level class will contain all the settings specific to the level and 
	*	 Level[0] will game settings and default settings for a level. 
	*	 Level[1] to Level[infinity] will contain settings to override any defaults. 
	*   
	 * Instead of messing around with embedding xml files all settings will be hand coded here and only here. 
	*/		
		
		

	
	import com.utilities.EmbedSecure;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import mx.utils.ObjectUtil;

	
	public  class Level 
	{	
		
		public var start_score:uint;
		public var num_villagers:Number;
		public var innovation_name:String;
		public var innovation_desc:String;
		public var innovation_img:String;
		public var inventory:String;
		public var start_time:String; 
		public var win_condition:Number;// should this just be a boolean expression // fucntion that returns true or false
		// maybe just a simple number; cash for now. // get clever later.
		public var plot_positions:Array;  // array of points probably.
		public var farmer_positions:Array;
		public var player_position:Array;
		public var production_speed:Number; // speed at which orders // might be redudant with event array delays
		public var avatar_speed:Number; // speed that avatar can move around to visit each villager.
		public var cashhash:Object; //array of cash of awarded for each event; could be negative like onLeaveAngry
		public var event_delays:Object; // delays between events and their effects.  onVillagerAngry causes onLeaveAngry after 10 second 
		public var tutorial:Object; // hash of tutorial statements for a level, expecting to use this only on level 1
		
		// for example
		public var final_win_message:String;
	
		public var current_level:Number;
		
		//not sure how to handle empty constructors
		public function Level () {  
			trace("Creating a new Level");
			//Not sure if anything needs to be done with this constructor since values get initiated else where. 
			//maybe set all the default values from L
			
		}
		
		public static function cloneLevel(l:Level):Level{
			var newLevel:Level = new Level();
			newLevel.start_score = l.start_score;
			newLevel.num_villagers = l.num_villagers;
			newLevel.innovation_name = l.innovation_name;
			newLevel.innovation_desc = l.innovation_desc;
			newLevel.innovation_img = l.innovation_img;
			newLevel.inventory = l.inventory;
			newLevel.start_time = l.start_time; 
			newLevel.win_condition = l.win_condition;
			newLevel.plot_positions = l.plot_positions;
			newLevel.farmer_positions = l.farmer_positions;
			newLevel.player_position = l.player_position;
			newLevel.production_speed = l.production_speed;
			newLevel.avatar_speed = l.avatar_speed;
			newLevel.cashhash = l.cashhash;
			newLevel.event_delays = l.event_delays;
			newLevel.final_win_message = l.final_win_message;
			newLevel.current_level = l.current_level;
			newLevel.tutorial = l.tutorial;
			return newLevel;
		}
	}
}