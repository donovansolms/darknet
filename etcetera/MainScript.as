/*
	darknet
	IMY300 Minigame
	
	Donovan Solms
	25298853
	05 March 2008
	
	MainScript.as
		Main script included in .fla
*/

import etcetera.characters.Character;
import etcetera.characters.BotManager;
import etcetera.characters.Bot;
import etcetera.levels.LevelManager;
import etcetera.enums.GameState;
import etcetera.game.GameControl;
import etcetera.game.Menu;
import etcetera.game.HUD;
import etcetera.animations.Loading;
import etcetera.game.LevelControl;
import etcetera.enums.LevelState;
import etcetera.enums.Bullets;
import etcetera.enums.AnimationStates;
import etcetera.interfaces.IGun;
import etcetera.interfaces.IBullet;
import etcetera.guns.BulletManager;
import etcetera.guns.GunManager;
import etcetera.guns.*;
import etcetera.enums.Guns;
import etcetera.helpers.VectorMath;
import etcetera.helpers.Vector;
import etcetera.enums.TutorialState;
import etcetera.game.TutorialControl;
import etcetera.sound.SoundManager;
import etcetera.enums.Sounds;

import fl.transitions.Tween;
import fl.transitions.TweenEvent;
import fl.transitions.easing.Regular;

addEventListener(Event.ENTER_FRAME, mainLoop);
stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
stage.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);

var player:Character;
var intro:IntroVideo;
var menu:Menu;
var hud:HUD;
var levelmanager:LevelManager;
var loading:Loading;
var _notSetup:Boolean = true;
var day:SkyBox_Day;
var view:Level2BG;
var view3:Level3BG;
var crosshair:Crosshair;
var headShot:HeadShot;
//var day:Level2BG;
var gunmanager:GunManager;
//var bulletmanager:BulletManager;
var gun:IGun = new Pistol();
var prevgun:IGun = new Pistol();
var botmanager:BotManager;
var ingamemenu:IngameMenu;
var deadmenu:DeadMenu;

var xMouse:Number;
var yMouse:Number;

//keystuff
var _isRight:Boolean = false;
var _isLeft:Boolean = false;
var _isFire:Boolean = false;

var characters:Array;

//for showing FPS
var oneSecondTimer:Timer;

var fps:Number = 0;

var tween:Tween;

var dialog:LevelDialog;
var gamedialog:GameDialog;
var onedialog:LevelOneDialog;

//tutorial stuff
var startTutorial:TutorialStart;
var uziTutorial:TutorialUzi;
var rifleTutorial:TutorialRifle;
var rocketTutorial:TutorialRocketLauncher;
var jumpTutorial:TutorialJump;
var sniperTutorial:TutorialSniper;
var guardTutorial:TutorialGuard;
var hunterTutorial:TutorialHunter;

function init():void
{
	//levelmanager = new LevelManager();
	loading = new Loading();	
	GameControl.State = GameState.INTRO;
	intro = new IntroVideo();
	ingamemenu = new IngameMenu();
	addChild(intro);
	//characters = new Array();
	//characters.push(player);
	//player.animationState = "None";
	
}

function mainLoop(event:Event):void
{
	//if intro state
	if (GameControl.State == GameState.MAINMENU)
	{
		
		if (LevelManager.loaded)
		{
			fps = 0;
			oneSecondTimer.reset();
			if (contains(LevelManager.currentLevel))
				removeChild(LevelManager.currentLevel);
			if (contains(player))
				removeChild(player);
			if (contains(hud))
				removeChild(hud);
			if (day != null)
				if (contains(day))
					removeChild(day);
			if (view != null)
				if (contains(view))
					removeChild(view);
			if (view3 != null)
				if (contains(view3))
					removeChild(view3);
			if (contains(crosshair))
				removeChild(crosshair);
			if (dialog != null)
				if (contains(dialog))
					removeChild(dialog);
			if (gamedialog != null)
				if (contains(gamedialog))
					removeChild(gamedialog);
			if (onedialog != null)
				if (contains(onedialog))
					removeChild(onedialog);
			if (contains(botmanager))
				removeChild(botmanager);
				
			if (deadmenu != null)
				if (contains(deadmenu))
					removeChild(deadmenu);
			if (headShot != null)
				if (contains(headShot))
					removeChild(headShot);
			gunmanager = null;
			botmanager = null;
			//bullet
			hud = null;
			player = null;
			LevelManager.unloadLevel();
			_notSetup = true;
		}
		
		if (contains(ingamemenu))
			removeChild(ingamemenu);
			
		if (contains(intro))
			removeChild(intro);
		if (menu != null)
		{
			
			if (!contains(menu))
			{
				SoundManager.ambientSound(Sounds.MENU);
				addChild(menu);
			}
		}
		else 
		{
			SoundManager.ambientSound(Sounds.MENU);
			menu = new Menu();
			addChild(menu);
		}
	}
	if (GameControl.State == GameState.RETRY)
	{

		if (LevelManager.loaded)
		{
			fps = 0;
			oneSecondTimer.reset();
			if (contains(LevelManager.currentLevel))
				removeChild(LevelManager.currentLevel);
			if (contains(player))
				removeChild(player);
			if (contains(hud))
				removeChild(hud);
			if (day != null)
				if (contains(day))
					removeChild(day);
			if (view != null)
				if (contains(view))
					removeChild(view);
			if (view3 != null)
				if (contains(view3))
					removeChild(view3);
			if (contains(crosshair))
				removeChild(crosshair);
			if (contains(botmanager))
				removeChild(botmanager);
			if (dialog != null)
				if (contains(dialog))
					removeChild(dialog);
			if (gamedialog != null)
				if (contains(gamedialog))
					removeChild(gamedialog);
			if (deadmenu != null)
				if (contains(deadmenu))
					removeChild(deadmenu);
			if (onedialog != null)
				if (contains(onedialog))
					removeChild(onedialog);
			gunmanager = null;
			botmanager = null;
			//bullet
			hud = null;
			player = null;
			LevelManager.unloadLevel();
			_notSetup = true;
		}
		GameControl.State = GameState.LOADLEVEL;
	}
	
	if (GameControl.State == GameState.LOADLEVEL)
	{
		hitText.text = "";
		if (contains(menu))
			removeChild(menu);
			
		
		if (!contains(loading))
		{
			loading.x = 490;
			loading.y = 300;
			loading.loadText.text = "Loading " + LevelControl.State + "...";
			addChild(loading);
			
		}
		LevelManager.loadLevel();
	}
	if (GameControl.State == GameState.LOADED)
	{
		loading.loadText.text = "Done. Click to continue.";
	}
	if (GameControl.State == GameState.PLAYING)
	{
		
		if (contains(ingamemenu))
		{
			removeChild(ingamemenu)
			Mouse.hide();
		}
		if (contains(loading))
			removeChild(loading);
		
		
		if (_notSetup)
		{
			gunmanager = new GunManager();
			player = new Character(gunmanager);
			player.animationState = AnimationStates.NONE;
			LevelManager.levelSetup();
			botmanager = new BotManager();
			gun = gunmanager.currentGun();
			hud = new HUD();
						
			if (LevelControl.State == LevelState.SANDBOX)
			{
				day = new SkyBox_Day();
				addChild(day);
				SoundManager.ambientSound(Sounds.SANDBOX);
				player.PlayerColor = 0x000000;
				TutorialControl.State = TutorialState.START;
			}
			if (LevelControl.State == LevelState.LEVELONE)
			{
				//day = new SkyBox_Day();
				SoundManager.ambientSound(Sounds.LEVELONE);
				day = new SkyBox_Day();
				player.PlayerColor = 0x000000;
				addChild(day);
			}
			
			if (LevelControl.State == LevelState.LEVELTWO)
			{
				//day = new SkyBox_Day();
				SoundManager.ambientSound(Sounds.LEVELTWO);
				view = new Level2BG();
				player.PlayerColor = 0x000000;
				addChild(view);
			}
			
			if (LevelControl.State == LevelState.LEVELTHREE)
			{
				//day = new SkyBox_Day();
				SoundManager.ambientSound(Sounds.LEVELTHREE);
				view3 = new Level3BG();
				player.PlayerColor = 0xBBBBBB;
				addChild(view3);
			}
			
			player.x = 300;
			player.y = 200;
			crosshair = new Crosshair();
			crosshair.x = xMouse;
			crosshair.y = yMouse;
			
			Mouse.hide();

			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);		
			

			botmanager.addBotsAndObjects(LevelManager.currentSpawns);
			botmanager.addHealthPacks(LevelManager.currentSpawns);
			botmanager.addAmmoPacks(LevelManager.currentSpawns);
			
			botmanager.x = LevelManager.currentLevel.x;
			botmanager.y = LevelManager.currentLevel.y;
			
			
			oneSecondTimer = new Timer(1000);
			oneSecondTimer.addEventListener(TimerEvent.TIMER,time);
			oneSecondTimer.start();
			//if (LevelControl.State == LevelState.SANDBOX)
			//	addChild(fpsText);

			addChild(LevelManager.currentLevel);
			addChild(player);
			addChild(botmanager);
			addChild(hud);
			addChild(crosshair);
			addChild(hitText);
			
			_notSetup = false;
			
			
		}		
		if (player.health <= 0)
		{
			player.Die();
			GameControl.State = GameState.DEAD;
		}
		//do when not dead
		if (!player.isDead)
		{
			if(player.x < 450)
			{
				LevelManager.currentLevel.x += 10;
				if (LevelManager.currentLevel.x > 0)
				{
					LevelManager.currentLevel.x -= 10;
				}
				else player.x += 5;
			}
			if(player.x > 580)
			{
				LevelManager.currentLevel.x -= 10;
				if (LevelManager.currentLevel.x < (-LevelManager.currentLevel.width + 1024))
				{
					LevelManager.currentLevel.x += 10;
				}
				else player.x -= 5;
			}
			if (player.y < 500)
			{
				LevelManager.currentLevel.y += 6;
				//botmanager.moveBots(0,6);
				if (LevelManager.currentLevel.y > 0)
				{
					LevelManager.currentLevel.y -= 6;
					//botmanager.moveBots(0,-6);
				}
				else player.y += 5;
			}
			if (player.y > 550)
			{
				LevelManager.currentLevel.y -= 12;
				//botmanager.moveBots(0,-12);
				if (LevelManager.currentLevel.y < -(LevelManager.currentLevel.height - 768))
				{
					LevelManager.currentLevel.y += 12;
					//botmanager.y += 12;//(0,12);
				}
				else player.y -= 10;
			}
		//if character is dead, follow his head
		
			if (_isRight)
			{
				player.vel.x = 5
			}
			else if (_isLeft)
				player.vel.x = -5;
		}
		//load current gun
		gun = gunmanager.currentGun();
		if (gun.getGunType() == Guns.PISTOL)
		{
			//Pistol(gun).gotoAndStop(0);
			Pistol(gun).x = player.neckJoint.x;
			Pistol(gun).y = player.neckJoint.y;
			player.addChild(Pistol(gun));
			hud.setGun(Guns.PISTOL);
			prevgun = gunmanager.prevGun();
			if (prevgun != null)
			{
				if ((prevgun.getGunType() == Guns.UZI) && (player.contains(Uzi(prevgun))))
					player.removeChild(Uzi(prevgun));
				else if ((prevgun.getGunType() == Guns.RIFLE) && (player.contains(Rifle(prevgun))))
					player.removeChild(Rifle(prevgun));
				else if ((prevgun.getGunType() == Guns.ROCKETLAUNCHER) && (player.contains(RocketLauncher(prevgun))))
					player.removeChild(RocketLauncher(prevgun));
			}
		}
		if (gun.getGunType() == Guns.UZI)
		{
			//Pistol(gun).gotoAndStop(0);
			Uzi(gun).x = player.neckJoint.x;
			Uzi(gun).y = player.neckJoint.y;
			player.addChild(Uzi(gun));
			hud.setGun(Guns.UZI);
			prevgun = gunmanager.prevGun();
			if (prevgun != null)
			{
				if ((prevgun.getGunType() == Guns.PISTOL) && (player.contains(Pistol(prevgun))))
					player.removeChild(Pistol(prevgun));
				else if ((prevgun.getGunType() == Guns.RIFLE) && (player.contains(Rifle(prevgun))))
					player.removeChild(Rifle(prevgun));
				else if ((prevgun.getGunType() == Guns.ROCKETLAUNCHER) && (player.contains(RocketLauncher(prevgun))))
					player.removeChild(RocketLauncher(prevgun));
			}
		}
		if (gun.getGunType() == Guns.RIFLE)
		{
			//Pistol(gun).gotoAndStop(0);
			Rifle(gun).x = player.neckJoint.x;
			Rifle(gun).y = player.neckJoint.y;
			player.addChild(Rifle(gun));
			hud.setGun(Guns.RIFLE);
			prevgun = gunmanager.prevGun();
			if (prevgun != null)
			{
				if ((prevgun.getGunType() == Guns.PISTOL) && (player.contains(Pistol(prevgun))))
					player.removeChild(Pistol(prevgun));
				else if ((prevgun.getGunType() == Guns.UZI) && (player.contains(Uzi(prevgun))))
					player.removeChild(Uzi(prevgun));
				else if ((prevgun.getGunType() == Guns.ROCKETLAUNCHER) && (player.contains(RocketLauncher(prevgun))))
					player.removeChild(RocketLauncher(prevgun));
			}
		}
		if (gun.getGunType() == Guns.ROCKETLAUNCHER)
		{
			//Pistol(gun).gotoAndStop(0);
			RocketLauncher(gun).x = player.neckJoint.x;
			RocketLauncher(gun).y = player.neckJoint.y;
			player.addChild(RocketLauncher(gun));
			hud.setGun(Guns.ROCKETLAUNCHER);
			prevgun = gunmanager.prevGun();
			if (prevgun != null)
			{
				if ((prevgun.getGunType() == Guns.PISTOL) && (player.contains(Pistol(prevgun))))
					player.removeChild(Pistol(prevgun));
				else if ((prevgun.getGunType() == Guns.UZI) && (player.contains(Uzi(prevgun))))
					player.removeChild(Uzi(prevgun));
				else if ((prevgun.getGunType() == Guns.RIFLE) && (player.contains(Rifle(prevgun))))
					player.removeChild(Rifle(prevgun));
			}
		}
		hud.updateHealth(player.health);
		aimGun();
		
		if (_isFire && (gun.getGunType() != Guns.PISTOL))
		{
			//do bulletadd here
			//UZI //not firing!!!!!
			if (gun.getGunType() == Guns.UZI)
			{
				if (gun.fire())
				{
					Uzi(gun).nozzle.rotation = Uzi(gun).rotation;
					//make uzibullet class
					var bullet:IBullet = new PistolBullet();
					bullet.BulletType = Bullets.UZI;
					bullet.X = player.x + Uzi(gun).x;
					bullet.Y = player.y + Uzi(gun).y;
								
					if (!player.facingRight)
					{
						bullet.Angle = Uzi(gun).rotation - 90;
					}
					else bullet.Angle = Uzi(gun).rotation;
		
					//bots kan eie enter frame he
					var xDis:Number = player.x - xMouse;
					var yDis:Number = player.y - yMouse;
					bullet.From = player.Name;
					BulletManager.addBullet(bullet,xDis,yDis-25);
					addChild(PistolBullet(bullet));
				}
			}//end uzi
			if (gun.getGunType() == Guns.RIFLE)
			{
				if (gun.fire())
				{
					Rifle(gun).nozzle.rotation = Rifle(gun).rotation;
					//make uzibullet class
					var bullet:IBullet = new PistolBullet();
					bullet.BulletType = Bullets.RIFLE;
					bullet.X = player.x + Rifle(gun).x;
					bullet.Y = player.y + Rifle(gun).y;
								
					if (!player.facingRight)
					{
						bullet.Angle = Rifle(gun).rotation - 90;
					}
					else bullet.Angle = Rifle(gun).rotation;
		
					//bots kan eie enter frame he
					var xDis:Number = player.x - xMouse;
					var yDis:Number = player.y - yMouse;
					bullet.From = player.Name;
					BulletManager.addBullet(bullet,xDis,yDis-25);
					addChild(PistolBullet(bullet));
				}
			}//end rifle
			if (gun.getGunType() == Guns.ROCKETLAUNCHER)
			{
				if (gun.fire())
				{
					RocketLauncher(gun).nozzle.rotation = RocketLauncher(gun).rotation;
					//make uzibullet class
					var bullet:IBullet = new Rocket();
					bullet.BulletType = Bullets.ROCKET;
					bullet.X = player.x + RocketLauncher(gun).x;
					bullet.Y = player.y + RocketLauncher(gun).y;
					if (!player.facingRight)
					{
						bullet.Angle = RocketLauncher(gun).rotation - 90;
					}
					else bullet.Angle = RocketLauncher(gun).rotation;
		
					//bots kan eie enter frame he
					var xDis:Number = player.x - xMouse;
					var yDis:Number = player.y - yMouse;
					bullet.From = player.Name;
					BulletManager.addBullet(bullet,xDis,yDis-25);
					addChild(Rocket(bullet));
				}
			}//end rifle
						
		}
		else if (_isFire)
		{
			//do bulletaddpistol here
			//SoundManager.playSound(Sounds.PISTOLFIRE, 0);
			Pistol(gun).nozzle.rotation = Pistol(gun).rotation;
			var bullet:IBullet = new PistolBullet();
			bullet.X =  player.x + Pistol(gun).x;
			bullet.Y =  player.y + Pistol(gun).y;
						
			if (!player.facingRight)
			{
				bullet.Angle = Pistol(gun).rotation - 90;
			}
			else bullet.Angle = Pistol(gun).rotation;

			//bots kan eie enter frame he
			var xDis:Number = player.x - xMouse;
			var yDis:Number = player.y - yMouse;
			bullet.From = player.Name;
			BulletManager.addBullet(bullet,xDis,yDis-25);
			addChild(PistolBullet(bullet));
			gun.fire();

			_isFire = false;
		}
		hud.updateAmmo(gun.Ammo);
		if (BulletManager.bullets.length != 0)
				BulletManager.bullets.forEach(function(current:*)
				{
					if (current.Hit && contains(current))
					{
						removeChild(current);
					}
					if (!current.Hit && !contains(current))
					{
						addChild(current);
					}
				});
				
		//increase the framecound for this second
		fps++;
		
		if (LevelControl.State == LevelState.SANDBOX)
			doTutorialStuff();
		else TutorialControl.State = TutorialState.DONE;
		
		BulletManager.updateArray();
		BulletManager.updateBullets(player,botmanager.Bots,LevelManager.currentLevel);
		
		//update bot positions
		botmanager.y = LevelManager.currentLevel.y;
		botmanager.x = LevelManager.currentLevel.x;
		botmanager.updateBots(player,LevelManager.currentLevel);
		
		//HUD.updateSelectedGun(player.gun);
		player.Animate();
		player.doGravity(LevelManager.currentLevel);
		player.reDraw();	
		
		crosshair.x = xMouse;
		crosshair.y = yMouse;
		
		if(!botmanager.anyBotsAlive())
		{
			GameControl.State = GameState.LEVELCOMPLETE;
			if (LevelControl.State == LevelState.SANDBOX)
			{
				//display tutorial complete here
			}
		}
		
		if (BulletManager.headShot)
		{
			SoundManager.playSound(Sounds.HEADSHOT, 0);
			hitText.text = BulletManager.hitText;
			headShot = new HeadShot();
			headShot.x = 1024/2;
			headShot.y = 150;
			addChild(headShot);
			tween = new Tween(headShot,"alpha",Regular.easeOut,100,0,100);
			tween.addEventListener(TweenEvent.MOTION_FINISH, headTween);
			tween.start();
			BulletManager.headShot = false;
		}
	}
	if (GameControl.State == GameState.DEAD)
	{
		if (headShot != null)
		{
			if (contains(headShot))
			{
				tween = new Tween(headShot,"alpha",Regular.easeOut,100,0,100);
				tween.addEventListener(TweenEvent.MOTION_FINISH, headTween);
				tween.start();
				BulletManager.headShot = false;
			}
		}
		
		Mouse.show();
		if (deadmenu == null)
			deadmenu = new DeadMenu();
			
		if (!contains(deadmenu))
		{
			Mouse.show();
			//deadmenu = new DeadMenu();
			deadmenu.x = 1024/2;
			deadmenu.y = 768/2;
			addChild(deadmenu);
		}
		if (BulletManager.bullets.length != 0)
				BulletManager.bullets.forEach(function(current:*)
				{
					if (contains(current))
					{
						removeChild(current);
					}
				});
		if ((gun.getGunType() == Guns.PISTOL) && (player.contains(Pistol(gun))))
			player.removeChild(Pistol(gun));
		else if ((gun.getGunType() == Guns.UZI) && (player.contains(Uzi(gun))))
			player.removeChild(Uzi(gun));
		else if ((gun.getGunType() == Guns.RIFLE) && (player.contains(Rifle(gun))))
			player.removeChild(Rifle(gun));
		else if ((gun.getGunType() == Guns.ROCKETLAUNCHER) && (player.contains(RocketLauncher(gun))))
			player.removeChild(RocketLauncher(gun));
		
		if ((player.y + player.headJoint.y) > 500)
		{
			LevelManager.currentLevel.y -= 12;
			if (LevelManager.currentLevel.y < -(LevelManager.currentLevel.height - 768))
			{
				LevelManager.currentLevel.y += 12;
			}
			else player.headJoint.y -= 12;
		}
		if((player.x + player.headJoint.x) < 250)
		{
			LevelManager.currentLevel.x += 5;
			if (LevelManager.currentLevel.x > 0)
			{
				LevelManager.currentLevel.x -= 5;
			}
			else player.headJoint.x += 5;
		}
		if((player.x + player.headJoint.x) > 780)
		{
			LevelManager.currentLevel.x -= 5;
			if (LevelManager.currentLevel.x < (-LevelManager.currentLevel.width + 1024))
			{
				LevelManager.currentLevel.x += 5;
			}
			else player.headJoint.x -= 5;
		}
		botmanager.y = LevelManager.currentLevel.y;
		botmanager.x = LevelManager.currentLevel.x;
		player.doGravity(LevelManager.currentLevel);
		player.reDraw();
	}
	
	if (GameControl.State == GameState.INGAMEMENU)
	{
		if (!contains(ingamemenu))
		{
			Mouse.show();
			ingamemenu = new IngameMenu();
			ingamemenu.x = 1024/2;
			ingamemenu.y = 768/2;
			addChild(ingamemenu);
		}
	}
	
	if (GameControl.State == GameState.LEVELCOMPLETE)
	{
		//bring up next level button
		if (LevelControl.State == LevelState.LEVELTWO)
		{
			Mouse.show();
			_notSetup = true;
			//bring up dialogbox
			if (dialog == null)
				dialog = new LevelDialog();
			dialog.x = 1024/2;
			dialog.y = 768/2;
			if (!contains(dialog))
				addChild(dialog);	
			LevelControl.State = LevelState.LEVELTHREE;
			GameControl.State = GameState.PAUSE;

		}
		else if (LevelControl.State == LevelState.LEVELTHREE)
		{
			Mouse.show();
			//bring up dialogbox
			gamedialog = new GameDialog();
			gamedialog.x = 1024/2;
			gamedialog.y = 768/2;
			addChild(gamedialog);
			GameControl.State = GameState.GAMECOMPLETE;
			GameControl.State = GameState.PAUSE;
		}
		else if (LevelControl.State == LevelState.LEVELONE)
		{
			Mouse.show();
			
			_notSetup = true;
			//bring up dialogbox
			if (onedialog == null)
				onedialog = new LevelOneDialog();
			onedialog.x = 1024/2;
			onedialog.y = 768/2;
			if (!contains(onedialog))
				addChild(onedialog);	
			LevelControl.State = LevelState.LEVELTWO;
			GameControl.State = GameState.PAUSE;
		}			
	}
	
	if (GameControl.State == GameState.PAUSE)
	{
		if (LevelControl.State == LevelState.SANDBOX)
			doTutorialStuff();
	}
}

function headTween(event:TweenEvent)
{
	if (contains(headShot))
		removeChild(headShot);
	hitText.text = "";
	BulletManager.headShot = false;
	tween.stop();
	tween.rewind();
}

function mouseDown(event:MouseEvent):void
{
	if (GameControl.State == GameState.LOADED)
	{
		GameControl.State = GameState.PLAYING;
	}
	if (GameControl.State == GameState.PLAYING)
	{
		_isFire = true;
	}
} 

function mouseUp(event:MouseEvent):void
{
	if (GameControl.State == GameState.PLAYING)
	{
		_isFire = false;
	}
}

function mouseMove(event:MouseEvent):void
{			
	xMouse = event.stageX;
	yMouse = event.stageY;
}

function mouseWheel(event:MouseEvent):void
{
	//next weapon
	if (GameControl.State == GameState.PLAYING)
	{
		if (event.delta > 0)
		{
			gunmanager.nextGun();
			gun = gunmanager.currentGun();
			hud.setGun(gun.getGunType());
		}
		//previous weapon
		if (event.delta < 0)
		{
			gunmanager.previousGun();
			gun = gunmanager.currentGun();
			hud.setGun(gun.getGunType());
		}
	}
}

//get new fps
function time(event:TimerEvent):void
{
	//fpsText.text = "fps: " + fps;
	fps = 0;
}

//process key press event
function keyDownHandler(event:KeyboardEvent):void
{
	if(event.keyCode == Keyboard.CONTROL)
	{
		if (!player.facingRight)
			player.scaleX *= -1;
		player.Die();
		GameControl.State = GameState.DEAD;
	}
	if((event.keyCode == Keyboard.SPACE) || (event.keyCode == 87))
		player.Jump();
	if((event.keyCode == Keyboard.RIGHT) || (event.keyCode == 68))
	{
		if (player.animationState == "None")
			player.animationState = "Start";
		if(!player.facingRight && !player.isDead)
			player.scaleX *= -1;
		_isRight = true;
		player.facingRight = true;	
	}
	if((event.keyCode == Keyboard.LEFT) || (event.keyCode == 65))
	{
		if (player.animationState == "None")
			player.animationState = "Start";
		if(player.facingRight && !player.isDead)
			player.scaleX *= -1;
		_isLeft = true;
		player.facingRight = false;
	}
	
	if((event.keyCode == 192))
	{
		GameControl.State = GameState.INGAMEMENU;
	}
}

//process key up event
function keyUpHandler(event:KeyboardEvent):void
{
	if(event.keyCode == Keyboard.CONTROL)
		player.Die();
	if((event.keyCode == Keyboard.SPACE) || (event.keyCode == 87))
		player.Jump();
	if((event.keyCode == Keyboard.RIGHT) || (event.keyCode == 68))
	{
		player.vel.x = 0;
		player.animationState = "None";
		_isRight = false;
	}
	if((event.keyCode == Keyboard.LEFT) || (event.keyCode == 65))
	{
		player.animationState = "None";
		player.vel.x = 0;
		_isLeft = false;
	}
}

function aimGun():void
{
	var xDis:Number = player.x - xMouse;
	var yDis:Number = player.y - yMouse;
			
	var vec:Vector = new Vector();
	vec.vx = xDis;
	vec.vy = yDis;
	var angle:Number = VectorMath.getAngleDegrees(vec);
	
	if (player.facingRight)
	{
		if (gun.getGunType() == Guns.PISTOL)
			Pistol(gun).rotation = angle + 180;
		else if (gun.getGunType() == Guns.UZI)
			Uzi(gun).rotation = angle + 180;
		else if (gun.getGunType() == Guns.RIFLE)
			Rifle(gun).rotation = angle + 180;
		else if (gun.getGunType() == Guns.ROCKETLAUNCHER)
			RocketLauncher(gun).rotation = angle + 180;
	}
	else 
	{
		if (gun.getGunType() == Guns.PISTOL)
			Pistol(gun).rotation = -angle;
		else if (gun.getGunType() == Guns.UZI)
			Uzi(gun).rotation = -angle;
		else if (gun.getGunType() == Guns.RIFLE)
			Rifle(gun).rotation = -angle;
		else if (gun.getGunType() == Guns.ROCKETLAUNCHER)
			RocketLauncher(gun).rotation = -angle;
	}
}

function doTutorialStuff():void
{
	
	if(TutorialControl.State == TutorialState.CONTINUE)
	{
		//remove all tutorial stuff from stage
		stage.focus = stage;
		Mouse.hide();
		if (startTutorial != null)
			if (contains(startTutorial))
				removeChild(startTutorial);
		if (uziTutorial != null)
			if (contains(uziTutorial))
				removeChild(uziTutorial);
		if (rifleTutorial != null)
			if (contains(rifleTutorial))
				removeChild(rifleTutorial);
		if (rocketTutorial != null)
			if (contains(rocketTutorial))
				removeChild(rocketTutorial);
		if (jumpTutorial != null)
			if (contains(jumpTutorial))
				removeChild(jumpTutorial);	
		if (sniperTutorial != null)
			if (contains(sniperTutorial))
				removeChild(sniperTutorial);	
		if (guardTutorial != null)
			if (contains(guardTutorial))
				removeChild(guardTutorial);	
		if (hunterTutorial != null)
			if (contains(hunterTutorial))
				removeChild(hunterTutorial);	
	}
	if(TutorialControl.State == TutorialState.START)
	{
		//add welcome
		Mouse.show();
		if (startTutorial == null)
			startTutorial = new TutorialStart();
		if (!contains(startTutorial))
		{									
			startTutorial.x = 1024/2;
			startTutorial.y = 768/2;
			addChild(startTutorial);
		}
		//GameControl.State = GameState.PLAYING;
	}
	if(TutorialControl.State == TutorialState.UZI)
	{
		Mouse.show();
		if (uziTutorial == null)
			uziTutorial = new TutorialUzi();
		if (!contains(uziTutorial))
		{									
			uziTutorial.x = 1024/2;
			uziTutorial.y = 768/2;
			addChild(uziTutorial);
		}
	}
	if(TutorialControl.State == TutorialState.RIFLE)
	{
		Mouse.show();
		if (rifleTutorial == null)
			rifleTutorial = new TutorialRifle();
		if (!contains(rifleTutorial))
		{									
			rifleTutorial.x = 1024/2;
			rifleTutorial.y = 768/2;
			addChild(rifleTutorial);
		}
	}
	if(TutorialControl.State == TutorialState.ROCKETLAUNCHER)
	{
		Mouse.show();
		if (rocketTutorial == null)
			rocketTutorial = new TutorialRocketLauncher();
		if (!contains(rocketTutorial))
		{									
			rocketTutorial.x = 1024/2;
			rocketTutorial.y = 768/2;
			addChild(rocketTutorial);
		}
	}
	if(TutorialControl.State == TutorialState.GUARD)
	{
		Mouse.show();
		if (guardTutorial == null)
			guardTutorial = new TutorialGuard();
		if (!contains(guardTutorial))
		{									
			guardTutorial.x = 1024/2;
			guardTutorial.y = 768/2;
			addChild(guardTutorial);
		}
	}
	if(TutorialControl.State == TutorialState.SNIPER)
	{
		Mouse.show();
		if (sniperTutorial == null)
			sniperTutorial = new TutorialSniper();
		if (!contains(sniperTutorial))
		{									
			sniperTutorial.x = 1024/2;
			sniperTutorial.y = 768/2;
			addChild(sniperTutorial);
		}
		
	}
	if(TutorialControl.State == TutorialState.HUNTER)
	{
		Mouse.show();
		if (hunterTutorial == null)
			hunterTutorial = new TutorialHunter();
		if (!contains(hunterTutorial))
		{									
			hunterTutorial.x = 1024/2;
			hunterTutorial.y = 768/2;
			addChild(hunterTutorial);
		}
	}
	if(TutorialControl.State == TutorialState.JUMPING)
	{
		Mouse.show();
		if (jumpTutorial == null)
			jumpTutorial = new TutorialJump();
		if (!contains(jumpTutorial))
		{									
			jumpTutorial.x = 1024/2;
			jumpTutorial.y = 768/2;
			addChild(jumpTutorial);
		}
	}
}