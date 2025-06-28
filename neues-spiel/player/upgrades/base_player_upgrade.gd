# base class for each player upgrade
class_name BasePlayerUpgrade
extends Resource

@export var upgrade_text: String

func _init() -> void:
	upgrade_text = "Base Player Upgrade"

# this is the function that is later called when starting a new level
func apply_upgrade(_player: Player):
	# this does nothing by default
	pass
