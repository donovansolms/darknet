/*
	darknet
	IMY300 Minigame
	
	Donovan Solms
	25298853
	05 March 2008
	
	Level.as
		Class that holds a level
*/

package etcetera.levels
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	public class Level extends Bitmap
	{
		public var imageBMD:BitmapData;// = new LevelOne(3072,2304); load from disk
		
		public function Level(data:Bitmap)
		{
			imageBMD = data.bitmapData;
			super(imageBMD);
		}
		
		
	}
}