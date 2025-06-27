class_name EnemyFollowState

extends State

@export var enemy: Enemy
@export var attack_range: float = 10.0
@export var attack_state: EnemyAttackState

var players: Array[Player] = []


func enter():
	# get all palyers from the global group "players"
	var nodes = get_tree().get_nodes_in_group("players")
	for node in nodes:
		if node is Player:
			players.append(node)


func exit():
	players.clear()


func _physics_process(_delta: float):
	if players.size() == 0:
		return
		
	var closest_player = get_closest_player()
	if closest_player == null:
		return

	var direction = closest_player.position - enemy.position
	var player_hitbox: HitboxComponent
	for component in closest_player.get_children():
		if component is HitboxComponent:
			player_hitbox = component
			break
	
	var dir_name = enemy.get_direction_name(direction)
	enemy.animated_sprite.play("walk_" + dir_name)

	var player_rect = (player_hitbox.get_child(0) as CollisionShape2D).shape.get_rect()
	var player_size = Vector2(player_rect.size.x / 2, player_rect.size.y / 2)

	if direction.length() > attack_range + player_size.length():
		enemy.velocity = direction.normalized() * enemy.speed
	else:
		enemy.velocity = Vector2.ZERO
		on_change.emit(self, attack_state.name.to_lower())


func get_closest_player() -> Player:
	var closest_player: Player = null
	var closest_distance = INF

	for player in players:
		var distance = enemy.position.distance_to(player.position)
		if distance < closest_distance:
			closest_distance = distance
			closest_player = player

	return closest_player
