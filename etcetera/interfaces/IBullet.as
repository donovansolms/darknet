/*
	darknet
	IMY300 Minigame
	
	Donovan Solms
	25298853
	07 March 2008
	
	IBullet.as
		Interface of functions a bullet must support
*/

package etcetera.interfaces
{
	import etcetera.interfaces.ICharacter;
	import etcetera.helpers.Vector;
	import flash.display.MovieClip;
	
	public interface IBullet
	{
		function move(dx:Number, dy:Number):void;
		function set From(name:String):void;
		function get From():String;
		function get distance():Number;
		function get X():Number;
		function get Y():Number;
		function set X(nx:Number);
		function set Y(ny:Number);
		function set Angle(angle:Number);
		function get Angle():Number;
		function get Hit():Boolean;
		function set Hit(value:Boolean):void;
		function get Direction():Vector;
		function set Direction(value:Vector):void;
		function get BulletType():String;
		function set BulletType(value:String):void;
	}	
}