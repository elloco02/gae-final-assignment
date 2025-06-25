class_name Enemy

extends CharacterBody2D


@export var speed: int = 200


func _physics_process(_delta: float) -> void:
	move_and_slide()
