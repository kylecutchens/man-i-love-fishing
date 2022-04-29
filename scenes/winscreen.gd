extends Popup

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
	'iLure' : false}

func _ready():
	pass


func _on_Button_pressed():
	visible = false


func _on_Button2_pressed():
	Globals.dataDict['money'] = 0
	Globals.dataDict['maxCastLength'] = 500
	Globals.dataDict['castStrength'] = 3
	Globals.dataDict['reelSpeed'] = 3
	Globals.shopData = shopData
	get_tree().change_scene("res://scenes/tampa.tscn")


func _on_vectorCreator_win():
	print('winner')
	visible = true


func _on_fish_man_win():
	print('winner')
	visible = true
