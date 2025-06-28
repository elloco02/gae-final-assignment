extends Control

@export var player: Player
@onready var upgrade_list: UpgradeList = UpgradeList.new()
@onready var vbox = %VBoxContainer
@onready var weapon: Gun = player.gun

func _ready():
	%NextWaveButton.pressed.connect(start_next_wave)
	# create and add a button for 2 random upgrades from the upgrade_list
	var combined_upgrades = upgrade_list.weapon_upgrades + upgrade_list.player_upgrades
	for i in range(2):
		var random_index = randi_range(0, combined_upgrades.size() - 1)
		var button = Button.new()
		var upgrade = combined_upgrades[random_index]
		print("random uprade index: ", random_index)
		button.text = "%s" % [upgrade.upgrade_text]
		button.pressed.connect(Callable(add_upgrade).bind(upgrade, button))
		vbox.add_child(button)

# add upgrade to stat_upgrades in player.gd
func add_upgrade(upgrade, button: Button):
	match upgrade:
		BasePlayerUpgrade:
			if upgrade not in player.stat_upgrades:
				player.stat_upgrades.append(upgrade)
				print("Player Upgrade added")
			else:
				print("Player Upgrade already added")
		BaseWeaponUpgrade:
			if upgrade not in weapon.bullet_upgrades:
				weapon.bullet_upgrades.append(upgrade)
				print("Weapon Upgrade added")
			else:
				print("Weapon Upgrade already added")
	button.disabled = true

# start next wave
func start_next_wave() -> void:
	get_tree().paused = false
	self.visible = not self.visible
	#WaveManager.startWave() # uncomment when wave management is implemented
