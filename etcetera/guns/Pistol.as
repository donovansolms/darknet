/*
	darknet
	IMY300 Minigame
	
	Donovan Solms
	25298853
	05 March 2008
	
	Pistol.as
		Pistol gun class
*/

package etcetera.guns
{
	import etcetera.interfaces.IGun;
	import etcetera.enums.Guns;
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import etcetera.sound.SoundManager;
	import etcetera.enums.Sounds;
	
	public class Pistol extends MovieClip implements IGun
	{
		include "../interfaces/IGunProperties.as"
		
		var _timer:Timer;
		var _currentBullets:Number;
		var posX:Number;
		
		public function Pistol()
		{
			_damage = -7;			//damage gun does
			_rateOfFire = 5; 		//bullets/second
			_accuracy = 3;			//accuracy
			_maxAmmo = 200;			//if 0, infinite
			_currentAmmo = 200;		//if 0, infinite
			_framesToTarget = 5;	//speed of bullet
			_type = Guns.PISTOL;
			
			_currentBullets = 0;
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
				SoundManager.playSound(Sounds.PISTOLFIRE, 0);
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
				SoundManager.playSound(Sounds.PISTOLFIRE, posX);
				return true;
			}
			else return false;
		}
		
		public function decreaseAmmo()
		{
			//infinite ammo
		}
		
		public function increaseAmmo(value:int)
		{
			//infinite ammo
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
			_currentBullets = 0;
		}
		
	}
}