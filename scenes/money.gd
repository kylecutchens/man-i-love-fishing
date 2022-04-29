extends Control

func _ready():
	$Label2.text = String(Globals.dataDict['money'])


func _on_fish_man_update(cash):
	$Label2.text = String(cash)
