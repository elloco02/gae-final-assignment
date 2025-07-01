class_name EnemyMeleeAttack
extends EnemyAttack

@export var attack_data: Attack = Attack.new()

func _ready() -> void:
	if not attack_data:
		push_error("Attack data must be set for EnemyMeleeAttack")
		return


func attack():
	var players = get_overlapping_areas()
	for player in players:
		if player is HitboxComponent:
			var hitbox: HitboxComponent = player as HitboxComponent
			hitbox.damage(attack_data)
