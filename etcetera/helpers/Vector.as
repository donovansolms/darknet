/*
	darknet
	IMY300 Minigame
	
	Donovan Solms
	25298853
	05 March 2008
	
	Vector.as
		Defines a vector for the game
*/

package etcetera.helpers
{
	public class Vector
	{
		public var p0:Object = {x: 0, y: 0};	//start
		public var p1:Object = {x: 0, y: 0};	//end
		public var vx:Number = 0;				//x component
		public var vy:Number = 0;				//y component
		public var rx:Number = 0;				//x righthand normal
		public var ry:Number = 0;				//y righthand normal
		public var lx:Number = 0;				//x lefthand normal
		public var ly:Number = 0;				//y lefthand normal
		public var length:Number = 0;			//length

		public function Vector()
		{

		}
	}
}