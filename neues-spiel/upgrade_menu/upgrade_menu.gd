extends Control

@export var player: Player
@onready var upgrade_list: UpgradeList = UpgradeList.new()
@onready var vbox = %VBoxContainer
@onready var weapon: Gun = player.gun

func _ready():
	%ResumeButton.pressed.connect(resume)
	# create a button for each upgrade in upgrade_list and add it to the tree
	var upgrades = upgrade_list.player_upgrades
	for upgrade in upgrades:
		var button = Button.new()
		button.text = "%s" % [upgrade.upgrade_text]
		button.pressed.connect(Callable(add_upgrade).bind(upgrade))
		vbox.add_child(button)
	upgrades = upgrade_list.weapon_upgrades
	for upgrade in upgrades:
		var button = Button.new()
		button.text = "%s" % [upgrade.upgrade_text]
		button.pressed.connect(Callable(add_upgrade).bind(upgrade))
		vbox.add_child(button)

# add upgrade to stat_upgrades in player.gd
func add_upgrade(upgrade):
	if upgrade is BasePlayerUpgrade:
		if upgrade not in player.stat_upgrades:
			player.stat_upgrades.append(upgrade)
			print("Player Upgrade added")
		else:
			print("Player Upgrade already added")
	elif upgrade is BaseWeaponUpgrade:
		if upgrade not in weapon.bullet_upgrades:
			weapon.bullet_upgrades.append(upgrade)
			print("Weapon Upgrade added")
		else:
			print("Weapon Upgrade already added")

# resume game when button pressed and apply upgrades to player (TEMPORARY SOLUTION!!!)
func resume() -> void:
	get_tree().paused = false
	%UpgradeMenu.visible = not %UpgradeMenu.visible
	player.temp_apply_upgrades()
	weapon.temp_apply_upgrades()
