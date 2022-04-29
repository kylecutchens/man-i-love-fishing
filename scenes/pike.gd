extends KinematicBody2D

enum STATES {FREE, HOOKED}

signal caught

export var direction = Vector2(1,1)
export var fishValue = 20

var rng = RandomNumberGenerator.new()

var swimSpeed = 300
var velocity = Vector2.ZERO
var state = STATES.FREE

var swimTime = rng.randi_range(5, 20)
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
			if is_on_wall():
				direction = direction * -1
			velocity.x = swimSpeed/3 * direction.x
			velocity.y = lerp(velocity.y, 0, .05)
			move_and_slide(velocity, Vector2.UP)
		STATES.HOOKED:
			pass
	velocity.x = lerp(velocity.x, 0, .05)

func swim():
	velocity.y = swimSpeed * direction

func gotHooked(hook):
	$Timer.stop()
	state = STATES.HOOKED
	yield(get_tree(), "idle_frame")
	get_parent().remove_child(self)
	hook.get_node("fishHolder").add_child(self)
	global_position = hook.position


func _on_Timer_timeout():
	if swimTime%2 == 0:
		velocity.y = swimSpeed
		direction.y = direction.y * -1
	swimTime = rng.randi_range(10, 20)
	$Timer.start(swimTime)
	direction.x = direction.x * -1
	print('timeout')
