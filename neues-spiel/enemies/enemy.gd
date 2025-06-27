class_name Enemy

extends CharacterBody2D


@export var speed: int = 200
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	move_and_slide()

func get_direction_name(vec: Vector2) -> String:
	if abs(vec.x) > abs(vec.y):
		return "right" if vec.x > 0 else "left"
	else:
		return "down" if vec.y > 0 else "up"
