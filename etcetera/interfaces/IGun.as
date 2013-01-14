/*
	darknet
	IMY300 Minigame
	
	Donovan Solms
	25298853
	05 March 2008
	
	IGun.as
		Interface of function a gun must support
*/

package etcetera.interfaces
{
	public interface IGun
	{
		function fire():Boolean;
		function fireBot(value:Number):Boolean;
		function decreaseAmmo();
		function increaseAmmo(value:int);
		function get Ammo():Number;
		function getGunType():String;
	}	
}