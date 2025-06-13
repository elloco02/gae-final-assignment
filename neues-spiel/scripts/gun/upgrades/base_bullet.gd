class_name BaseBullet
extends Resource

@export var upgrade_text : String = ""

# this is the function that is later called when firing a bullet
func apply_upgrade(bullet: Bullet):
	# this does nothing by default
	pass
