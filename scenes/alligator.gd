extends KinematicBody2D

enum STATES {FREE, HOOKED}

signal caught

export var direction = Vector2(1,1)
export var fishValue = 100

var rng = RandomNumberGenerator.new()

var swimSpeed = -50
var velocity = Vector2.ZERO
var state = STATES.FREE
var heWalkin = true
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
			if heWalkin:
				if is_on_wall():
					direction = direction  * -1
				velocity.x = swimSpeed * direction.x
				velocity.y = lerp(velocity.y, 10, .05)
				move_and_slide(velocity, Vector2.UP)
			else:
				pass
		STATES.HOOKED:
			pass

func swim():
	velocity.y = swimSpeed * direction

func gotHooked(hook):
	$Timer.stop()
	$CollisionShape2D.disabled = true
	state = STATES.HOOKED
	yield(get_tree(), "idle_frame")
	get_parent().remove_child(self)
	hook.get_node("fishHolder").add_child(self)
	global_position = hook.position

func flipTheBoy():
	scale.x = scale.x * -1

func _on_Timer_timeout():
	if swimTime%2 == 0:
		direction.x = direction.x * -1
	swimTime = rng.randi_range(5, 10)
	$Timer.start(swimTime)
	heWalkin = not heWalkin
