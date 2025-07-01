class_name EnemyMeleeAttack
extends EnemyAttack

@export var attack_data: Attack = Attack.new()


func attack():
	var players = get_overlapping_bodies()
	for player in players:
		if player is HitboxComponent:
			var hitbox: HitboxComponent = player as HitboxComponent
			hitbox.damage(attack_data)
