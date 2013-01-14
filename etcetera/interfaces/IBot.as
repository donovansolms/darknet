/*
	darknet
	IMY300 Minigame
	
	Donovan Solms
	25298853
	12 March 2008
	
	IBot.as
		Interface of functions a bot must support
*/

package etcetera.interfaces
{
	public interface IBot
	{
		//redraw the character
		function reDraw():void;
		//figure gravity for the character
		function solveGravity():void;
		//character die
		function Die():void;
		//name the character
		function set Name(value:String):void;
		function get Name():String;
	}	
}