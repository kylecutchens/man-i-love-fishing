extends Area2D

signal vectorCreated
signal win

export var hardLimit = 300

var touchDown = false
var positionStart = Vector2.ZERO
var positionEnd = Vector2.ZERO

var vector = Vector2.ZERO

func _ready():
	connect("input_event", self, "_on_input_event")

func _input(event):
	if not touchDown:
		return
	
	if event.is_action_released("ui_touch"):
		touchDown = false
		emit_signal("vectorCreated", vector)
		
		reset()
	
	if event is InputEventMouseMotion:
		positionEnd = event.global_position
		vector = -(positionEnd - positionStart).clamped(hardLimit)
		update()

func _on_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("ui_touch"):
		touchDown = true
		positionStart = event.global_position
		print(positionStart)

func reset():
	positionStart = Vector2.ZERO
	positionEnd = Vector2.ZERO
	vector = Vector2.ZERO
	update()

func _draw():	
	draw_line(Vector2.ZERO - global_position, Vector2.ZERO - global_position + vector, Color.red, 8, true)


func _on_vectorCreator_body_entered(body):
	print('dubski')
	emit_signal('win')
