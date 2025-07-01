class_name Player

extends CharacterBody2D

@export var speed: float = 300.0
@export var health_bar: ProgressBar
@onready var health_component: HealthComponent = $HealthComponent
@onready var gun: Gun = $Gun
@onready var health_regeneration_time: float = 5.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var stat_upgrades: Array[BasePlayerUpgrade] = []
var is_shooting = false
var last_direction: String = "down"

func _init() -> void:
	# loop over all stat upgrades and apply
	#for upgrade in stat_upgrades:
		#upgrade.apply_upgrade(self)
	pass


func _ready() -> void:
	# Initialize the player in the global group
	add_to_group("players")
	health_component.health_changed.connect(update_health_bar)
	start_regeneration()
	take_damage()
	animated_sprite.animation_finished.connect(_on_animation_finished)


func _physics_process(_delta: float) -> void:
	get_input()
	move_and_slide()
	update_animation()

# get input direction from key press
func get_input() -> void:
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed


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
	attack.attack_damage = 10.0
	health_component.damage(attack)

func update_animation() -> void:
	if is_shooting:
		return

	var is_moving := velocity.length() > 0.1
	var direction := get_direction_name(velocity)

	if is_moving:
		last_direction = direction

	var anim_name := ("walk_" if is_moving else "idle_") + last_direction

	if animated_sprite.animation != anim_name:
		animated_sprite.play(anim_name)

func get_direction_name(vec: Vector2) -> String:
	if abs(vec.x) > abs(vec.y):
		return "right" if vec.x > 0 else "left"
	else:
		return "down" if vec.y > 0 else "up"

func play_shoot_animation(direction: Vector2) -> void:
	if is_shooting:
		return

	is_shooting = true
	var dir_name = get_direction_name(direction)
	animated_sprite.play("shoot_" + dir_name)

func _on_animation_finished():
	print("Finished anim:", animated_sprite.animation)
	if is_shooting:
		is_shooting = false
		var anim_name := ("walk_" if velocity.length() > 0.1 else "idle_") + last_direction
		animated_sprite.play(anim_name)
