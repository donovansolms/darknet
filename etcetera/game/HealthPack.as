/*
	darknet
	IMY300 Minigame
	
	Donovan Solms
	25298853
	16 March 2008
	
	HealthPack.as
		Does the handling for HealthPacks
*/

package etcetera.game
{
	import flash.display.MovieClip;
	import etcetera.levels.Level;
	import etcetera.characters.Character;
	
	public class HealthPack extends MovieClip
	{
		var _isUsed:Boolean = false;
		
		public function HealthPack()
		{
			
		}
		
		public function setPos(xpos:Number, ypos:Number):void
		{
			x = xpos;
			y = ypos;
		}
		
		public function doAll(character:Character,level:Level):void
		{
			if (character.hitTestObject(this))
			{
				character.hurtHeal(100);
				_isUsed = true;
			}
			
		}
		
		public function get Used():Boolean
		{
			return _isUsed;
		}
	}
}