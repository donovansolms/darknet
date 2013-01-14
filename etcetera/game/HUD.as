/*
	darknet
	IMY300 Minigame
	
	Donovan Solms
	25298853
	05 March 2008
	
	HUD.as
		Class controls the heads-up-display
*/

package etcetera.game
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class HUD extends MovieClip
	{
		public function HUD()
		{
			
		}
		
		public function updateHealth(value:Number):void
		{

			healthText.text = value.toString();
		}
		
		public function updateAmmo(value:Number):void
		{
			ammoText.text = value.toString();
		}
		
		public function updateSelectedGun(value:String)
		{
			//if (value == Guns.PISTOL)
			//	pistolBox.y -= 10;
			//if (value == Guns.UZI)
			//	uziBox.y -= 10;
			//if (value == Guns.RIFLE)
			//	rifleBox.y -= 10;
			//if (value == Guns.ROCKETLAUNCHER)
			//	rocketBox.y -= 10;
		}
	}
}