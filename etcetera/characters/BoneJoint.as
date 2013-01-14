/*
	darknet
	IMY300 Minigame
	
	Donovan Solms
	25298853
	02 March 2008
	
	Level.as
		Class that defines a joint in the characters
*/

package etcetera.characters
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	
	public class BoneJoint extends MovieClip
	{		
		public var imageBMD:BitmapData = new PointBMD(4,4);
		public var image:Bitmap = new Bitmap(imageBMD);
		
				
		var _maySolve:Boolean = true;
		 
		//gravity stuff
		public var vel:Object = { x: 0, y: 0};
		public var pos:Object = { x: x, y: y };
		public var old:Object = { x: x, y: y };
		public var radius:Number = width / 2;
		//var movie:Object = { width: 1024	, height: 300 };
		
		public var gravity:Number = 0.3;
		public var restitution:Number = 0.6;
		public var friction:Number = 0.8;
		
		public function BoneJoint()
		{
			this.alpha = 0;
			image.x = -2;
			addChild(image);
			
		}
		
		public function maySolve(val:Boolean):void
		{
			_maySolve = val;
		}
		
		public function solveGravity():void
		{
			if(_maySolve)
			{
				pos = { x: x, y: y };
				old = { x: x, y: y };
				vel.y += gravity;
			
				pos.x += vel.x;
				pos.y += vel.y;
				
				x = pos.x;
				y = pos.y;
			}
		}
	}	
}