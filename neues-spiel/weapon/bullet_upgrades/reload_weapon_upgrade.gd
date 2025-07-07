class_name ReloadWeaponUpgrade
extends BaseWeaponUpgrade

@export var reload_decrease: float = 0.5

func _init() -> void:
	upgrade_text = "-0.5s Reload Time"

# increases speed for the bullet permanently
func apply_upgrade(weapon_upgrade: WeaponAttack) -> WeaponAttack:
	weapon_upgrade.reload_time -= reload_decrease
	return weapon_upgrade
