/*
	darknet
	IMY300 Minigame
	
	Donovan Solms
	25298853
	17 March 2008
	
	SoundEffect.as
		Sound effect holder class
*/

package etcetera.sound
{	
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	import etcetera.enums.Sounds;
	
	public class SoundEffect
	{
		var _xOffset:Number;
		var _sound:Sound;
		var _transform:SoundTransform;
		var _channel:SoundChannel;
		
		public function SoundEffect(req:String,xoff:Number)
		{
			if (req == Sounds.PISTOLFIRE)
				_sound = new PistolSound();
			if (req == Sounds.UZIFIRE)
				_sound = new UziSound();
			if (req == Sounds.RIFLEFIRE)
				_sound = new RifleSound();
			if (req == Sounds.ROCKETFIRE)
				_sound = new RocketSound();
			if (req == Sounds.PICKUP)
				_sound = new PickupSound();
			if (req == Sounds.DIE)
				_sound = new DeathSound();
			if (req == Sounds.HEADSHOT)
			{
				//_sound = new HeadShotSound();
				return;
			}
			_channel = _sound.play();
			_transform = new SoundTransform(0.6,xoff);
			_channel.soundTransform = _transform;
			_xOffset = xoff;
		}
	}
}