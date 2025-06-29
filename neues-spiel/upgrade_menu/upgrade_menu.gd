extends Control

@export var player: Player
@export var wave_manager: WaveManager
@onready var upgrade_list: UpgradeList = UpgradeList.new()
@onready var vbox = %VBoxContainer
@onready var weapon: Gun = player.gun

func _ready():
	%NextWaveButton.pressed.connect(start_next_wave)
	wave_manager.end_of_wave.connect(open_shop_menu)
	GameManager.on_state_change.connect(on_state_change)
	# create and add a button for 2 random upgrades from the upgrade_list
	var combined_upgrades = upgrade_list.weapon_upgrades + upgrade_list.player_upgrades
	var index_list: Array[int] = []
	for i in range(2):
		var random_index = get_random_index(index_list, combined_upgrades.size() - 1)
		index_list.append(random_index)
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

func get_random_index(index_list: Array[int], size: int) -> int:
	for i in range(10):
		var index: int = randi_range(0, size)
		if index_list.find(index) != -1:
			return index
	return 0

# start next wave
func start_next_wave() -> void:
	GameManager.game_state = GameManager.GAME_STATES.RUNNING
	wave_manager.start_wave()

# open shop menu on wave end
func open_shop_menu(wave: int) -> void:
	GameManager.game_state = GameManager.GAME_STATES.UPGRADEMENU

func on_state_change(value: GameManager.GAME_STATES) -> void:
	self.visible = GameManager.GAME_STATES.UPGRADEMENU == value
