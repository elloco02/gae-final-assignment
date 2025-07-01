class_name EnemyAttackState

extends State

@export var enemy: Enemy
@export var attack_duration: float = 1.0 # Time in seconds the attack is needs
@export var attack: EnemyAttack
@export var follow_state: EnemyFollowState

var attack_timer: float = 0.0
var players: Array[Player] = []

func enter():
	var nodes = get_tree().get_nodes_in_group("players")
	for node in nodes:
		if node is Player:
			players.append(node)

	if players.size() == 0:
		return

	var closest_player = get_closest_player()
	if closest_player == null:
		return

	var direction = closest_player.global_position - enemy.global_position
	var dir_name = enemy.get_direction_name(direction)
	enemy.animated_sprite.play("attack_" + dir_name)
	enemy.velocity = Vector2.ZERO
	attack.attack()
	attack_timer = attack_duration	
	AudioManager.create_2d_audio_at_location(enemy.global_position, enemy.sound_type)

func exit():
	pass


func _update(delta: float):
	attack_timer -= delta
	if attack_timer <= 0.0:
		on_change.emit(self, follow_state.name.to_lower())


func get_closest_player() -> Player:
	var closest_player: Player = null
	var closest_distance = INF

	for player in players:
		var distance = enemy.position.distance_to(player.position)
		if distance < closest_distance:
			closest_distance = distance
			closest_player = player

	return closest_player
