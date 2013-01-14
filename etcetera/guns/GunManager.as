/*
	darknet
	IMY300 Minigame
	
	Donovan Solms
	25298853
	07 March 2008
	
	GunManager.as
		Does all the gun management
*/

package etcetera.guns
{
	import etcetera.enums.Guns;
	import etcetera.interfaces.IGun;
	import etcetera.game.TutorialControl;
	import etcetera.enums.TutorialState;
	import etcetera.game.LevelControl;
	import etcetera.enums.LevelState;
	
	public class GunManager
	{
		var _currentGun:IGun;
		var pistol:Pistol = new Pistol();
		var uzi:Uzi = new Uzi();
		var rifle:Rifle = new Rifle();
		var rocket:RocketLauncher = new RocketLauncher();
		var _previousGun:IGun;
		
		var firstSwitchUzi:Boolean = true;
		var firstSwitchRifle:Boolean = true;
		var firstSwitchRocket:Boolean = true;
		
		public function GunManager()
		{
			_currentGun = pistol;
		}
		
		public function gotAmmoPack()
		{
			uzi.increaseAmmo(200);
			rocket.increaseAmmo(12);
			rifle.increaseAmmo(10);
		}
				
		public function currentGun():IGun
		{
			return _currentGun;
		}
		
		public function prevGun():IGun
		{
			return _previousGun;
		}
		
		public function nextGun():void
		{
			if (_currentGun.getGunType() == Guns.PISTOL)
			{
				_previousGun = pistol;
				if (firstSwitchUzi && (LevelControl.State == LevelState.SANDBOX))
				{
					TutorialControl.State = TutorialState.UZI;
					firstSwitchUzi = false;
				}
				_currentGun = uzi;
			}
			else if (_currentGun.getGunType() == Guns.UZI)
			{
				_previousGun = uzi;
				if (firstSwitchRifle && (LevelControl.State == LevelState.SANDBOX))
				{
					TutorialControl.State = TutorialState.RIFLE;
					firstSwitchRifle = false;
				}
				_currentGun = rifle;
			}
			else if (_currentGun.getGunType() == Guns.RIFLE)
			{
				_previousGun = rifle;
				if (firstSwitchRocket && (LevelControl.State == LevelState.SANDBOX))
				{
					TutorialControl.State = TutorialState.ROCKETLAUNCHER;
					firstSwitchRocket = false;
				}
				_currentGun = rocket;
			}
			else if (_currentGun.getGunType() == Guns.ROCKETLAUNCHER)
			{
				_previousGun = rocket;
				_currentGun = pistol;				
			}
		}
		
		public function previousGun():void
		{
			
			if (_currentGun.getGunType() == Guns.PISTOL)
			{
				_previousGun = pistol;
				if (firstSwitchRocket && (LevelControl.State == LevelState.SANDBOX))
				{
					TutorialControl.State = TutorialState.ROCKETLAUNCHER;
					firstSwitchRocket = false;
				}
				_currentGun = rocket;
			}
			else if (_currentGun.getGunType() == Guns.UZI)
			{
				_previousGun = uzi;
				_currentGun = pistol;
			}
			else if (_currentGun.getGunType() == Guns.RIFLE)
			{
				_previousGun = rifle;
				if (firstSwitchUzi && (LevelControl.State == LevelState.SANDBOX))
				{
					TutorialControl.State = TutorialState.UZI;
					firstSwitchUzi = false;
				}
				_currentGun = uzi;
			}
			else if (_currentGun.getGunType() == Guns.ROCKETLAUNCHER)
			{
				_previousGun = rocket;
				if (firstSwitchRifle && (LevelControl.State == LevelState.SANDBOX))
				{
					TutorialControl.State = TutorialState.RIFLE;
					firstSwitchRifle = false;
				}
				_currentGun = rifle;
			}
		}
	}
}