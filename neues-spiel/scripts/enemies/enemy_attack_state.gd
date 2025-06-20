class_name EnemyAttackState

extends State

@export var enemy: Enemy
@export var attack_duration: float = 1.0 # Time in seconds the attack is needs
@export var attack: EnemyAttack
@export var follow_state: EnemyFollowState

var attack_timer: float = 0.0


func enter():
	enemy.velocity = Vector2.ZERO
	attack.attack()
	attack_timer = attack_duration


func exit():
	pass


func _update(delta: float):
	attack_timer -= delta
	if attack_timer <= 0.0:
		on_change.emit(self, follow_state.name.to_lower())
