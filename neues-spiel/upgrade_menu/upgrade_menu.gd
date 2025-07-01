extends Control

@export var player: Player
@export var wave_manager: WaveManager
@onready var upgrade_list: UpgradeList = UpgradeList.new()
@onready var vbox = %VBoxContainer
@onready var weapon: Gun = player.gun
var available_upgrades: int = 3
var pickable_upgrades: int = 1
var taken_upgrades: int = 0

func _ready():
	%NextWaveButton.pressed.connect(start_next_wave)
	wave_manager.end_of_wave.connect(open_shop_menu)
	GameManager.on_state_change.connect(on_state_change)
	# create and add a buttons for available_upgrades amount of upgrades, randomly picked
	pick_random_upgrades()

# combine all upgrades from UpgradeList class into one list and create an amount
# equal to available_upgrades for the player to choose 1 from
func pick_random_upgrades() -> void:
	var combined_upgrades = upgrade_list.weapon_upgrades + upgrade_list.player_upgrades
	var index_list: Array[int] = []
	print("combined_upgrades size: ", combined_upgrades.size())
	# generate available_upgrades amount of options for the player to choose from
	for i in range(available_upgrades):
		# get a random index to pick one of the upgrades
		var random_index = get_random_index(index_list, combined_upgrades.size() - 1)
		print("random uprade index: ", random_index)
		# add random_index to an array to decrease the chance of the same upgrade being picked again 
		index_list.append(random_index)
		# create and add button that applies the upgrade on click
		var button = Button.new()
		button.add_to_group("upgrade")
		var upgrade = combined_upgrades[random_index]
		button.text = "%s" % [upgrade.upgrade_text]
		button.pressed.connect(Callable(add_upgrade).bind(upgrade, button))
		vbox.add_child(button)

# add upgrade to the corresponding game element (player or weapon)
func add_upgrade(upgrade, button: Button):
	if upgrade is BasePlayerUpgrade:
		player.add_upgrade(upgrade)
		print("Player Upgrade %s added" % [upgrade.upgrade_text])
	elif upgrade is BaseWeaponUpgrade:
		weapon.add_upgrade(upgrade)
		print("Weapon Upgrade %s added" % [upgrade.upgrade_text])
	# disable all other upgrades after picking an amount equal to pickable_upgrades
	taken_upgrades += 1
	if taken_upgrades == pickable_upgrades:
		# reset counter for next wave
		taken_upgrades = 0
		for child in vbox.get_children():
			if child is Button and child.is_in_group("upgrade") and not child.disabled:
				child.disabled = true
	# only disable button for picked upgrade
	else:
		button.disabled = true

func get_random_index(index_list: Array[int], list_size: int) -> int:
	for i in range(10):
		var index: int = randi_range(0, list_size)
		if index_list.find(index) == -1:
			return index
	return 0

# start next wave
func start_next_wave() -> void:
	GameManager.game_state = GameManager.GAME_STATES.RUNNING
	wave_manager.start_wave()
	# reset upgrades in vbox and add new random upgrades
	for child in vbox.get_children():
		if child is Button and child.is_in_group("upgrade"):
			child.queue_free()
	pick_random_upgrades()

# open shop menu on wave end
func open_shop_menu(_wave: int) -> void:
	GameManager.game_state = GameManager.GAME_STATES.UPGRADEMENU

func on_state_change(value: GameManager.GAME_STATES) -> void:
	self.visible = GameManager.GAME_STATES.UPGRADEMENU == value
