class_name HealthComponent
extends Node2D

@export var max_health: float = 1.0

var health: float

signal on_death

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.health = self.max_health

# take damage from an attack
func damage(attack: Attack) -> void:
	self.health -= attack.attack_damage

	# death
	if self.health <= 0:
		on_death.emit()
		get_parent().queue_free()
