extends Control

@export var player: Player
@onready var vbox = %VBoxContainer
@onready var upgrade_list: UpgradeList = UpgradeList.new()

func _ready():
	%ResumeButton.pressed.connect(resume)
	# create a button for each upgrade in upgrade_list and add it to the tree
	var upgrades: Array[BasePlayerUpgrade] = upgrade_list.upgrades
	for upgrade in upgrades:
		var button = Button.new()
		button.text = "+50 Movespeed" #"%s" % [upgrade.name]
		button.pressed.connect(Callable(add_upgrade).bind(upgrade))
		vbox.add_child(button)

# add upgrade to stat_upgrades in player.gd
func add_upgrade(upgrade: BasePlayerUpgrade):
	player.stat_upgrades.append(upgrade)
	print("Upgrade added")

# resume game when button pressed and apply upgrades to player (TEMPORARY SOLUTION!!!)
func resume() -> void:
	get_tree().paused = false
	%UpgradeMenu.visible = not %UpgradeMenu.visible
	player.temp_apply_upgrades()
