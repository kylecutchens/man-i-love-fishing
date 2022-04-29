extends Area2D 

enum FISHTYPE {COMMON, RARE}

export var fishCount = 3
export var fishtype = FISHTYPE.COMMON
var currentFish = 0

const TROUT = preload("res://scenes/fish.tscn")
const BASS = preload("res://scenes/bass.tscn")
const SALMON = preload("res://scenes/salmon.tscn")
const PIKE = preload("res://scenes/pike.tscn")
var rng = RandomNumberGenerator.new()

var initialPos = Vector2.ZERO
var maxSize = Vector2.ZERO
var fishPos = Vector2.ZERO
var type = rng.randi_range(0,1)
var direction = rng.randi_range(0, 9)

func _ready():
	if Globals.shopData['fishingVest']:
		fishCount *= 1.1
	initialPos = $CollisionShape2D.global_position
	maxSize = $CollisionShape2D.shape.get_extents()
	rng.randomize()

func _process(delta):
	match fishtype:
		FISHTYPE.COMMON:
			if currentFish < fishCount:
				for i in fishCount:
					var f = TROUT.instance()
					if type == 1:
						f = BASS.instance()
					fishPos.x = initialPos.x + rng.randf_range(maxSize.x, -maxSize.x)
					fishPos.y = initialPos.y + rng.randf_range(maxSize.y, -maxSize.y)
					f.global_position = fishPos
					get_parent().add_child(f)
					type = rng.randi_range(0,1)
					currentFish = currentFish + 1
		FISHTYPE.RARE:
			if currentFish < fishCount:
				for i in fishCount:
					var f = SALMON.instance()
					if type == 1:
						f = PIKE.instance()
					fishPos.x = initialPos.x + rng.randf_range(maxSize.x, -maxSize.x)
					fishPos.y = initialPos.y + rng.randf_range(maxSize.y, -maxSize.y)
					f.global_position = fishPos
					get_parent().add_child(f)
					type = rng.randi_range(0,1)
					currentFish = currentFish + 1

func fishCaught():
	currentFish = currentFish - 1
