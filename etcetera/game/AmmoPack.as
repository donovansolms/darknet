/*
	darknet
	IMY300 Minigame
	
	Donovan Solms
	25298853
	16 March 2008
	
	AmmoPack.as
		Does the handling for AmmoPacks
*/

package etcetera.game
{
	import flash.display.MovieClip;
	import etcetera.levels.Level;
	import etcetera.characters.Character;
	
	public class AmmoPack extends MovieClip
	{
		var _isUsed:Boolean = false;
		
		public function AmmoPack()
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
				character.upAmmo();
				_isUsed = true;
			}
		}
		
		public function get Used():Boolean
		{
			return _isUsed;
		}
	}
}