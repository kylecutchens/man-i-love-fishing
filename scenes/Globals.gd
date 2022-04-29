extends Node

enum RODS {FIRST, BASIC, FIBER, REELMASTER, ROCKETSHOT, BLACKMARKET}
enum LURES {FIRST, BASIC, WORMS, SHINY, RUBBER, ILURE}

var dataDict = {
	"money" : 0,
	"maxCastLength" : 500,
	"castStrength" : 3,
	"reelSpeed" : 3,
	
	"currentRod" : RODS.FIRST,
	"currentLure" : LURES.FIRST,
	
	"maxFishCaught" : 1
}

var shopData = {
	'basicRod' : false,
	'fiberRod' : false,
	'reelMaster' : false,
	'rocketShot' : false,
	'blackMarket' : false,
	
	'basicLure' : false,
	'worms' : false,
	'shinyLure' : false,
	'rubberFish' : false,
	'iLure' : false,
	
	'bucketHat' : false,
	'chanelBoots' : false,
	'fishingVest' : false,
	'cashmereFlannel' : false,
	'fishCrown' : false
}

func _ready():
	pass


