class_name Enemy

extends CharacterBody2D

@export var speed: int = 200
@export var sound_type: SoundEffectSettings.SOUND_EFFECT_TYPE = SoundEffectSettings.SOUND_EFFECT_TYPE.BAT
@export var health_component: HealthComponent
@export var health_bar: ProgressBar

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	if not health_component:
		push_error("HealthComponent must be set for Enemy")
		return
	
	health_component.max_health *= GameManager.difficulty
	health_component.health = health_component.max_health
	health_component.health_changed.connect(update_health_bar)
	
func _physics_process(_delta: float) -> void:
	move_and_slide()

func get_direction_name(vec: Vector2) -> String:
	if abs(vec.x) > abs(vec.y):
		return "right" if vec.x > 0 else "left"
	else:
		return "down" if vec.y > 0 else "up"
		
func update_health_bar(current_health: float, max_health: float) -> void:
	health_bar.max_value = max_health
	health_bar.value = current_health
