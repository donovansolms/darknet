﻿/*
	darknet
	IMY300 Minigame
	
	Donovan Solms
	25298853
	07 March 2008
	
	PistolBullet.as
		Pistol bullet class
*/

package etcetera.guns
{
	import etcetera.interfaces.IBullet;
	import etcetera.enums.Bullets;
	import etcetera.helpers.Vector;
	import etcetera.helpers.VectorMath;
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	public class PistolBullet extends MovieClip implements IBullet
	{
		include "../interfaces/IBulletProperties.as"
		public var imageBMD:BitmapData = new PistolBulletHitBMD(16,10);
		public var image:Bitmap = new Bitmap(imageBMD);
		
		var _direction:Vector = new Vector();
		public var _framesToTarget:Number = 5;	
		
		var _isHit:Boolean = false;

		public function PistolBullet()
		{
			_damage = -7;			//damage bullet does
			_bulletType = Bullets.PISTOL;
			old.x = x;
			old.y = y;
			image.alpha = 0;
			addChild(image);
			//var vec:Vector;
		}
		
		public function get BulletType():String
		{
			return _bulletType;
		}
		
		public function move(dx:Number, dy:Number):void
		{
			
		}
		
		public function get distance():Number
		{
			return _framesToTarget;
		}
		
		public function set BulletType(value:String):void
		{
			_bulletType = value;
		}
		
		public function set From(name:String):void
		{
			_from = name;
		}
		
		public function get From():String
		{
			return _from;
		}
		
		public function get X():Number
		{
			return x;
		}
		
		public function get Y():Number
		{
			return y;
		}

		public function set X(nx:Number)
		{
			x = nx;
		}
		
		public function set Y(ny:Number)
		{
			y = ny;
		}
		
		public function set Angle(angle:Number)
		{
			this.rotation = angle;
		}
		
		public function get Angle():Number
		{
			return this.rotation;
		}
		
		public function get Hit():Boolean
		{
			return _isHit;
		}
		
		public function set Hit(value:Boolean):void
		{
			_isHit = value;
		}
		
		public function set Direction(value:Vector):void
		{
			_direction = value;
		}
		
		public function get Direction():Vector
		{
			return _direction;
		}
				
	}
}