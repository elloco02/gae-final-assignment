class_name UpgradeList
extends Node

# store player upgrades
var player_upgrades: Array[BasePlayerUpgrade] = [
	SpeedUpgrade.new(),
	RegenerationUpgrade.new(),
	MaxHealthPointsUpgrade.new()
]

# store weapon upgrades
var weapon_upgrades: Array[BaseWeaponUpgrade] = [
	DamageWeaponUpgrade.new(),
	ReloadWeaponUpgrade.new(),
	SpeedWeaponUpgrade.new()
]
