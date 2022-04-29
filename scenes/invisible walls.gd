extends Node2D


func _ready():
	pass


func _on_wall_body_entered(body):
	print('bonk')
