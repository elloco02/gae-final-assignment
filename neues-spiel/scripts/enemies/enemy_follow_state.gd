class_name EnemyFollowState

extends State

@export var enemy: Enemy
@export var attack_range: float = 10.0

var players: Array[Player] = []


func enter():
    var nodes = get_tree().get_nodes_in_group("players")
    for node in nodes:
        if node is Player:
            players.append(node)


func _exit_tree():
    players.clear()


func _physics_process(_delta: float):
    if players.size() == 0:
        return

    var closest_player = get_closest_player()
    if closest_player == null:
        return

    var direction = closest_player.position - enemy.position
    if direction.length() > attack_range:
        enemy.velocity = direction.normalized() * enemy.speed
    else:
        enemy.velocity = Vector2.ZERO
        on_change.emit(self, "attack")


func get_closest_player() -> Player:
    var closest_player: Player = null
    var closest_distance = INF

    for player in players:
        var distance = enemy.position.distance_to(player.position)
        if distance < closest_distance:
            closest_distance = distance
            closest_player = player

    return closest_player