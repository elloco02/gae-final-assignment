class_name DamageWeaponUpgrade
extends BaseWeaponUpgrade

@export var damage_increase: float = 5.0

func _init() -> void:
	upgrade_text = "+5 Bullet Damage"

# increases damage for the bullet permanently
func apply_upgrade(weapon_upgrade: WeaponAttack) -> WeaponAttack:
	weapon_upgrade.damage += damage_increase
	return weapon_upgrade
