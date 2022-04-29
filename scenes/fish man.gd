extends Node2D

enum STATES  {CAST, REEL}

signal update
signal win

const FISHHOOK = preload("res://scenes/fishHook.tscn")

var state = STATES.CAST

var lineLength = 10
var castLength = Vector2.ZERO
var mousePos = Vector2.ZERO

var isHookCast = false

var cash = Globals.dataDict['money']

func _ready():
	pass

func _process(delta):
	mousePos = get_global_mouse_position()
	
	if Input.is_action_pressed("reset"):
		get_tree().change_scene("res://scenes/tampa.tscn")
	
	match state:
		STATES.CAST:
			if Input.is_action_pressed('ui_touch'):
				$torso/head.look_at( mousePos * -1)
				if mousePos.x > 0:
					$torso/head.flip_v = true
				else:
					$torso/head.flip_v = false
		STATES.REEL:
			$torso/head.rotation = 0
			$torso/head.flip_v = false

func launchHook(force : Vector2):
	state = STATES.REEL
	$vectorCreator.set_collision_layer_bit(3, false)
	
	var vector = force
	var initialPosition = $stringAnchor.global_position
	var hook = FISHHOOK.instance()
	hook.connect("reeledIn", self, "addCash")
	hook.connect("sploosh", self, "sploosh")
	hook.global_position = initialPosition
	get_parent().add_child(hook)
	
	hook.launch(force, initialPosition)
	
	$castSound.play()


func addCash(money):
	$torso/head.rotation = 0
	state = STATES.CAST
	if Globals.shopData['cashmereFlannel']:
		money *= 1.05
		money = int(money)
	cash = cash + money
	$vectorCreator.set_collision_layer_bit(3, true)
	$Camera2D.make_current()
	emit_signal("update", cash)

func save():
	Globals.dataDict['money'] = cash

func sploosh():
	$castSound.stop()
	$splooshSound.play()

func _on_Button_pressed():
	save()
	get_tree().change_scene("res://scenes/shop.tscn")


func _on_winArea_body_entered(body):
	print("win")
	emit_signal('win')
