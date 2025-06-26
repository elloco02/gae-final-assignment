class_name Player

extends CharacterBody2D

@export var speed: float = 300.0
@onready var health_component: HealthComponent = $HealthComponent
@onready var gun: Gun = $Gun
@onready var health_regeneration_time : float = 5.0
@onready var health_bar: ProgressBar = get_tree().get_root().get_node("Level/CanvasLayer/HPBar")

var stat_upgrades: Array[BasePlayerUpgrade] = []

func _init() -> void:
	# loop over all stat upgrades and apply
	#for upgrade in stat_upgrades:
		#upgrade.apply_upgrade(self)
	pass

func _ready() -> void:
	# Initialize the player in the global group
	add_to_group("players")
	health_component.health_changed.connect(update_health_bar)
	update_health_bar(health_component.health, health_component.max_health)
	start_regeneration()
	# take_damage()

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
		
func start_regeneration() -> void:
	regenerate_loop()
	
func regenerate_loop() -> void:
	await get_tree().create_timer(health_regeneration_time).timeout
	if health_component != null:
		health_component.regenerate()
	regenerate_loop()

func update_health_bar(current_health: float, max_health: float) -> void:
	health_bar.max_value = max_health
	health_bar.value = current_health

# code to test if taking damage works (reduces hp and updates hp bar in ui)
func take_damage() -> void:
	await get_tree().create_timer(health_regeneration_time).timeout
	var attack := Attack.new()
	attack.attack_damage = 100.0
	health_component.damage(attack)
