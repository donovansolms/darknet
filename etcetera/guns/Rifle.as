/*
	darknet
	IMY300 Minigame
	
	Donovan Solms
	25298853
	05 March 2008
	
	Rifle.as
		Rifle gun class
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
	
	public class Rifle extends MovieClip implements IGun
	{
		include "../interfaces/IGunProperties.as"
		var _headShotDamage:Number;
		
		var _timer:Timer;
		var _currentBullets:Number;
		var _soundPlaying:Boolean = false;
		var posX:Number;
		
		public function Rifle()
		{
			_damage = -30;						//damage gun does
			_headShotDamage = -100;			   //+headshot damage
			_rateOfFire = 1; 					//bullets/second
			_accuracy = 0;						//accuracy
			_maxAmmo = 15;						//if 0, infinite
			_currentAmmo = 10;					//if 0, infinite
			_framesToTarget = 7;				//speed of bullet
			_type = Guns.RIFLE;
			
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
					SoundManager.playSound(Sounds.RIFLEFIRE, 0);
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
					SoundManager.playSound(Sounds.RIFLEFIRE, posX);
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
		
		public function getGunType():String
		{
			return _type;
		}
		
		public function get Ammo():Number
		{

			return _currentAmmo;
		}
		
		function onSecond(event:TimerEvent):void
		{
			//trace("bullets reset");
			_soundPlaying = false;
			_currentBullets = 0;
		}
		
	}
}