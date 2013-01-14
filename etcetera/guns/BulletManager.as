/*
	darknet
	IMY300 Minigame
	
	Donovan Solms
	25298853
	07 March 2008
	
	BulletManager.as
		Does all the bullet management
*/

package etcetera.guns
{
	import etcetera.enums.Bullets;
	import etcetera.interfaces.IBullet;
	import etcetera.characters.Character;
	import etcetera.characters.Bot;
	import etcetera.levels.Level;
	import etcetera.helpers.Vector;
	import etcetera.helpers.VectorMath;
	import flash.geom.Point;
	import flash.display.MovieClip;
	
	public class BulletManager extends MovieClip
	{
		public static var bullets:Array = new Array();
		public static var hitText:String = "";
		public static var headShot:Boolean = false;
		
		public function BulletManager()
		{
			
		}
		
		//function that runs every frame checking collitions/moving bullets/hurting people (the afrikaans singers)
		public static function updateBullets(character:Character, bots:Array, level:Level)
		{
			if (bullets.length != 0)
				bullets.forEach(function(current:*)
				{
					//fix vector
					current.X += -(current.Direction.vx/10);
					current.Y += -(current.Direction.vy/10);

					//do world check
					checkWorldCollision(level,current);
					//do character checks
					checkCharacterCollisions(character,bots,current,level);
				});
			
		}
		
		public static function updateArray():void
		{
			if (bullets.length != 0)
				for(var i:Number = 0; i < bullets.length; i++)
				{
					if (bullets[i].Hit)
					{
						removeBullet(bullets[i]);
						break;
					}
				}
		}
		
		public static function removeAll():void
		{
			if (bullets.length != 0)
				for(var i:Number = 0; i < bullets.length; i++)
				{
					//if (bullets[i].Hit)
					//{
						removeBullet(bullets[i]);
						//break;
					//}
				}
		}
		
		public static function addBullet(value:IBullet, dX:Number, dY:Number):void
		{
			var vec:Vector = new Vector();
			vec.vx = dX;
			vec.vy = dY;
			var angle:Number = VectorMath.getAngleDegrees(vec);
			value.Angle = angle;
			
			vec = VectorMath.normalize(vec);
			//add vector to bullet
			if (value.BulletType == Bullets.ROCKET)
			{
				value.Direction.vx = vec.vx*200;
				value.Direction.vy = vec.vy*200;
			}
			else
			{
				value.Direction.vx = vec.vx*300;
				value.Direction.vy = vec.vy*300;
			}
			bullets.push(value);
		}
		
		public static function removeBullet(value:IBullet):void
		{
			var pos:int = bullets.indexOf(value);
			if (pos != -1)
				bullets.splice(pos,1);
		}
		
		//check colisions, destroy world at position depending on bullet type
		public static function checkWorldCollision(level:Level, current:IBullet):void
		{
			var testPoint:Point = new Point (level.x, level.y);
			if ((current.BulletType == Bullets.PISTOL) || (current.BulletType == Bullets.UZI) || (current.BulletType == Bullets.RIFLE))
				if (PistolBullet(current).imageBMD.hitTest (new Point (current.X ,current.Y), 20, level.imageBMD, testPoint, 20))
				{
					current.Hit = true;		
					var destroy:uint = 0x00000000;
					for (var i:uint = 0; i < 3; i++)
						for (var j:uint = 0; j < 2; j++)
						{
							level.imageBMD.setPixel32(current.X - j - level.x, current.Y + i - level.y - 3,destroy);
							level.imageBMD.setPixel32(current.X + j - level.x, current.Y + i - level.y - 3,destroy);		
							level.imageBMD.setPixel32(current.X - j - level.x, current.Y - i - level.y + 2,destroy);
							level.imageBMD.setPixel32(current.X + j - level.x, current.Y - i - level.y + 2,destroy);
						}
					
				}
				if (current.BulletType == Bullets.ROCKET)
					if (Rocket(current).imageBMD.hitTest (new Point (current.X ,current.Y), 0, level.imageBMD, testPoint, 20))
					{
						current.Hit = true;		
						var destroy:uint = 0x00000000;
						for (var i:uint = 0; i < 15; i++)
							for (var j:uint = 0; j < 14; j++)
							{
								level.imageBMD.setPixel32(current.X - j - level.x, current.Y + i - level.y - 15,destroy);
								level.imageBMD.setPixel32(current.X + j - level.x, current.Y + i - level.y - 15,destroy);		
								level.imageBMD.setPixel32(current.X - j - level.x, current.Y - i - level.y + 14,destroy);
								level.imageBMD.setPixel32(current.X + j - level.x, current.Y - i - level.y + 14,destroy);
							}
						
					}
			//play optional movieclip
		}
		
		//check if players were hit, subtract health/kill
		public static function checkCharacterCollisions(character:Character,bots:Array, current:IBullet, level:Level):void
		{

			//check player
			if ((current.From != character.Name) && (bots != null))
			{
				var testPoint:Point = new Point (bots[i].x, bots[i].y);
				if (current.BulletType == Bullets.PISTOL)
				{
					if (PistolBullet(current).hitTestObject(character.hitBoxBody))
					{
						current.Hit = true;		
						character.hurtHeal(-7);
						character.hitColor();
					}
					if (PistolBullet(current).hitTestObject(character.hitBoxHead))
					{
						current.Hit = true;		
						character.hurtHeal(-8);
						character.hitColor();
					}
				}
				if (current.BulletType == Bullets.UZI)
				{
					if (PistolBullet(current).hitTestObject(character.hitBoxBody))
					{
						current.Hit = true;		
						character.hurtHeal(-1);
						character.hitColor();
					}
					if (PistolBullet(current).hitTestObject(character.hitBoxHead))
					{
						current.Hit = true;		
						character.hurtHeal(-2);
						character.hitColor();
					}
				}
				if (current.BulletType == Bullets.RIFLE)
				{
					if (PistolBullet(current).hitTestObject(character.hitBoxBody))
					{
						current.Hit = true;		
						character.hurtHeal(-30);
						character.hitColor();
					}
					if (PistolBullet(current).hitTestObject(character.hitBoxHead))
					{
						hitText = "you were given a headshot from " + PistolBullet(current).From;
						headShot = true;
						current.Hit = true;		
						character.hurtHeal(-100);
						character.hitColor();
					}
				}
				if (current.BulletType == Bullets.ROCKET)
				{
					if (Rocket(current).hitTestObject(character.hitBoxBody))
					{
						current.Hit = true;		
						character.hurtHeal(-15);
						character.hitColor();
					}
					if (Rocket(current).hitTestObject(character.hitBoxHead))
					{
						current.Hit = true;		
						character.hurtHeal(-15);
						character.hitColor();
					}
				}
			}
			
			//loop bots
			for (var i:int = 0; i < bots.length; i++)
			{
				if ((current.From != bots[i].Name) && (!bots[i].isDead))
				{
					//no friendly fire
					if (current.From == character.Name)
					{
						if (current.BulletType == Bullets.PISTOL)
						{
							if (PistolBullet(current).hitTestObject(bots[i].hitBoxBody))
							{
								
								current.Hit = true;		
								bots[i].hurtHeal(-7);
								bots[i].hitColor();
							}
							if (PistolBullet(current).hitTestObject(bots[i].hitBoxHead))
							{
								current.Hit = true;		
								bots[i].hurtHeal(-8);
								bots[i].hitColor();
							}
						}
						if (current.BulletType == Bullets.PISTOL)
						{
							if (PistolBullet(current).hitTestObject(bots[i].hitBoxBody))
							{
								current.Hit = true;		
								bots[i].hurtHeal(-7);
								bots[i].hitColor();
							}
							if (PistolBullet(current).hitTestObject(bots[i].hitBoxHead))
							{
								current.Hit = true;		
								bots[i].hurtHeal(-8);
								bots[i].hitColor();
							}
						}
						if (current.BulletType == Bullets.UZI)
						{
							if (PistolBullet(current).hitTestObject(bots[i].hitBoxBody))
							{
								current.Hit = true;		
								bots[i].hurtHeal(-1);
								bots[i].hitColor();
							}
							if (PistolBullet(current).hitTestObject(bots[i].hitBoxHead))
							{
								current.Hit = true;		
								bots[i].hurtHeal(-2);
								bots[i].hitColor();
							}
						}
						if (current.BulletType == Bullets.RIFLE)
						{
							if (PistolBullet(current).hitTestObject(bots[i].hitBoxBody))// (new Point (level.x + current.X - 1024 , level.y+current.Y-768), 10, bots[i].imageBMD, testPoint, 10))
							{
								current.Hit = true;		
								bots[i].hurtHeal(-30);
								bots[i].hitColor();
							}
							if (PistolBullet(current).hitTestObject(bots[i].hitBoxHead))// (new Point (level.x + current.X - 1024 , level.y+current.Y-768), 10, bots[i].imageBMD, testPoint, 10))
							{
								current.Hit = true;		
								bots[i].hurtHeal(-100);
								hitText = "you gave " + bots[i].Name + " a headshot";
								headShot = true;
								bots[i].hitColor();
							}
						}
						if (current.BulletType == Bullets.ROCKET)
						{
							if (Rocket(current).hitTestObject(bots[i].hitBoxBody))// (new Point (level.x + current.X - 1024 , level.y+current.Y-768), 10, bots[i].imageBMD, testPoint, 10))
							{
								current.Hit = true;		
								bots[i].hurtHeal(-60);
								bots[i].hitColor();
							}
							if (Rocket(current).hitTestObject(bots[i].hitBoxHead))// (new Point (level.x + current.X - 1024 , level.y+current.Y-768), 10, bots[i].imageBMD, testPoint, 10))
							{
								current.Hit = true;		
								bots[i].hurtHeal(-60);
								bots[i].hitColor();
							}
						}
					}
				}
			}
			//play optional movie
		}
	}
}