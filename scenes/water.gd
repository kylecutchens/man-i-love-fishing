extends Area2D

var isUnderwater = false

func _ready():
	pass


func _on_water_body_entered(body):
	print('sploosh')
	body.set_gravity_scale(2)
	body.sploosh()
	
	
