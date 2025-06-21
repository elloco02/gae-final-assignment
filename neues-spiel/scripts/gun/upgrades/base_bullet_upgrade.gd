class_name BaseBulletUpgrade
extends Resource

@export var upgrade_text: String = ""

# this is the function that is later called when firing a bullet
func apply_upgrade(_bullet: Bullet):
	# this does nothing by default
	pass
