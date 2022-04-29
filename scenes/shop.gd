extends Control

enum RODS {FIRST, BASIC, FIBER, REELMASTER, ROCKETSHOT, BLACKMARKET}
enum LURES {FIRST, BASIC, WORMS, SHINY, RUBBER, ILURE}

var currentRod = Globals.dataDict['currentRod']
var currentLure = Globals.dataDict['currentLure']

var money = Globals.dataDict['money']

func _ready():
	$rods.visible = true
	print(currentRod)
	$money/Label.text = String(money)

func moneyCheck(price):	
	if price > money:
		print('broke fella alert')
		return false
	elif money >= price:
		money = money - price
		print('cha ching')
		$money/Label.text = String(money)
		return true

func makeRodCurrent(rod):
	Globals.dataDict['currentRod'] = rod

func makeLureCurrent(lure):
	Globals.dataDict['currentLure'] = lure

func purchaseRod(rod, price):
	var creditCheck = moneyCheck(price)
	if creditCheck == true:
		rod = true
		return true
	else:
		return false

func setValues():
	match currentRod:
		RODS.FIRST:
			Globals.dataDict["maxCastLength"] = 500
			Globals.dataDict["castStrength"] = 3
			Globals.dataDict["reelSpeed"] = 3
		RODS.BASIC:
			Globals.dataDict['maxCastLength'] = 1000
			Globals.dataDict['castStrength'] = 5
			Globals.dataDict['reelSpeed'] = 5
		RODS.FIBER:
			Globals.dataDict['maxCastLength'] = 2500
			Globals.dataDict['castStrength'] = 7
			Globals.dataDict['reelSpeed'] = 7
		RODS.REELMASTER:
			Globals.dataDict['maxCastLength'] = 5000
			Globals.dataDict['castStrength'] = 10
			Globals.dataDict['reelSpeed'] = 9
		RODS.ROCKETSHOT:
			Globals.dataDict['maxCastLength'] = 7000
			Globals.dataDict['castStrength'] = 12
			Globals.dataDict['reelSpeed'] = 11
		RODS.BLACKMARKET:
			Globals.dataDict['maxCastLength'] = 10000
			Globals.dataDict['castStrength'] = 14
			Globals.dataDict['reelSpeed'] = 15
	match currentLure:
		LURES.FIRST:
			Globals.dataDict['maxFishCaught'] = 1
		LURES.BASIC:
			Globals.dataDict['maxFishCaught'] = 3
		LURES.WORMS:
			Globals.dataDict['maxFishCaught'] = 7
		LURES.SHINY:
			Globals.dataDict['maxFishCaught'] = 12
		LURES.RUBBER:
			Globals.dataDict['maxFishCaught'] = 15
		LURES.ILURE:
			Globals.dataDict['maxFishCaught'] = 200

func _on_backButton_pressed():
	setValues()
	Globals.dataDict['money'] = money
	get_tree().change_scene("res://scenes/tampa.tscn")

func _on_miscButton_pressed():
	$rods.visible = false
	$lures.visible = false
	$drip.visible = true

func _on_baitButton_pressed():
	$rods.visible = false
	$lures.visible = true
	$drip.visible = false

func _on_rodsButton_pressed():
	$rods.visible = true
	$lures.visible = false
	$drip.visible = false

func _on_basicRod_pressed():
	var price = 20
	var rod = Globals.shopData['basicRod']
	if not rod:
		var purchase = purchaseRod(rod, price)
		if purchase:
			Globals.shopData['basicRod'] = true
			currentRod = RODS.BASIC
			makeRodCurrent(currentRod)
	elif rod:
		currentRod = RODS.BASIC
		makeRodCurrent(currentRod)

func _on_fiberRod_pressed():
	var price = 65
	var rod = Globals.shopData['fiberRod']
	if not rod:
		var purchase = purchaseRod(rod, price)
		if purchase:
			Globals.shopData['fiberRod'] = true
			currentRod = RODS.FIBER
			makeRodCurrent(currentRod)
	elif rod:
		currentRod = RODS.FIBER
		makeRodCurrent(currentRod)

func _on_reelMaster_pressed():
	var price = 150
	var rod = Globals.shopData['reelMaster']
	if not rod:
		var purchase = purchaseRod(rod, price)
		if purchase:
			Globals.shopData['reelMaster'] = true
			currentRod = RODS.REELMASTER
			makeRodCurrent(currentRod)
	elif rod:
		currentRod = RODS.REELMASTER
		makeRodCurrent(currentRod)

func _on_rocketShot_pressed():
	var price = 350
	var rod = Globals.shopData['rocketShot']
	if not rod:
		var purchase = purchaseRod(rod, price)
		if purchase:
			Globals.shopData['rocketShot'] = true
			currentRod = RODS.ROCKETSHOT
			makeRodCurrent(currentRod)
	elif rod:
		currentRod = RODS.ROCKETSHOT
		makeRodCurrent(currentRod)

func _on_blackMarket_pressed():
	var price = 750
	var rod = Globals.shopData['blackMarket']
	if not rod:
		var purchase = purchaseRod(rod, price)
		if purchase:
			Globals.shopData['blackMarket'] = true
			currentRod = RODS.BLACKMARKET
			makeRodCurrent(currentRod)
	elif rod == true:
		currentRod = RODS.BLACKMARKET
		makeRodCurrent(currentRod)

func _on_basicLure_pressed():
	var price = 10
	var lure = Globals.shopData['basicLure']
	if not lure:
		var purchase = purchaseRod(lure, price)
		if purchase:
			Globals.shopData['basicLure'] = true
			currentLure = LURES.BASIC
			makeLureCurrent(currentLure)
		elif lure == true:
			currentLure = LURES.BASIC
			makeLureCurrent(currentLure)


func _on_wormsLure_pressed():
	var price = 45
	var lure = Globals.shopData['worms']
	if not lure:
		var purchase = purchaseRod(lure, price)
		if purchase:
			Globals.shopData['worms'] = true
			currentLure = LURES.WORMS
			makeLureCurrent(currentLure)
		elif lure == true:
			currentLure = LURES.WORMS
			makeLureCurrent(currentLure)


func _on_shinyLure_pressed():
	var price = 100
	var lure = Globals.shopData['shinyLure']
	if not lure:
		var purchase = purchaseRod(lure, price)
		if purchase:
			Globals.shopData['shinyLure'] = true
			currentLure = LURES.SHINY
			makeLureCurrent(currentLure)
		elif lure == true:
			currentLure = LURES.SHINY
			makeLureCurrent(currentLure)

func _on_rubberLure_pressed():
	var price = 275
	var lure = Globals.shopData['rubberFish']
	if not lure:
		var purchase = purchaseRod(lure, price)
		if purchase:
			Globals.shopData['rubberFish'] = true
			currentLure = LURES.RUBBER
			makeLureCurrent(currentLure)
		elif lure == true:
			currentLure = LURES.RUBBER
			makeLureCurrent(currentLure)

func _on_iLure_pressed():
	var price = 450
	var lure = Globals.shopData['iLure']
	if not lure:
		var purchase = purchaseRod(lure, price)
		if purchase:
			Globals.shopData['iLure'] = true
			currentLure = LURES.ILURE
			makeLureCurrent(currentLure)
		elif lure == true:
			currentLure = LURES.ILURE
			makeLureCurrent(currentLure)


func _on_bucketHat_pressed():
	var price = 30
	var drip = Globals.shopData['bucketHat']
	if not drip:
		var purchase = purchaseRod(drip, price)
		if purchase:
			Globals.shopData['bucketHat'] = true
			print(drip)
		else:
			pass

func _on_rubberBoots_pressed():
	var price = 70
	var drip = Globals.shopData['chanelBoots']
	if not drip:
		var purchase = purchaseRod(drip, price)
		if purchase:
			Globals.shopData['chanelBoots'] = true
			print(drip)
		else:
			pass

func _on_fishingVest_pressed():
	var price = 175
	var drip = Globals.shopData['fishingVest']
	if not drip:
		var purchase = purchaseRod(drip, price)
		if purchase:
			Globals.shopData['fishingVest'] = true
			print(drip)
		else:
			pass

func _on_flannel_pressed():
	var price = 400
	var drip = Globals.shopData['cashmereFlannel']
	if not drip:
		var purchase = purchaseRod(drip, price)
		if purchase:
			Globals.shopData['cashmereFlannel'] = true
			print(drip)
		else:
			pass

func _on_fishHat_pressed():
	var price = 999
	var drip = Globals.shopData['fishCrown']
	if not drip:
		var purchase = purchaseRod(drip, price)
		if purchase:
			print(drip)
			Globals.shopData['fishCrown'] = true
		else:
			pass
