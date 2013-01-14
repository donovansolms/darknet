/*
	darknet
	IMY300 Minigame
	
	Donovan Solms
	25298853
	07 March 2008
	
	IBulletProperties.as
		Defualt properties for a bullet
*/
import etcetera.helpers.Vector;
import etcetera.interfaces.ICharacter;

var _damage:Number = 0;
var _bulletType:String;
public var old:Object = {x: 0, y: 0};
var vec:Vector;

var _from:String;
