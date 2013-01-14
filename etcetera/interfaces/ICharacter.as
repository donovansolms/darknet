/*
	darknet
	IMY300 Minigame
	
	Donovan Solms
	25298853
	05 March 2008
	
	ICharacter.as
		Interface of function a character must support
*/

package etcetera.interfaces
{
	public interface ICharacter
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