class_name Player

extends CharacterBody2D

@export var speed: float = 300.0
@onready var gun: Gun = $Gun

var stat_upgrades: Array[BasePlayerUpgrade] = []

func _init() -> void:
	# loop over all stat upgrades and apply
	#for upgrade in stat_upgrades:
		#upgrade.apply_upgrade(self)
	pass


func _ready() -> void:
	# Initialize the player in the global group
	add_to_group("players")


func _physics_process(_delta: float) -> void:
	get_input()
	move_and_slide()


# get input direction from key press
func get_input() -> void:
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

	if Input.is_action_just_pressed("pause game") and not get_tree().paused:
		pause()
		%UpgradeMenu.visible = not %UpgradeMenu.visible

func pause() -> void:
	get_tree().paused = true

# TEMPORARY SOLUTION UNTIL WAVE MANAGEMENT IS IMPLEMENTED
func temp_apply_upgrades() -> void:
	for upgrade in stat_upgrades:
		upgrade.apply_upgrade(self)
