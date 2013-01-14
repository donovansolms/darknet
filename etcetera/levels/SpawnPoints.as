/*
	darknet
	IMY300 Minigame
	
	Donovan Solms
	25298853
	13 March 2008
	
	SpawnPoints.as
		Defines spawnpoints for a level
*/

package etcetera.levels
{
	import flash.geom.Point;
	
	public class SpawnPoints
	{
		var botspawns:Array = new Array();
		var healthspawns:Array = new Array();
		var ammospawns:Array = new Array();
		
		public function SpawnPoints()
		{
			
		}
		
		public function addBotSpawnPoint(xval:Number, yval:Number, newname:String, newtype:String)
		{
			var spawnbot:Object = {x: xval, y: yval, name: newname, type: newtype};
			botspawns.push(spawnbot);
			trace("ADDED NEW SPAWNBOT X: " + spawnbot.x + " Y: " + spawnbot.y + " Name: " + spawnbot.name + " type: " + spawnbot.type);
		}
		
		public function addHealthSpawnPoint(xval:Number, yval:Number)
		{
			var spawnhealth:Object = {x: xval, y: yval};
			healthspawns.push(spawnhealth);
			trace("ADDED NEW HEALTHPACK X: " + spawnhealth.x + " Y: " + spawnhealth.y);
		}
		
		public function addAmmoSpawnPoint(xval:Number, yval:Number)
		{
			var spawnammo:Object = {x: xval, y: yval};
			ammospawns.push(spawnammo);
			trace("ADDED NEW AMMOPACK X: " + spawnammo.x + " Y: " + spawnammo.y);
		}
				
		public function get BotSpawns():Array
		{
			return botspawns;
		}
		
		public function get HealthSpawns():Array
		{
			return healthspawns;
		}
		
		public function get AmmoSpawns():Array
		{
			return ammospawns;
		}
	}
}