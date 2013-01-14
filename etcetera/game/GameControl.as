/*
	darknet
	IMY300 Minigame
	
	Donovan Solms
	25298853
	17 February 2008
	
	GameControl.as
		Handles the game states
*/

package etcetera.game
{
	//imports
	import etcetera.enums.GameState;
	
	public class GameControl
	{
		//properties
		static var gameState:String;
		
		public static function set State(newState:String):void
		{
			if (gameState != newState)
			{
				gameState = newState;
				trace("Game state: " + gameState);
			}
		}
		
		public static function get State():String
		{
			return gameState;
		}
	}
}