class_name SpeedBulletUpgrade
extends BaseBullet

@export var speed_increase: float = 1.5

func apply_upgrade(bullet: Bullet):
	bullet.speed *= speed_increase
