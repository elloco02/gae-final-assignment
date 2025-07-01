class_name UpgradeList
extends Node

var player_upgrades: Array[BasePlayerUpgrade] = [
	SpeedUpgrade.new(),
	RegenerationUpgrade.new(),
	MaxHealthPointsUpgrade.new()
]

var weapon_upgrades: Array[BaseWeaponUpgrade] = [
	DamageWeaponUpgrade.new(),
	ReloadWeaponUpgrade.new(),
	SpeedWeaponUpgrade.new()
]
