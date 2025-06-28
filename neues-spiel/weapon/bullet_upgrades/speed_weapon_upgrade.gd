class_name SpeedWeaponUpgrade
extends BaseWeaponUpgrade

@export var speed_increase: float = 300

func _init() -> void:
	upgrade_text = "+300 Bullet Speed"

# increases speed for the bullet permanently
func apply_upgrade(weapon_upgrade: WeaponAttack):
	weapon_upgrade.speed += speed_increase
