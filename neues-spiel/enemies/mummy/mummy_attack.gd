extends EnemyAttack

var attack_data: Attack = Attack.new()


func attack():
	var players = get_overlapping_bodies()
	for player in players:
		if player is Player:
			var hitbox: HitboxComponent = self.get_player_hitbox(player)
			if hitbox:
				hitbox.damage(attack_data)
				print("Player hit by Mummy attack!")
