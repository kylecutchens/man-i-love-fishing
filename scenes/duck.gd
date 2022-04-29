extends KinematicBody2D
enum STATES {FREE, HOOKED}

export var direction = Vector2(1,1)
export var fishValue = 15

var rng = RandomNumberGenerator.new()

var swimSpeed = -150
var velocity = Vector2.ZERO
var state = STATES.FREE

var swimTime = rng.randi_range(10, 20)
var hooked = false

func _ready():
	rng.randomize()
	$Timer.start(swimTime)

func _physics_process(delta):
	if direction.x == 1:
		$AnimatedSprite.flip_h = true
	elif direction.x == -1:
		$AnimatedSprite.flip_h = false
	
	match state:
		STATES.FREE:
			velocity.x = swimSpeed * direction.x
			move_and_slide(velocity)
		STATES.HOOKED:
			pass

func gotHooked(hook):
	state = STATES.HOOKED
	yield(get_tree(), "idle_frame")
	get_parent().remove_child(self)
	hook.get_node("fishHolder").add_child(self)
	global_position = hook.position


func _on_Timer_timeout():
	swimTime = rng.randi_range(10, 20)
	$Timer.start(swimTime)
	direction.x = direction.x * -1
