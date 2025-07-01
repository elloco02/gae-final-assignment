class_name HitboxComponent
extends Area2D

@export var health_component: HealthComponent

func _ready() -> void:
	if not health_component:
		push_error("HitboxComponent requires a HealthComponent to be set.")
		return


func damage(attack: Attack) -> void:
	if health_component:
		if self.get_parent() is Player:
			var atk = Attack.new()
			atk.damage = attack.damage * GameManager.difficulty
			health_component.damage(atk)
		else:
			health_component.damage(attack)
