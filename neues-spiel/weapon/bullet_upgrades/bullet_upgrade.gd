# war zum testen als aufsammelbares Item in der map, kann (zusammen mit
# "bullet_upgrade.tscn" gelöscht werden, wenn wir keine aufsammelbaren Items
# haben wollen
@tool
extends Area2D

@export var upgrade_label: Label
#@export var sprite : Sprite2D
@export var bullet_upgrade: BaseWeaponUpgrade:
	set(val):
		bullet_upgrade = val
		needs_update = true

# Used when editing to denote that the sprite has changed and needs updating
@export var needs_update: bool = false

func _ready() -> void:
	body_entered.connect(on_body_entered)
	#sprite.texture = bullet_upgrade.texture
	upgrade_label.text = bullet_upgrade.upgrade_text

func _process(_delta: float) -> void:
	# This is run only when we're editing the scene
	# It updates the texture of the sprite when we replace the upgrade strategy
	if Engine.is_editor_hint():
		if needs_update:
			#sprite.texture = bullet_upgrade.texture
			upgrade_label.text = bullet_upgrade.upgrade_text
			needs_update = false

# add the upgrade to the gun bullet_upgrades list and remove item from map
func on_body_entered(body: PhysicsBody2D):
	if body is Player:
		body.gun.bullet_upgrades.append(bullet_upgrade)
		queue_free()
