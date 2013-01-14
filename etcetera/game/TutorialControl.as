/*
	darknet
	IMY300 Minigame
	
	Donovan Solms
	25298853
	16 March 2008
	
	TutorialControl.as
		Handles the tutorial states
*/

package etcetera.game
{
	//imports
	import etcetera.enums.TutorialState;
	import etcetera.game.GameControl;
	import etcetera.enums.GameState;
	
	public class TutorialControl
	{
		static var hasStart:Boolean = false;
		static var hasUzi:Boolean = false;
		static var hasRifle:Boolean = false;
		static var hasRocketLauncher:Boolean = false;
		static var hasGuard:Boolean = false;
		static var hasSniper:Boolean = false;
		static var hasHunter:Boolean = false;
		static var hasJumping:Boolean = false;
		
		//properties
		static var tutorialState:String;
				
		public static function set State(newState:String):void
		{
			if (tutorialState != newState)
			{
				if (tutorialState != TutorialState.DONE)
				{
					if ((newState == TutorialState.START) && (!hasStart))
					{
						hasStart = true;
						tutorialState = newState;
						GameControl.State = GameState.PAUSE;
					}
					if ((newState == TutorialState.UZI) && (!hasUzi))
					{
						hasUzi = true;
						tutorialState = newState;
						GameControl.State = GameState.PAUSE;
					}
					if ((newState == TutorialState.RIFLE) && (!hasRifle))
					{
						hasRifle = true;
						tutorialState = newState;
						GameControl.State = GameState.PAUSE;
					}
					if ((newState == TutorialState.ROCKETLAUNCHER) && (!hasRocketLauncher))
					{
						hasRocketLauncher = true;
						tutorialState = newState;
						GameControl.State = GameState.PAUSE;
					}
					if ((newState == TutorialState.GUARD) && (!hasGuard))
					{
						hasGuard = true;
						tutorialState = newState;
						GameControl.State = GameState.PAUSE;
					}
					if ((newState == TutorialState.SNIPER) && (!hasSniper))
					{
						hasSniper = true;
						tutorialState = newState;
						GameControl.State = GameState.PAUSE;
					}
					if ((newState == TutorialState.HUNTER) && (!hasHunter))
					{
						hasHunter = true;
						tutorialState = newState;
						GameControl.State = GameState.PAUSE;
					}
					if ((newState == TutorialState.JUMPING) && (!hasJumping))
					{
						hasJumping = true;
						tutorialState = newState;
						GameControl.State = GameState.PAUSE;
					}
					if ((newState == TutorialState.CONTINUE))
					{
						tutorialState = newState;
						GameControl.State = GameState.PLAYING;
					}
					
				}					
			}
		}
		
		public static function get State():String
		{
			return tutorialState;
		}
	}
}