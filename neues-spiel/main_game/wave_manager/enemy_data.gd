class_name EnemyData


# Minimum wave at which this enemy can spawn
var start_wave: int = 1

# defines how both to which wave (dynamically) the enemy will be spawned and how much
# lower value -> earlier in the game and more often in the earlier waves
# higher value -> later in the game and nearly not spawned in the earlier waves
var strength: int = 1

# The scene to instantiate for this enemy
var scene: PackedScene


# single letter variable names to avoid warning with shadowing names
static func create(start: int, w: int, s: PackedScene) -> EnemyData:
	var data = EnemyData.new()
	data.start_wave = start
	data.strength = w
	data.scene = s
	return data


static func get_enemies_to_spawn(enemies: Dictionary[String, EnemyData], wave: int, wave_multiplier: float, difficulty: float) -> Array[EnemyData]:
	var enemies_to_spawn: Array[EnemyData] = []
	var rng = RandomNumberGenerator.new()

	var total_weight = wave * wave_multiplier * difficulty

	rng.seed = total_weight

	var allowed_enemies: Array[EnemyData] = get_allowed_enemies(enemies, wave)

	var remaining_weight = total_weight
	while remaining_weight > 0 and not allowed_enemies.is_empty():
		var random_index = rng.randi() % allowed_enemies.size()
		var enemy_data = allowed_enemies[random_index]

		if enemy_data.strength <= remaining_weight:
			enemies_to_spawn.append(enemy_data)
			remaining_weight -= enemy_data.strength
		else:
			# Remove the enemy if it cannot be spawned due to weight constraints
			allowed_enemies.remove_at(random_index)

	return enemies_to_spawn


static func get_allowed_enemies(enemies: Dictionary[String, EnemyData], wave: int) -> Array[EnemyData]:
	var allowed_enemies: Array[EnemyData] = []
	for enemy in enemies.values():
		if enemy.start_wave <= wave:
			allowed_enemies.append(enemy)

	if allowed_enemies.is_empty():
		push_error("No enemies available for the current wave: ", wave)
		return []

	return allowed_enemies
