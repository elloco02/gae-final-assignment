class_name RegenerationUpgrade
extends BasePlayerUpgrade

@export var regeneration_increase: float = 3.0

func _init() -> void:
	upgrade_text = "+3 Regeneration"

# increases regeneration for the player permanently
func apply_upgrade(player: Player):
	player.regeneration += regeneration_increase
