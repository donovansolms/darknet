/*
	darknet
	IMY300 Minigame
	
	Donovan Solms
	25298853
	17 February 2008
	
	LevelControl.as
		Handles the level states
*/

package etcetera.game
{
	//imports
	import etcetera.enums.LevelState;
	
	public class LevelControl
	{
		//properties
		static var levelState:String;
		
		public static function set State(newState:String):void
		{
			if (levelState != newState)
			{
				levelState = newState;
				trace("Level state: " + levelState);
			}
		}
		
		public static function get State():String
		{
			return levelState;
		}
	}
}