extends Node2D

var forceMultiplier = 3


func _ready():
	pass


func connectString():
	pass


func launchHook(force):
	var vector = force
	
	apply_impulse(Vector2.ZERO, force * forceMultiplier)
	initialPos = position
	vector = force
	
	hook.position = initialPosition
	
	get_parent().add_child(hook)
	hook.launch(force)
