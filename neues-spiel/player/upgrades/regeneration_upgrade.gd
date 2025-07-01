class_name RegenerationUpgrade
extends BasePlayerUpgrade

@export var regeneration_time_decrease: float = 0.5

func _init() -> void:
	upgrade_text = "-0.5s Regeneration Time (regenerate faster)"

# decreases the regeneration time for the player permanently
func apply_upgrade(player: Player):
	player.health_regeneration_time -= regeneration_time_decrease
