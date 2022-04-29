extends Node2D

const STRINGSEGMENT = preload('res://scenes/stringSegment.tscn')
const FISHHOOK = preload("res://scenes/fishHook.tscn")

var maxStringLength = 10

func _ready():
	pass


func _on_vectorCreator_vectorCreated(force):
	var vector = force
	var initialPosition = $anchorPoint.position
	var hook = FISHHOOK.instance()
	
	hook.position = initialPosition
	
	add_child(hook)
	hook.launch(force)
