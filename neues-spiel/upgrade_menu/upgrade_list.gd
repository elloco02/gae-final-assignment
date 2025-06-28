class_name UpgradeList
extends Node

var player_upgrades: Array[BasePlayerUpgrade] = [
	SpeedUpgrade.new(),
	#RegenerationUpgrade.new(), # uncomment when player regeneration has been added
	#MaxHealthPointsUpgrade.new() # uncomment when player max_health has been added
]

var weapon_upgrades: Array[BaseWeaponUpgrade] = [
	DamageWeaponUpgrade.new(),
	SpeedWeaponUpgrade.new(),
	ReloadWeaponUpgrade.new()
]
