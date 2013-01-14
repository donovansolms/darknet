/*
	darknet
	IMY300 Minigame
	
	Donovan Solms
	25298853
	05 MArch 2008
	
	Character.as
		Character class
*/

package etcetera.characters
{
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import flash.geom.Point;
	
	import etcetera.sound.SoundManager;
	import etcetera.enums.Sounds;
	import etcetera.levels.Level;
	import etcetera.helpers.Vector;
	import etcetera.helpers.VectorMath;
	import etcetera.characters.BoneJoint;
	import etcetera.characters.HealthBar;
	import etcetera.interfaces.ICharacter;
	import etcetera.enums.AnimationStates;
	import etcetera.enums.Guns;
	import etcetera.guns.GunManager;
	import etcetera.guns.Pistol;
	import etcetera.guns.Uzi;
	import etcetera.guns.Rifle;
	import etcetera.guns.RocketLauncher;
	import etcetera.game.TutorialControl;
	import etcetera.enums.TutorialState;
	import etcetera.game.LevelControl;
	import etcetera.enums.LevelState;
		
	public class Character extends MovieClip implements ICharacter
	{
		var _name:String = "Retep";
		
		var healthBar:HealthBar = new HealthBar();
		
		var lineColor:Number = 0x000000;
		
		//this is an object box to test general hits
		var leftTestBMD:BitmapData = new CharacterBoxLR(2,31);
		var leftTest:Bitmap = new Bitmap(leftTestBMD);
		
		var rightTestBMD:BitmapData = new CharacterBoxLR(2,31);
		var rightTest:Bitmap = new Bitmap(rightTestBMD);
		
		var topTestBMD:BitmapData = new CharacterBoxTB(28,2);
		var topTest:Bitmap = new Bitmap(topTestBMD);
		
		var bottomTestBMD:BitmapData = new CharacterBoxTB(28,2);
		var bottomTest:Bitmap = new Bitmap(bottomTestBMD);
		
		var _isDead:Boolean = false;
		//skip every second frame
		var _skipFrame:Boolean = false;
		
		var _isFacingRight:Boolean = true;
		
		//vectors
		public var vel:Object = { x: 0, y: 0 };
		var pos:Object = { x: x, y: y };
		var old:Object = { x: x, y: y };
		
		var gravity:Number = 0.8;
		var restitution:Number = 0.4;
		var friction:Number = 0.8;
		
		var oldX:Number;
		var oldY:Number;
		
		var velX:Number;
		var velY:Number;
		
		var xMouse:Number = 0;
		var yMouse:Number = 0;
	
		var joints:Array = new Array();
		
		//animationState: None, Jumping, Start, Two, Four, Six, Eight, Ten, Twelve, Fourteen, Sixteen, Eighteen
		var _animationState:String = AnimationStates.NONE;	
		
		//save start position
		var olfx:Number;
		var olfy:Number;
		var orfx:Number;
		var orfy:Number;
		var olkx:Number;
		var olky:Number;
		var orkx:Number;
		var orky:Number;
		
		var opx:Number;
		var opy:Number;
		var onx:Number;
		var ony:Number;
		var oax:Number;
		var oay:Number;
		var ohx:Number;
		var ohy:Number;
		
		
		//save good run position
		var lfx:Number;
		var lfy:Number;
		var rfx:Number;	
		var rfy:Number;	
		var lkx:Number;	
		var lky:Number;	
		var rkx:Number;	
		var rky:Number;	
		
		var px:Number;	
		var py:Number;	
		var nx:Number;	
		var ny:Number;	
		var ax:Number;	
		var ay:Number;	
		var hx:Number;	
		var hy:Number;	
		
		var _gunmanager;
		
		var origColor:Number;
		var colorTimer:Timer;
		
		var firstSwitchJump:Boolean = true;
		
		public function set PlayerColor(color:Number)
		{
			lineColor = color;
			origColor = color;
		}
		
		public function hitColor():void
		{
			lineColor = 0xFF0000;
			colorTimer = new Timer(100);
			colorTimer.addEventListener(TimerEvent.TIMER, onTimerFinish);
			colorTimer.start();
			
		}
		
		function onTimerFinish(event:TimerEvent):void
		{
			lineColor = origColor;
			colorTimer.stop();
			colorTimer.reset();
			colorTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerFinish);
		}

		//constructor, give color in hex 0x000000 for other color
		public function Character(gunmanager:GunManager)
		{		
			_gunmanager = gunmanager;
			joints.push(headJoint);
			joints.push(neckJoint);
			//joints.push(handJoint);
			joints.push(pelvisJoint);
			joints.push(leftKneeJoint);
			joints.push(rightKneeJoint);
			joints.push(leftFootJoint);
			joints.push(rightFootJoint);
			
			//images for the bounding box hittests
			leftTest.y -= 45;
			leftTest.x -= 20;
			rightTest.y -= 45;
			rightTest.x += 15;
			
			topTest.y -= 57;
			topTest.x -= 18;
			bottomTest.y += 20;
			bottomTest.x -= 18;
			
			leftTest.alpha = 0;
			rightTest.alpha = 0;
			topTest.alpha = 0;
			bottomTest.alpha = 0;
			addChild(leftTest);
			addChild(rightTest);
			addChild(topTest);
			addChild(bottomTest);
			
			healthBar.y -= 75;
			healthBar.x -= 3;
			addChild(healthBar);
			
			x = 300;
			y = 200;
			_isDead = false;
			saveOrigPosition();
			reDraw();
		}
		
		public function set facingRight(val:Boolean):void
		{
			_isFacingRight = val;
		}
		
		public function set Name(value:String):void
		{
			_name = value;
		}
		
		public function get Name():String
		{
			return _name;
		}
		
		public function get facingRight():Boolean
		{
			return _isFacingRight;
		}
		
		public function Die():void
		{
			SoundManager.playSound(Sounds.DIE, 0);
			var vx:Number = 0;
			if (_isFacingRight)
				vx = 5;
			else 
			{
				vx = -5;
				scaleX *= -1;
			}
			var vy:Number = 5;

			joints.forEach(function(current:*)
			{
				current.vel.x = vx;
				current.vel.y = vy;
			});

			healthBar.alpha = 0;
			_isDead = true;
		}
		
		public function get isDead():Boolean
		{
			return _isDead;
		}
		
		public function Live():void
		{
			_isDead = false;
		}		
		
		public function doGravity(level:Level):void
		{
			if (!_isDead)
				doHitTest(level);
			else doHitTestJoints(level);
				
		}
		
		//solve gravity for the whole character
		public function solveGravity():void
		{
			//do gravity when alive only on whole character
			//with different bounciness
			if (!_isDead)
			{
				pos = { x: x, y: y };
				old = { x: x, y: y };
				
				vel.y += gravity;
			
				if ((vel.y + gravity) >= 10)
					vel.y = 10;
				if ((vel.y + gravity) <= -15)
					vel.y = -15;
				pos.x += vel.x;
				pos.y += vel.y;
			}
		}
		
		public function set animationState(animState:String)
		{
			_animationState = animState;
		}
		
		public function get animationState():String
		{
			return _animationState;
		}
		
		//animate the character
		public function Animate():void
		{
			if (!_skipFrame && !_isDead)
			{
				if (animationState == AnimationStates.NONE)
				{
					resetOrigPosition();
				}
				else if (animationState == AnimationStates.JUMPING)
				{
					
				}
				else if (animationState == AnimationStates.START)
				{
					pelvisJoint.y -= 3;
					leftKneeJoint.x += 3;
					leftKneeJoint.y += 3;
					leftFootJoint.x -= 1;
					leftFootJoint.y -= 3;
					rightFootJoint.x -= 2;
					rightFootJoint.y += 1;
					_skipFrame = true;
					//move to next state
					animationState = AnimationStates.TWO;
				}
				else if (animationState == AnimationStates.TWO)
				{
					leftKneeJoint.x += 5;
					leftKneeJoint.y -= 1;
					leftFootJoint.x += 3;
					leftFootJoint.y -= 2;
					rightKneeJoint.y += 1;
					rightKneeJoint.x -= 4;
					rightFootJoint.x -= 3;
					headJoint.y -= 3;
					_skipFrame = true;
					//move to next state
					animationState = AnimationStates.FOUR;
				}
				else if (animationState == AnimationStates.FOUR)
				{
					leftKneeJoint.x += 10;
					leftKneeJoint.y -= 2;
					rightFootJoint.x -= 5;
					_skipFrame = true;
					//move to next state
					saveRunPos();
					animationState = AnimationStates.SIX;
				}
				else if (animationState == AnimationStates.SIX)
				{
					leftKneeJoint.y -= 3;
					leftKneeJoint.x += 5;
					leftFootJoint.x += 6;
					rightKneeJoint.x -= 3;
					rightFootJoint.x -= 5;
					_skipFrame = true;
					//move to next state
					animationState = AnimationStates.EIGHT;
				}
				else if (animationState == AnimationStates.EIGHT)
				{
					leftFootJoint.x += 10;
					headJoint.y += 3;
					rightKneeJoint.x -= 7;
					rightFootJoint.x -= 7;
					rightFootJoint.y -= 5;
					_skipFrame = true;
					//move to next state
					animationState = AnimationStates.TEN;
				}
				else if (animationState == AnimationStates.TEN)
				{
					leftFootJoint.x += 2;
					rightFootJoint.y -= 4;
					_skipFrame = true;
					//move to next state
					animationState = AnimationStates.TWELVE;
				}
				else if (animationState == AnimationStates.TWELVE)
				{
					headJoint.y -= 2;
					leftFootJoint.y += 5;
					leftFootJoint.x -= 3;
					rightFootJoint.x -= 1;
					rightFootJoint.y -= 4;
					rightKneeJoint.y -= 2;
					_skipFrame = true;
					//move to next state
					animationState = AnimationStates.FOURTEEN;
				}
				else if (animationState == AnimationStates.FOURTEEN)
				{
					leftKneeJoint.x -= 5;
					leftFootJoint.x -= 6;
					rightKneeJoint.y += 4;
					rightKneeJoint.x += 2;
					rightFootJoint.y -= 1;
					rightFootJoint.x += 2;
					_skipFrame = true;
					//move to next state
					animationState = AnimationStates.SIXTEEN;
				}
				else if (animationState == AnimationStates.SIXTEEN)
				{
					_skipFrame = true;
					resetToRunPos();
					animationState = AnimationStates.SIX;
				}
			}
			else _skipFrame = false;
			
			oldX = x;
			oldY = y;
		}
		
		public function resetToRunPos():void
		{
			leftFootJoint.x = lfx;
			leftFootJoint.y = lfy;
			rightFootJoint.x = rfx; 	
			rightFootJoint.y = rfy;	
			leftKneeJoint.x = lkx;	
			leftKneeJoint.y = lky;	
			rightKneeJoint.x = rkx;	
			rightKneeJoint.y = rky;	
			
			pelvisJoint.x = px;	
			pelvisJoint.y = py;	
			neckJoint.x = nx;	
			neckJoint.y = ny;	
			//handJoint.x = ax;	
			//handJoint.y = ay;	
			headJoint.x = hx;	
			headJoint.y = hy;	
			
		}
		
		public function saveRunPos():void
		{
			lfx = leftFootJoint.x;
			lfy = leftFootJoint.y;
			rfx = rightFootJoint.x;	
			rfy = rightFootJoint.y;	
			lkx = leftKneeJoint.x;	
			lky = leftKneeJoint.y;	
			rkx = rightKneeJoint.x;	
			rkx = rightKneeJoint.y;	
			
			px = pelvisJoint.x;	
			py = pelvisJoint.y;	
			nx = neckJoint.x;	
			ny = neckJoint.y;	
			//ax = handJoint.x;	
			//ay = handJoint.y;	
			hx = headJoint.x;	
			hy = headJoint.y;	
		}
		
		function saveOrigPosition():void
		{
			olfx = leftFootJoint.x;
			olfy = leftFootJoint.y;
			orfx = rightFootJoint.x;	
			orfy = rightFootJoint.y;	
			olkx = leftKneeJoint.x;	
			olky = leftKneeJoint.y;	
			orkx = rightKneeJoint.x;	
			orkx = rightKneeJoint.y;	
			
			opx = pelvisJoint.x;	
			opy = pelvisJoint.y;	
			onx = neckJoint.x;	
			ony = neckJoint.y;	
			//oax = handJoint.x;	
			//oay = handJoint.y;	
			ohx = headJoint.x;	
			ohy = headJoint.y;	
		}
		
		function resetOrigPosition():void
		{
			leftFootJoint.x = olfx;
			leftFootJoint.y = olfy;
			rightFootJoint.x = orfx; 	
			rightFootJoint.y = orfy;	
			leftKneeJoint.x = olkx;	
			leftKneeJoint.y = olky;	
			rightKneeJoint.x = orkx;	
			rightKneeJoint.y = orky;	
			
			pelvisJoint.x = opx;	
			pelvisJoint.y = opy;	
			neckJoint.x = onx;	
			neckJoint.y = ony;	
			//handJoint.x = oax;	
			//handJoint.y = oay;	
			headJoint.x = ohx;	
			headJoint.y = ohy;	
		}
		
		public function Jump():void
		{
			if (firstSwitchJump && (LevelControl.State == LevelState.SANDBOX))
			{
				TutorialControl.State = TutorialState.JUMPING;
				firstSwitchJump = false;
			}
			if ((this.vel.y > -4) && (this.vel.y < 4))
				this.vel.y = -15;
		}
		
		public function hurtHeal(value:Number):void
		{
			healthBar.changeHealth(value);
			if (healthBar.health < 0)
				healthBar.health = 0;
		}
		
		public function upAmmo():void
		{
			_gunmanager.gotAmmoPack();
		}
		
		public function get health():Number
		{
			return healthBar.health;
		}
		
		//draw the character with lines, solve the joints
		public function reDraw():void
		{
			x = pos.x;
			y = pos.y;
			
			solveJoints(headJoint, neckJoint,20 , 0.0);
			solveJoints(neckJoint, pelvisJoint,20 , 0.3);
			solveJoints(pelvisJoint, leftKneeJoint,11 , 0.2);
			solveJoints(pelvisJoint, rightKneeJoint,11 , 0.2);
			solveJoints(leftKneeJoint, leftFootJoint,15 , 0.4);
			solveJoints(rightKneeJoint, rightFootJoint,15 , 0.4);
			//special case , when dead
			if (_isDead)
			{
				solveJoints(neckJoint, handJoint,20 , 0.0);
				solveJoints(rightKneeJoint, leftKneeJoint,10 , 0.4);
				solveJoints(rightFootJoint, leftFootJoint,10 , 0.4);
				solveJoints(pelvisJoint, handJoint,10 , 1.0);
			}
			
			/*
						reverse solving
			solveJoints(rightFootJoint, rightKneeJoint,20 , 0.6);
			solveJoints(leftFootJoint, leftKneeJoint,20 , 0.6);
			solveJoints(rightKneeJoint, pelvisJoint, 20 , 0.6);
			solveJoints(leftKneeJoint, pelvisJoint,20 , 0.6);
			solveJoints(pelvisJoint, neckJoint,20 , 0.7);
			solveJoints(handJoint, neckJoint,20 , 0.0);
			solveJoints(neckJoint,headJoint ,20 , 0.0);
			*/
			
			//draw the character
			graphics.clear();
			graphics.lineStyle(4,lineColor);
			graphics.beginFill(lineColor);
			graphics.drawCircle(headJoint.x, headJoint.y,6);
			graphics.endFill();
			
			graphics.moveTo(headJoint.x, headJoint.y);
			graphics.lineTo(neckJoint.x, neckJoint.y);
				
			if (_isDead)
			{
				graphics.moveTo(neckJoint.x, neckJoint.y);
				graphics.lineTo(handJoint.x, handJoint.y);
			}			
			graphics.moveTo(neckJoint.x, neckJoint.y);
			graphics.lineTo(pelvisJoint.x, pelvisJoint.y);
			
			graphics.moveTo(pelvisJoint.x, pelvisJoint.y);
			graphics.lineTo(leftKneeJoint.x, leftKneeJoint.y);
			
			graphics.moveTo(pelvisJoint.x, pelvisJoint.y);
			graphics.lineTo(rightKneeJoint.x, rightKneeJoint.y);
			
			graphics.moveTo(leftKneeJoint.x, leftKneeJoint.y);
			graphics.lineTo(leftFootJoint.x, leftFootJoint.y);
		
			graphics.moveTo(rightKneeJoint.x, rightKneeJoint.y);
			graphics.lineTo(rightFootJoint.x, rightFootJoint.y);
		}
		
		//make the character arm aim at the mouse position
		public function aimArm(xPos:Number, yPos:Number):void
		{
			xMouse = xPos;
			yMouse = yPos;
			
			var xDis:Number = this.x - xPos;
			var yDis:Number = this.y - yPos;
			
			var vec:Vector = new Vector();
			vec.vx = xDis;
			vec.vy = yDis;
			var angle:Number = VectorMath.getAngleDegrees(vec);
			
			/*if (_isFacingRight)
				currentgun.rotation = angle - 180;
			else currentgun.rotation = -angle;*/
		}
		
		public function fire():void
		{
			//call fire on the weapon
			//currentweapon.fire();
		}
		
		public function doHitTest(level:Level):void
		{		
			var testPoint:Point = new Point (level.x, level.y);
			solveGravity();
			if (this.bottomTestBMD.hitTest (new Point (this.pos.x + this.bottomTest.x ,this.pos.y + this.bottomTest.y-2), 255, level.imageBMD, testPoint,255))
			{
				this.vel.y *= -this.restitution;
				this.pos.y -= 3;
			}
			if (this.topTestBMD.hitTest (new Point (this.pos.x + this.topTest.x ,this.pos.y + this.topTest.y), 255, level.imageBMD, testPoint,255))
			{
				this.vel.y *= -this.restitution;
				this.pos.y += 5;
			}
			if (this.leftTestBMD.hitTest (new Point (this.pos.x + this.leftTest.x ,this.pos.y + this.leftTest.y), 255, level.imageBMD, testPoint,255))
				this.pos.x += 5;
			if (this.rightTestBMD.hitTest (new Point (this.pos.x + this.rightTest.x ,this.pos.y + this.rightTest.y), 255, level.imageBMD, testPoint,255))
				this.pos.x -= 5;
			this.reDraw();
		}
		
		public function doHitTestJoints(level:Level):void
		{
			var testPoint:Point = new Point (level.x, level.y);
			//trace("LEVEL : " + level.x + " : " + (level.y + 768));
			this.joints.forEach(function(current:*) 
			{
				current.solveGravity();
				if (current.imageBMD.hitTest (new Point (x + current.x ,y + current.y), 20, level.imageBMD, testPoint, 20))
				{
					current.vel.y *= -current.restitution;
					current.y -= 4;
					if (current.vel.x > 0)
					{
						current.vel.x -=2;
						current.vel.x *= -current.restitution;
					}
					else if (current.vel.x < 0)
					{
						current.vel.x +=2;
						current.vel.x *= -current.restitution;
					}
				}
			});
			this.reDraw();	
		}
				
		//moves the joints to positions that do not break the movement rules
		public function solveJoints(jointOne:BoneJoint, jointTwo:BoneJoint, maxDistance:Number, errorOne:Number) 
		{
			var errorTwo:Number = 1-errorOne;
			var distX:Number = jointOne.x-jointTwo.x;
			var distY:Number = jointOne.y-jointTwo.y;
			var actualDistance:Number = Math.sqrt(distX*distX+distY*distY);//x2 + y2 = r2
			var actualAngle:Number = -Math.atan2(distX, distY);//teen/skuins
			var error:Number = actualDistance-maxDistance;
			//do nothing if movement is waaaayyy to small like 0.023
			if (!((error < 1) && (error > 0)))
			{
				//new positions
				jointOne.x += (error * errorOne) * Math.sin(actualAngle);
				jointOne.y -= (error * errorOne) * Math.cos(actualAngle);
				jointTwo.x -= (error * errorTwo) * Math.sin(actualAngle);
				jointTwo.y += (error * errorTwo) * Math.cos(actualAngle);
			}
		}	
	}
}