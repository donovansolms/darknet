/*
	darknet
	IMY300 Minigame
	
	Donovan Solms
	25298853
	05 March 2008
	
	RocketLauncher.as
		RocketLauncher gun class
*/

package etcetera.guns
{
	import etcetera.interfaces.IGun;
	import etcetera.enums.Guns;
	import flash.display.MovieClip;
	import fl.motion.Color;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import etcetera.sound.SoundManager;
	import etcetera.enums.Sounds;
	
	public class RocketLauncher extends MovieClip implements IGun
	{
		include "../interfaces/IGunProperties.as"
		var _splashDamage:Number;
		
		var _timer:Timer;
		var _currentBullets:Number;
		var _soundPlaying:Boolean = false;
		var posX:Number;
		
		public function RocketLauncher()
		{
			_damage = -60;					//damage gun does
			_splashDamage = -30;		   //+if hit close to enemy
			_rateOfFire = 1; 				//bullets/second
			_accuracy = 5;					//accuracy
			_maxAmmo = 26;					//if 0, infinite
			_currentAmmo = 20;				//if 0, infinite
			_framesToTarget = 12;			//speed of bullet
			_type = Guns.ROCKETLAUNCHER;
			
			_timer = new Timer(1000);
			_timer.addEventListener(TimerEvent.TIMER, onSecond);
			_timer.start();
		}
		
		public function fire():Boolean
		{
			if ((_currentBullets < _rateOfFire) && (_currentAmmo > 0))
			{
				_currentBullets++;
				decreaseAmmo();
				gotoAndPlay(5);
				if (!_soundPlaying)
				{
					SoundManager.playSound(Sounds.ROCKETFIRE, 0);
					_soundPlaying = true;
				}
				return true;
			}
			else return false;
		}
		
		public function fireBot(xoff:Number):Boolean
		{
			if ((_currentBullets < _rateOfFire) && (_currentAmmo > 0))
			{
				_currentBullets++;
				decreaseAmmo();
				gotoAndPlay(5);
				if (xoff >= 0.5)
					posX = ((xoff*2) - 1);
				else if (xoff < 0.5)
					posX = ((xoff - 1) + xoff);
				if (!_soundPlaying)
				{
					SoundManager.playSound(Sounds.ROCKETFIRE, posX);
					_soundPlaying = true;
				}
				return true;
			}
			else return false;
		}
		
		public function decreaseAmmo()
		{
			_currentAmmo--;
		}
		
		public function increaseAmmo(value:int)
		{
			_currentAmmo += value;
			if (_currentAmmo > _maxAmmo)
				_currentAmmo = _maxAmmo;
		}
		
		public function get Ammo():Number
		{
			return _currentAmmo;
		}
		
		public function getGunType():String
		{
			return _type;
		}
		
		function onSecond(event:TimerEvent):void
		{
			//trace("bullets reset");
			_soundPlaying = false;
			_currentBullets = 0;
		}
		
	}
}