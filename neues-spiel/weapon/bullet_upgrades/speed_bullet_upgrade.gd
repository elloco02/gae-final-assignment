class_name SpeedBulletUpgrade
extends BaseBulletUpgrade

@export var speed_increase: float = 1.5

func apply_upgrade(bullet: Bullet):
	bullet.speed *= speed_increase
