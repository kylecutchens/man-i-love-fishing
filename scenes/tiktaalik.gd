extends KinematicBody2D

enum STATES {FREE, HOOKED}

signal caught
signal win

export var direction = Vector2(1,1)
export var fishValue = 500

var rng = RandomNumberGenerator.new()

var swimSpeed = -50
var velocity = Vector2.ZERO
var state = STATES.FREE
var hooked = false


func _ready():
	pass

func _physics_process(delta):
	if direction.x == 1:
		$AnimatedSprite.flip_h = true
	elif direction.x == -1:
		$AnimatedSprite.flip_h = false
	
	velocity.x = lerp(velocity.x, 0, .05)
	move_and_slide(velocity, Vector2.UP)

func swim():
	velocity.y = swimSpeed * direction

func gotHooked(hook):
	$Timer.stop()
	set_collision_mask_bit(4, false)
	state = STATES.HOOKED
	yield(get_tree(), "idle_frame")
	get_parent().remove_child(self)
	hook.get_node("fishHolder").add_child(self)
	global_position = hook.position


