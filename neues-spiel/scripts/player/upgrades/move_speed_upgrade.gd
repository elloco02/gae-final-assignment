class_name MoveSpeedUpgrade
extends BasePlayerUpgrade

@export var speed_increase: float = 50

func apply_upgrade(player: Player):
	player.speed += speed_increase
