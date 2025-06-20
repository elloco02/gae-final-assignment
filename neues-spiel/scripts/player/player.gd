class_name Player

extends CharacterBody2D

@export var speed: int = 300

@onready var gun: Gun = $Gun

var stat_upgrades: Array[BasePlayerUpgrade] = []

func _init() -> void:
	# loop over all stat upgrades and apply
	for upgrade in stat_upgrades:
		upgrade.apply_upgrade(self)

func _physics_process(_delta: float) -> void:
	get_input()
	move_and_slide()

# get input direction from key press
func get_input() -> void:
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
