class_name MoveSpeedUpgrade
extends BasePlayerUpgrade

@export var speed_increase: int = 50

func apply_upgrade(player: Player):
	player.speed += speed_increase
