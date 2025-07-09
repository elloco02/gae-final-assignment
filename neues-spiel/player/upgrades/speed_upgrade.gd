class_name SpeedUpgrade
extends BasePlayerUpgrade

@export var speed_increase: float = 50.0


func _init() -> void:
	upgrade_text = "+50 Movement Speed"


# increases speed for the player permanently
func apply_upgrade(player: Player):
	player.speed += speed_increase
