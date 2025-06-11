extends CharacterBody2D

@export var speed: int = 300.0

func _physics_process(_delta: float) -> void:
	get_input()
	move_and_slide()

# get input direction from key press
func get_input() -> void:
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
