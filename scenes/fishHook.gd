extends RigidBody2D

enum STATES {CAST, REEL}

signal reeledIn
signal sploosh
var hasHitWater = false

var lineLength = Globals.dataDict['maxCastLength']
var castLength = Vector2.ZERO.normalized()
var initialPos = Vector2()

var forceMultiplier = Globals.dataDict['castStrength']
var reelSpeed = Globals.dataDict['reelSpeed']
var gravity = 15
var velocity = Vector2.ZERO

var fishValue = 0
var fishHooked = false

var fishCaught = 0
var maxFishCaught = Globals.dataDict['maxFishCaught']

var state = STATES.CAST

var vector = Vector2.ZERO

func launch(force : Vector2, pos):
	apply_impulse(Vector2.ZERO, force * forceMultiplier)
	vector = force
	$Camera2D.make_current()

func _physics_process(delta):
	rotation = 0
	update()
	match state:
		STATES.CAST:
			global_position = global_position.clamped(lineLength)
			castLength = global_position.distance_to(initialPos)
			if Input.is_action_pressed("ui_touch"):
				state = STATES.REEL
				continue
		STATES.REEL:
			global_position = position.clamped(castLength)
			
			if Input.is_action_pressed("ui_touch"):
				if $RayCast2D.is_colliding():
					apply_impulse(Vector2.ZERO, Vector2(0, -3))
					castLength = castLength - reelSpeed/3
					continue
				apply_impulse(Vector2.ZERO, Vector2(0, -1))
				castLength = castLength - reelSpeed
			
			if fishHooked == true:
				emit_signal("reeledIn")
			
			if castLength < 0:
				cashInFish()
				queue_free()

func _ready():
	if Globals.shopData['bucketHat']:
		maxFishCaught += 1
	if Globals.shopData['chanelBoots']:
		lineLength = lineLength * 1.1
	if Globals.shopData['fishCrown']:
		$biteBox/biteBoxShape.scale.x *= 2
		$biteBox/biteBoxShape.scale.x *= 2
	initialPos = global_position
	friction = 1
	weight = 2
	gravity_scale = gravity


func _draw():
	draw_line($CollisionShape2D.position, initialPos - global_position, Color(255,255,255), true)

func cashInFish():
	var catchCount = $fishHolder.get_child_count()
	
	if catchCount == 0:
		pass
	else:
		for i in catchCount:
			var f = $fishHolder.get_child(i).get('fishValue')
			fishValue = fishValue + f
	
	emit_signal("reeledIn", fishValue)

func caughtFish():
	fishCaught += 1
	print(fishCaught)
	if fishCaught >= maxFishCaught:
		$biteBox.set_collision_mask_bit(1, false)

func sploosh():
	if not hasHitWater:
		emit_signal("sploosh")
	hasHitWater = not hasHitWater
	

func _on_biteBox_body_entered(body):	
	body.gotHooked(self)
	body.set_collision_layer_bit(1, false)
	caughtFish()
	
