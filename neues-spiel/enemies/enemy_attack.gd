class_name EnemyAttack
extends Area2D


func attack():
	# This function needs to be implemented by subclasses
	pass


func get_player_hitbox(player: Player) -> HitboxComponent:
	# Get the hitbox component of the player
	for component in player.get_children():
		if component is HitboxComponent:
			return component
	return null
