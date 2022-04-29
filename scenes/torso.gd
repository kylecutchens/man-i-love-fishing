extends AnimatedSprite

enum RODS {FIRST, BASIC, FIBER, REELMASTER, ROCKETSHOT, BLACKMARKET}

var currentRod = Globals.dataDict['currentRod']

func _ready():
	match currentRod:
		RODS.FIRST:
			$rightArm/rod.play("default")
		RODS.BASIC:
			$rightArm/rod.play("breamBuster")
		RODS.FIBER:
			$rightArm/rod.play("carbonFiber")
		RODS.REELMASTER:
			$rightArm/rod.play("reelMaster")
		RODS.ROCKETSHOT:
			$rightArm/rod.play("rocketShot")
		RODS.BLACKMARKET:
			$rightArm/rod.play("blackMarket")
	
	if Globals.shopData['fishCrown']:
		$head.play('fishCrown')
		$head.offset.x = 2
	elif Globals.shopData['bucketHat']:
		$head.play('bucketHat')
		$head.offset.x = 0
	
	if Globals.shopData['chanelBoots']:
		$legs/chanel.visible = true
		print('f')
	
	if Globals.shopData['fishingVest']:
		$vest.visible = true
	
	if Globals.shopData['cashmereFlannel']:
		$leftArm.play('red')
		$rightArm.play("red")
		play('red')
	
	
