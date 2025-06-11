extends Node2D

@export var speed: int = 300
var attack_damage: float = 1.0

func _process(delta: float) -> void:
	# move bullet in a straight line
	position += transform.x * speed * delta

# deal damage on collision if collider can be damaged
func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		var hitbox: HitboxComponent = area
		var attack = Attack.new()
		attack.attack_damage = self.attack_damage
		hitbox.damage(attack)

# destroy bullet when it exits the screen
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	self.queue_free()
