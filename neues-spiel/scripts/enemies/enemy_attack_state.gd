class_name EnemyAttackState

extends State

@export var enemy: Enemy
@export var attack_duration: float = 1.0 # Time in seconds the attack is needs

var attack_timer: float = 0.0

# should be implemented in the appropriate script
func attack():
    pass


func enter():
    enemy.velocity = Vector2.ZERO
    attack_timer = attack_duration
    attack()


func exit():
    pass


func _update(delta: float):
    attack_timer -= delta
    if attack_timer <= 0.0:
        on_change.emit(self, "follow")