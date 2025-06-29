class_name Enemy

extends CharacterBody2D


@export var speed: int = 200
@export var health_component: HealthComponent


func _ready() -> void:
	if not health_component:
		push_error("HealthComponent must be set for Enemy")
		return


func _physics_process(_delta: float) -> void:
	move_and_slide()
