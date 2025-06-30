class_name Enemy

extends CharacterBody2D

enum ENEMY_TYPE {
	BAT,
	MUMMY,
	CACTUS,
	SCORPION
}

@export var speed: int = 200
@export var type: ENEMY_TYPE

func _physics_process(_delta: float) -> void:
	move_and_slide()
