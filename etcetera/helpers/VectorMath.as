/*
	darknet
	IMY300 Minigame
	
	Donovan Solms
	25298853
	05 March 2008
	
	VectorMath.as
		A static vector math function help file
*/

package etcetera.helpers
{
	import etcetera.helpers.Vector;
	
	public class VectorMath
	{
		public static function getLength(vector:Vector):Number
		{
			return Math.sqrt((vector.vx * vector.vx) + (vector.vy * vector.vy));		
		}
		
		public static function getAngleDegrees(vector:Vector):Number
		{
			var angle:Number = Math.atan2(vector.vy,vector.vx);
			//make degrees
			return (angle * 180 / Math.PI); 
		}
		
		public static function getAngleRadians(vector:Vector):Number
		{
			var angle:Number = Math.atan2(vector.vy,vector.vx);
			return angle; 
		}
		
		//angle in radians
		public static function makeVector(length:Number, angle:Number):Vector
		{
			var newVector:Vector = new Vector();
			newVector.vx = length * Math.cos(angle);
			newVector.vy = length * Math.sin(angle);
			return newVector;
		}
		
		//if positive then vectors face same direction
		public static function dotProduct(vector1:Vector, vector2:Vector):Number
		{
			return ((vector1.vx * vector2.vx) + (vector1.vy * vector2.vy));
		}
		
		public static function add(vector1:Vector, vector2:Vector):Vector
		{
			var newVector:Vector = new Vector();
			newVector.vx = vector1.vx + vector2.vx;
			newVector.vy = vector1.vy + vector2.vy;
			return newVector;
		}
		
		public static function normals(vector:Vector):Vector
		{
			vector.rx = -vector.vy;
			vector.ry = vector.vx; 
			vector.lx = vector.vy;
			vector.ly = -vector.vx; 
			return vector;
		}
		
		public static function normalize(vector:Vector):Vector
		{
			var newVector:Vector = new Vector();
			var len:Number = Math.sqrt((vector.vx * vector.vx) + (vector.vy * vector.vy));
			if (len != 0)
			{
				newVector.vx = vector.vx / len;
				newVector.vy = vector.vy / len;
			}
			return newVector;
		}
	}	
}