# war zum testen als aufsammelbares Item in der map, kann (zusammen mit
# "player_upgrade.tscn" gelöscht werden, wenn wir keine aufsammelbaren Items
# haben wollen

@tool
extends Area2D

@export var upgrade_label: Label
#@export var sprite : Sprite2D
@export var player_upgrade: BasePlayerUpgrade:
	set(val):
		player_upgrade = val
		needs_update = true

# Used when editing to denote that the sprite has changed and needs updating
@export var needs_update: bool = false

func _ready() -> void:
	body_entered.connect(on_body_entered)
	#sprite.texture = bullet_strategy.texture
	upgrade_label.text = player_upgrade.upgrade_text

func _process(_delta: float) -> void:
	# This is run only when we're editing the scene
	# It updates the texture of the sprite when we replace the upgrade strategy
	if Engine.is_editor_hint():
		if needs_update:
			#sprite.texture = bullet_strategy.texture
			upgrade_label.text = player_upgrade.upgrade_text
			needs_update = false

# add the upgrade to the player stats and remove item from map
func on_body_entered(body: PhysicsBody2D):
	if body is Player:
		player_upgrade.apply_upgrade(body)
		queue_free()
