class_name EnemyRangeAttack
extends EnemyAttack

@export var projectile: PackedScene
@export var spawn_marker: Marker2D


func _ready() -> void:
	if not projectile:
		push_error("Projectile must be set for EnemyRangeAttack")


func attack():
	var closest_player: Player = get_closest_player()
	if closest_player:
		var direction: Vector2 = (closest_player.global_position - spawn_marker.global_position).normalized()
		spawn_projectile(direction)
	else:
		print("No player found to attack.")


func get_closest_player() -> Player:
	var players = get_overlapping_bodies()
	for player in players:
		if player is Player:
			return player
	return null


func spawn_projectile(direction: Vector2) -> void:
	if not projectile:
		push_error("Projectile data is not set for EnemyRangeAttack")
		return

	var new_projectile: EnemyAttackProjectile = projectile.instantiate()
	new_projectile.direction = direction
	new_projectile.global_position = spawn_marker.global_position
	get_tree().current_scene.add_child(new_projectile)

	print("Spawned projectile in direction: ", direction)
