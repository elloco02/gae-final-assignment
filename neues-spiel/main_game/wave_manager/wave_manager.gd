class_name WaveManager

extends Node2D


# 3 Problems to solve:
# 1: Where to spawn enemies? :check:
# 2: When to spawn enemies?
# 3: What and how many enemies to spawn?
@export var map: TileMapLayer
@export var player: Player
@export var wave: int = 1
@export var wave_multiplier: float = 5
@export var time_per_wave: float = 30.0 # in seconds

var camera: Camera2D
var map_bounds: Rect2
var tile_size: Vector2i

var spawned_enemies: int:
	set(value):
		if value <= 0:
			spawned_enemies = 0
			end_wave()
		else:
			spawned_enemies = value

signal end_of_wave(int)
signal start_of_wave(int)

var enemies: Dictionary[String, EnemyData] = {
	"mummy": EnemyData.create(1, 1, preload("res://enemies/mummy/mummy.tscn")),
	"bat": EnemyData.create(2, 3, preload("res://enemies/bat/bat.tscn")),
	"cactus_dude": EnemyData.create(4, 6, preload("res://enemies/cactus_dude/cactus_dude.tscn")),
	"scorpion": EnemyData.create(6, 10, preload("res://enemies/scorpion/scorpion.tscn")),
}

func _ready():
	for child in player.get_children():
		if child is Camera2D:
			camera = child
			break

	if not camera:
		push_error("Camera2D not found in player children. Please ensure the player has a Camera2D child node.")

	tile_size = map.tile_set.tile_size

	# depends on that a tile is square and not rectangle
	map_bounds = map.get_used_rect()
	map_bounds.size.x = tile_size.x * map_bounds.size.x
	map_bounds.size.y = tile_size.y * map_bounds.size.y
	map_bounds.position = map.global_position

	start_wave()


func start_wave():
	start_of_wave.emit(wave)

	var enemies_to_spawn: Array[EnemyData] = EnemyData.get_enemies_to_spawn(enemies, wave, wave_multiplier, GameManager.difficulty)
	spawned_enemies += enemies_to_spawn.size()

	var spawn_interval = time_per_wave / spawned_enemies if spawned_enemies > 0 else 1.0
	await get_tree().create_timer(spawn_interval).timeout

	for enemy in enemies_to_spawn:
		var enemy_instance: Enemy = enemy.scene.instantiate()
		if not enemy_instance:
			push_error("Failed to instantiate enemy scene: ", enemy.scene)
			continue

		enemy_instance.global_position = to_global(EnemySpawnLocation.get_spawn_position(get_camera_rect(), map_bounds))
		enemy_instance.health_component.on_death.connect(on_enemy_death)

		get_tree().current_scene.add_child.call_deferred(enemy_instance)

		print("Spawned enemy: ", enemy_instance, " at position: ", enemy_instance.global_position)

		await get_tree().create_timer(spawn_interval).timeout
		while GameManager.game_state != GameManager.GAME_STATES.RUNNING:
			await get_tree().create_timer(0.1).timeout


func get_camera_rect() -> Rect2:
	var rect = camera.get_viewport_rect()
	rect.position = camera.global_position
	rect.size = Vector2(
		(rect.size.x / camera.zoom.x) + tile_size.x,
		(rect.size.y / camera.zoom.y) + tile_size.y
	)
	rect.position.x = rect.position.x - (rect.size.x / 2)
	rect.position.y = rect.position.y - (rect.size.y / 2)
	return rect


func on_enemy_death():
	spawned_enemies -= 1


func end_wave():
	end_of_wave.emit(wave)
	wave += 1
