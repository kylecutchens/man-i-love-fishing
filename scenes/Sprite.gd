extends AnimatedSprite

enum LURES {FIRST, BASIC, WORMS, SHINY, RUBBER, ILURE}
var currentLure = Globals.dataDict['currentLure']

func _ready():
	match currentLure:
		LURES.FIRST:
			play('default')
		LURES.BASIC:
			play('bread')
		LURES.WORMS:
			play('worm')
		LURES.SHINY:
			play('shiny')
		LURES.RUBBER:
			play('rubber')
		LURES.ILURE:
			play('ilure')
