extends Node2D

@onready var muzzle: Marker2D = $Marker2D

var bullet = preload("res://scenes/bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# rotate gun towards mouse position
	look_at(get_global_mouse_position())
	# flip sprite when looking to the left of the character
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1
	
	# shoot a bullet
	if Input.is_action_just_pressed("shoot"):
		var bullet_instance = bullet.instantiate()
		get_tree().root.add_child(bullet_instance)
		bullet_instance.global_position = self.muzzle.global_position
		bullet_instance.rotation = self.rotation
