/*
	darknet
	IMY300 Minigame
	
	Donovan Solms
	25298853
	05 March 2008
	
	LevelManager.as
		Does all the level management
*/

package etcetera.levels
{
	import flash.display.Bitmap;
	import flash.net.URLRequest;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLLoader;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	import etcetera.enums.LevelState;
	import etcetera.game.LevelControl;
	import etcetera.game.GameControl;
	import etcetera.enums.GameState;
	import etcetera.levels.Level;
	import etcetera.levels.SpawnPoints;
	
	public class LevelManager
	{
		static var _currentLevel:Level;
		static var _isLoading:Boolean = false;
		static var _isLoaded:Boolean = false;
		static var loader:Loader;
		static var request:URLRequest;
		
		static var textloader:URLLoader;
		static var textrequest:URLRequest;
		static var _currentSpawns:SpawnPoints;
		
		//public static function LevelManager()
		//{
			
		//}
		
		public static function loadLevel():void
		{
			//load the bitmap
			if (LevelControl.State == LevelState.SANDBOX)
			{
				if (!_isLoading)
				{
					_isLoading = true;
					_currentSpawns = new SpawnPoints();
					textrequest = new URLRequest("content/levels/Sandbox.txt");
					textloader = new URLLoader();
					textloader.dataFormat = URLLoaderDataFormat.VARIABLES;
					textloader.load(textrequest);
					request = new URLRequest("content/levels/Sandbox.png");
					loader = new Loader();
					loader.load(request);
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded);
				}
			}
			if (LevelControl.State == LevelState.LEVELONE)
			{
				if (!_isLoading)
				{
					_isLoading = true;
					_currentSpawns = new SpawnPoints();
					textrequest = new URLRequest("content/levels/LevelOne.txt");
					textloader = new URLLoader();
					textloader.dataFormat = URLLoaderDataFormat.VARIABLES;
					textloader.load(textrequest);
					request = new URLRequest("content/levels/LevelOne.png");
					loader = new Loader();
					loader.load(request);
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded);
				}
			}
			if (LevelControl.State == LevelState.LEVELTWO)
			{
				if (!_isLoading)
				{
					_isLoading = true;
					_currentSpawns = new SpawnPoints();
					textrequest = new URLRequest("content/levels/LevelTwo.txt");
					textloader = new URLLoader();
					textloader.dataFormat = URLLoaderDataFormat.VARIABLES;
					textloader.load(textrequest);
					request = new URLRequest("content/levels/LevelTwo.png");
					loader = new Loader();
					loader.load(request);
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded);
				}
			}
			if (LevelControl.State == LevelState.LEVELTHREE)
			{
				if (!_isLoading)
				{
					_isLoading = true;
					_currentSpawns = new SpawnPoints();
					textrequest = new URLRequest("content/levels/LevelThree.txt");
					textloader = new URLLoader();
					textloader.dataFormat = URLLoaderDataFormat.VARIABLES;
					textloader.load(textrequest);
					request = new URLRequest("content/levels/LevelThree.png");
					loader = new Loader();
					loader.load(request);
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded);
				}
			}
		}
		
		public static function unloadLevel()
		{
			if (loader != null)
			{
				loader.unload();
				_currentLevel = null;
				_currentSpawns = null;
				_isLoaded = false;
			}
				
		}
		
		static function onLoaded(event:Event):void
		{
			//move to objectsbotsloaded
			GameControl.State = GameState.LOADED;
			var tempimg:Bitmap = new Bitmap();
			tempimg = loader.content as Bitmap;
			_currentLevel = new Level(tempimg);
			
			//load bots for sandbox
			if (LevelControl.State == LevelState.SANDBOX)
			{
				//get spawnpoints
				_currentSpawns.addBotSpawnPoint(textloader.data.SpawnBotX0,textloader.data.SpawnBotY0,textloader.data.BotName0,textloader.data.BotType0);
				//player spawn point
				//_currentSpawns.addBotSpawnPoint(textloader.data.SpawnBotX1,textloader.data.SpawnBotY1);
				_currentSpawns.addBotSpawnPoint(textloader.data.SpawnBotX2,textloader.data.SpawnBotY2,textloader.data.BotName2,textloader.data.BotType2);
				_currentSpawns.addBotSpawnPoint(textloader.data.SpawnBotX3,textloader.data.SpawnBotY3,textloader.data.BotName3,textloader.data.BotType3);
				_currentSpawns.addBotSpawnPoint(textloader.data.SpawnBotX4,textloader.data.SpawnBotY4,textloader.data.BotName4,textloader.data.BotType4);
				_currentSpawns.addBotSpawnPoint(textloader.data.SpawnBotX5,textloader.data.SpawnBotY5,textloader.data.BotName5,textloader.data.BotType5);
				
				_currentSpawns.addHealthSpawnPoint(textloader.data.SpawnHealthX0,textloader.data.SpawnHealthY0);
				
				_currentSpawns.addAmmoSpawnPoint(textloader.data.SpawnAmmoX0,textloader.data.SpawnAmmoY0);
				
			}
			
			if (LevelControl.State == LevelState.LEVELONE)
			{
				//get spawnpoints
				_currentSpawns.addBotSpawnPoint(textloader.data.SpawnBotX0,textloader.data.SpawnBotY0,textloader.data.BotName0,textloader.data.BotType0);
				_currentSpawns.addBotSpawnPoint(textloader.data.SpawnBotX1,textloader.data.SpawnBotY1,textloader.data.BotName1,textloader.data.BotType1);
				_currentSpawns.addBotSpawnPoint(textloader.data.SpawnBotX2,textloader.data.SpawnBotY2,textloader.data.BotName2,textloader.data.BotType2);
				_currentSpawns.addBotSpawnPoint(textloader.data.SpawnBotX3,textloader.data.SpawnBotY3,textloader.data.BotName3,textloader.data.BotType3);
				_currentSpawns.addBotSpawnPoint(textloader.data.SpawnBotX4,textloader.data.SpawnBotY4,textloader.data.BotName4,textloader.data.BotType4);
				_currentSpawns.addBotSpawnPoint(textloader.data.SpawnBotX5,textloader.data.SpawnBotY5,textloader.data.BotName5,textloader.data.BotType5);
				
				_currentSpawns.addHealthSpawnPoint(textloader.data.SpawnHealthX0,textloader.data.SpawnHealthY0);
				
				_currentSpawns.addAmmoSpawnPoint(textloader.data.SpawnAmmoX0,textloader.data.SpawnAmmoY0);
				
			}
			
			if (LevelControl.State == LevelState.LEVELTWO)
			{
				//get spawnpoints
				_currentSpawns.addBotSpawnPoint(textloader.data.SpawnBotX0,textloader.data.SpawnBotY0,textloader.data.BotName0,textloader.data.BotType0);
				_currentSpawns.addBotSpawnPoint(textloader.data.SpawnBotX1,textloader.data.SpawnBotY1,textloader.data.BotName1,textloader.data.BotType1);
				_currentSpawns.addBotSpawnPoint(textloader.data.SpawnBotX2,textloader.data.SpawnBotY2,textloader.data.BotName2,textloader.data.BotType2);
				_currentSpawns.addBotSpawnPoint(textloader.data.SpawnBotX3,textloader.data.SpawnBotY3,textloader.data.BotName3,textloader.data.BotType3);
				_currentSpawns.addBotSpawnPoint(textloader.data.SpawnBotX4,textloader.data.SpawnBotY4,textloader.data.BotName4,textloader.data.BotType4);
				_currentSpawns.addBotSpawnPoint(textloader.data.SpawnBotX5,textloader.data.SpawnBotY5,textloader.data.BotName5,textloader.data.BotType5);
				_currentSpawns.addBotSpawnPoint(textloader.data.SpawnBotX6,textloader.data.SpawnBotY6,textloader.data.BotName6,textloader.data.BotType6);
				
				_currentSpawns.addHealthSpawnPoint(textloader.data.SpawnHealthX0,textloader.data.SpawnHealthY0);
				_currentSpawns.addHealthSpawnPoint(textloader.data.SpawnHealthX1,textloader.data.SpawnHealthY1);
				_currentSpawns.addHealthSpawnPoint(textloader.data.SpawnHealthX2,textloader.data.SpawnHealthY2);
				
				_currentSpawns.addAmmoSpawnPoint(textloader.data.SpawnAmmoX0,textloader.data.SpawnAmmoY0);
				_currentSpawns.addAmmoSpawnPoint(textloader.data.SpawnAmmoX1,textloader.data.SpawnAmmoY1);
				
			}
			
			if (LevelControl.State == LevelState.LEVELTHREE)
			{
				//get spawnpoints
				_currentSpawns.addBotSpawnPoint(textloader.data.SpawnBotX0,textloader.data.SpawnBotY0,textloader.data.BotName0,textloader.data.BotType0);
				_currentSpawns.addBotSpawnPoint(textloader.data.SpawnBotX1,textloader.data.SpawnBotY1,textloader.data.BotName1,textloader.data.BotType1);
				_currentSpawns.addBotSpawnPoint(textloader.data.SpawnBotX2,textloader.data.SpawnBotY2,textloader.data.BotName2,textloader.data.BotType2);
				_currentSpawns.addBotSpawnPoint(textloader.data.SpawnBotX3,textloader.data.SpawnBotY3,textloader.data.BotName3,textloader.data.BotType3);
				_currentSpawns.addBotSpawnPoint(textloader.data.SpawnBotX4,textloader.data.SpawnBotY4,textloader.data.BotName4,textloader.data.BotType4);
				_currentSpawns.addBotSpawnPoint(textloader.data.SpawnBotX5,textloader.data.SpawnBotY5,textloader.data.BotName5,textloader.data.BotType5);
				_currentSpawns.addBotSpawnPoint(textloader.data.SpawnBotX6,textloader.data.SpawnBotY6,textloader.data.BotName6,textloader.data.BotType6);
				
				_currentSpawns.addHealthSpawnPoint(textloader.data.SpawnHealthX0,textloader.data.SpawnHealthY0);
				_currentSpawns.addHealthSpawnPoint(textloader.data.SpawnHealthX1,textloader.data.SpawnHealthY1);
				
				_currentSpawns.addAmmoSpawnPoint(textloader.data.SpawnAmmoX0,textloader.data.SpawnAmmoY0);
				_currentSpawns.addAmmoSpawnPoint(textloader.data.SpawnAmmoX1,textloader.data.SpawnAmmoY1);
				
			}
			
			
			_isLoading = false;
			_isLoaded = true;
		}
		
		public static function levelSetup():void
		{
			_currentLevel.x = 0;
			_currentLevel.y = -_currentLevel.height + 768;
		}
		
		public static function get currentLevel():Level
		{
			return _currentLevel;
		}
		
		public static function get loaded():Boolean
		{
			return _isLoaded;
		}
		
		public static function get currentSpawns():SpawnPoints
		{
			return _currentSpawns;
		}
	}
}