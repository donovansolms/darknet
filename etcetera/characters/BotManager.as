/*
	darknet
	IMY300 Minigame
	
	Donovan Solms
	25298853
	05 March 2008
	
	BotManager.as
		Does all the bot management
*/

package etcetera.characters
{
	import etcetera.enums.BotState;
	import etcetera.game.GameControl;
	import etcetera.enums.GameState;
	import etcetera.levels.Level;
	import etcetera.levels.LevelManager;
	import etcetera.game.LevelControl;
	import etcetera.enums.LevelState;
	import etcetera.levels.SpawnPoints;
	import etcetera.enums.AnimationStates;
	import etcetera.enums.Guns;
	import etcetera.enums.BotType;
	import etcetera.guns.BulletManager;
	import etcetera.game.AmmoPack;
	import etcetera.game.HealthPack;
	
	import flash.display.MovieClip;
    import flash.display.Shape;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.events.Event;
	
	public class BotManager extends MovieClip
	{
		var bots:Array;
		var ammo:Array;
		var health:Array;
		var loader:Loader;
		var request:URLRequest;
		public var circle:Shape = new Shape( ); 
		var anyAlive:Boolean = false;
				
		public function BotManager()
		{
			bots = new Array();
			ammo = new Array();
			health = new Array();
		}
		
		public function addBotsAndObjects(spawnpoints:SpawnPoints):void
		{
			
			trace("Add sandbox bots");
			for (var i:int = 0; i < spawnpoints.BotSpawns.length; i++)
			{
				var bot:Bot = new Bot(spawnpoints.BotSpawns[i].name);
				bot.setPos(spawnpoints.BotSpawns[i].x,spawnpoints.BotSpawns[i].y);
				if (spawnpoints.BotSpawns[i].type == "GuardUzi")
					bot.giveType(BotType.GUARD_UZI);
				if (spawnpoints.BotSpawns[i].type == "GuardPistol")
					bot.giveType(BotType.GUARD_PISTOL);
				if (spawnpoints.BotSpawns[i].type == "Sniper")
					bot.giveType(BotType.SNIPER);
				if (spawnpoints.BotSpawns[i].type == "HunterUzi")
					bot.giveType(BotType.HUNTER_UZI);
				if (spawnpoints.BotSpawns[i].type == "HunterSniper")
					bot.giveType(BotType.HUNTER_SNIPER);
				if (spawnpoints.BotSpawns[i].type == "HunterRocket")
					bot.giveType(BotType.HUNTER_ROCKET);
				trace("added " + spawnpoints.BotSpawns[i].name);
				addBot(bot);
			}
				
			if (LevelControl.State == LevelState.SANDBOX)
			{
				request = new URLRequest("content/levels/Sandbox_Objects.png");
				loader = new Loader();
				loader.load(request);
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded);
			}
			
			if (LevelControl.State == LevelState.LEVELONE)
			{
				request = new URLRequest("content/levels/LevelOne_Objects.png");
				loader = new Loader();
				loader.load(request);
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded);
			}
			
			if (LevelControl.State == LevelState.LEVELTWO)
			{
				request = new URLRequest("content/levels/LevelTwo_Objects.png");
				loader = new Loader();
				loader.load(request);
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded);
			}
			
			if (LevelControl.State == LevelState.LEVELTWO)
			{
				request = new URLRequest("content/levels/LevelThree_Objects.png");
				loader = new Loader();
				loader.load(request);
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded);
			}
		}
		
		public function addHealthPacks(spawnpoints:SpawnPoints):void
		{
			for (var i:int = 0; i < spawnpoints.HealthSpawns.length; i++)
				{
					var health:HealthPack = new HealthPack();
					health.setPos(spawnpoints.HealthSpawns[i].x,spawnpoints.HealthSpawns[i].y);
					addHealth(health);
				}
		}
		
		public function addAmmoPacks(spawnpoints:SpawnPoints):void
		{
			for (var i:int = 0; i < spawnpoints.AmmoSpawns.length; i++)
			{
				var ammo:AmmoPack = new AmmoPack();
				ammo.setPos(spawnpoints.AmmoSpawns[i].x,spawnpoints.AmmoSpawns[i].y);
				addAmmo(ammo);
			}
		}
		
		public function addBot(value:Bot)
		{
			value.animationState = AnimationStates.START;
			bots.push(value);
			addChild(value);
		}
		
		public function removeBot(value:Bot)
		{
			if (contains(value))
				removeChild(value);
		}
		
		public function addHealth(value:HealthPack)
		{
			health.push(value);
			addChild(value);
		}
		
		public function removeHealth(value:HealthPack)
		{
			if (contains(value))
			{
				value.x = 5000;
				removeChild(value);
			}
		}
		
		public function addAmmo(value:AmmoPack)
		{
			ammo.push(value);
			addChild(value);
		}
		
		public function removeAmmo(value:AmmoPack)
		{
			if (contains(value))
			{
				value.x = 5000;
				removeChild(value);
			}
		}
		
		
		
		public static function killBot(value:Bot)
		{
			value.Die();
		}
		
		public function updateBots(character:Character,level:Level)
		{
			for (var i:int = 0; i < bots.length; i++)
			{
				bots[i].goLive(character,level);			
			}
			for (var i:int = 0; i < ammo.length; i++)
			{
				ammo[i].doAll(character,level);		
				if (ammo[i].Used)
					removeAmmo(ammo[i]);
			}
			for (var i:int = 0; i < health.length; i++)
			{
				health[i].doAll(character,level);		
				if(health[i].Used)
					removeHealth(health[i]);
			}
		}
		
		public function get Bots():Array
		{
			return bots;
		}
		
		function onLoaded(event:Event):void
		{
			addChild(loader);
		}
		
		public function anyBotsAlive():Boolean
		{
			anyAlive = false;
			for (var i:int = 0; i < bots.length; i++)
			{
				if (!(bots[i].isDead))
					anyAlive = true;
			}
			return anyAlive;
		}
	}
}