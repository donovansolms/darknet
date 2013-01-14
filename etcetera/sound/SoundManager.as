/*
	darknet
	IMY300 Minigame
	
	Donovan Solms
	25298853
	16 March 2008
	
	SoundManager.as
		Handles the game sound
*/

package etcetera.sound
{
	//imports
	import etcetera.enums.Sounds;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.media.SoundTransform;
	import flash.media.SoundChannel;
	
	public class SoundManager
	{
		//ambient
		static var ambientRequest:URLRequest;
				
		static var soundeffect:SoundEffect;
		
		static var ambient:Sound;
		static var _channel:SoundChannel;
		static var _transform:SoundTransform;
		
		//the xoffset is a value between -1 and 1 giving it a position in x space
		public static function playSound(sound:String, xoffset:Number):void
		{
			soundeffect = new SoundEffect(sound,xoffset);
		}
		
		public static function ambientSound(sound:String):void
		{
			if (sound == Sounds.MENU)
			{
				ambientRequest = new URLRequest("content/sound/menu.mp3");
				ambient = new Sound(ambientRequest);
				if (_channel != null)
					_channel.stop()
				_channel = ambient.play();
				_transform = new SoundTransform(0.4);
				_channel.soundTransform = _transform;
				
			}
			if (sound == Sounds.SANDBOX)
			{
				ambientRequest = new URLRequest("content/sound/sandbox.mp3");
				ambient = new Sound(ambientRequest);
				if (_channel != null)
					_channel.stop()
				_channel = ambient.play();
				_transform = new SoundTransform(0.1);
				_channel.soundTransform = _transform;
			}
			if (sound == Sounds.LEVELONE)
			{
				ambientRequest = new URLRequest("content/sound/levelone.mp3");
				ambient = new Sound(ambientRequest);
				if (_channel != null)
					_channel.stop()
				_channel = ambient.play();
				_transform = new SoundTransform(0.1);
				_channel.soundTransform = _transform;
			}
			if (sound == Sounds.LEVELTWO)
			{
				ambientRequest = new URLRequest("content/sound/leveltwo.mp3");
				ambient = new Sound(ambientRequest);
				if (_channel != null)
					_channel.stop()
				_channel = ambient.play();
				_transform = new SoundTransform(0.1);
				_channel.soundTransform = _transform;
			}
			if (sound == Sounds.LEVELTHREE)
			{
				ambientRequest = new URLRequest("content/sound/levelthree.mp3");
				ambient = new Sound(ambientRequest);
				if (_channel != null)
					_channel.stop()
				_channel = ambient.play();
				_transform = new SoundTransform(0.1);
				_channel.soundTransform = _transform;
			}
		}
	}
}