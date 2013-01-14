/*
	darknet
	IMY300 Minigame
	
	Donovan Solms
	25298853
	05 MArch 2008
	
	HealthBar.as
		Class for the healthbar
*/

package etcetera.characters
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	
	public class HealthBar extends MovieClip
	{
		public var health:Number;
		var healthMask:Sprite;
		var tempX:Number = 0;
		
		var markX:Number = 19;
		var markY:Number = 0;
		
		public function HealthBar()
		{
			health = 100;
			healthMask = new Sprite();
			addChild(healthMask);
		}
				
		public function changeHealth(value:Number):void
		{
			if ((health > 0) && (health <= 100))
			{

				if (value == 100)
				{
					health = 100;
					healthMask.graphics.clear();
					health = value;
					
					healthMask.graphics.beginFill(0xDDDDDD);
					tempX = 0;
					healthMask.graphics.drawRect(19, -2.5, 0, 6);
					healthMask.graphics.endFill();
				}
				else
				{
					healthMask.graphics.clear();
					health += value;
					
					healthMask.graphics.beginFill(0xDDDDDD);
					tempX -= (40 * value / 100);
					healthMask.graphics.drawRect(19-tempX, -2.5, tempX, 6);
					healthMask.graphics.endFill();
				}
			}
		}
	}
}