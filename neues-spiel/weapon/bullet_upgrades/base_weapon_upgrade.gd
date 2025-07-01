# base class for each bullet upgrade
class_name BaseWeaponUpgrade
extends Resource

@export var upgrade_text: String

func _init() -> void:
	upgrade_text = "Base Bullet Upgrade"

# this is the function that is later called when firing a bullet
func apply_upgrade(_weapon_upgrade: WeaponAttack) -> WeaponAttack:
	# this does nothing by default
	return _weapon_upgrade
