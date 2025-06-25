class_name MaxHealthPointsUpgrade
extends BasePlayerUpgrade

@export var max_health_increase: float = 5.0

func _init() -> void:
	upgrade_text = "+5 Max Health"

# increases max_health for the player permanently
func apply_upgrade(player: Player):
	player.max_health += max_health_increase
