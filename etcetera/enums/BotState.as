/*
	darknet
	IMY300 Minigame
	
	Donovan Solms
	25298853
	13 March 2008
	
	BotStates.as
		Contains enumerations for bot states
*/

package etcetera.enums
{
	public final class BotState
	{
		public static const PATROL:String = "Patrol";				//walks left and right in a specified area
		public static const PATROLATTACK:String = "PatrolAttack";				//walks left and right in a specified area
		public static const WATCH:String = "Watch";					//stands still watching in one direction
		public static const WATCHATTACK:String = "WatchAttack";		//stands still watching in one direction
		public static const HUNT:String = "Hunt";					//onvce the character is seen, bot will jump/run/		
																	//up/down level looking for character to kill him
		public static const HUNTWATCH:String = "HuntWatch";			//walk left/right till sees player, then hunt		
		public static const HUNTATTACK:String = "HuntAttack";		//onvce the character is seen, bot will jump/run/
	}
}