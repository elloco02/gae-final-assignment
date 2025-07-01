class_name HealthComponent
extends Node2D

var vfx_scene = preload("res://vfx/death_particles.tscn")

@export var max_health: float = 100.0:
	set(val):
		max_health = val
		print("Max health set to: ", max_health)
		health = min(health, max_health)
		health_changed.emit(health, val)


@export var health_regeneration: float = 2.0

signal health_changed(current_health: float, max_health: float)
const MAIN_MENU_PATH := "res://main_menu/main_menu.tscn"

var health: float = max_health:
	set(val):
		health = val
		if health < 0.0:
			health = 0.0
		elif health > max_health:
			health = max_health

		health_changed.emit(val, max_health)
		if val <= 0.0:
			_die()


signal on_death


func _ready():
	health = max_health


func damage(attack: Attack) -> void:
	print("HealthComponent: damage called with attack: ", attack)
	if get_parent() is Player:
		AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.PLAYER_TAKE_DAMAGE)
	health = max(health - attack.damage, 0.0)


func heal(amount: float) -> void:
	if get_parent() is Player:
		AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.PLAYER_HEAL)
	health = min(health + amount, max_health)

func regenerate() -> void:
	heal(health_regeneration)


func _die() -> void:
	on_death.emit()
	if get_parent() is Player:
		AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.PLAYER_DIES)
		GameManager.end_game()
	else:
		ScoreManager.add_score(10)
		_spawn_death_vfx(global_position)
		get_parent().queue_free()


func _spawn_death_vfx(death_vfx_position: Vector2) -> void:
	var vfx_instance = vfx_scene.instantiate()
	vfx_instance.global_position = death_vfx_position
	get_tree().current_scene.add_child(vfx_instance)
	# TODO check if enemy sprite becomes invisible before particles are played
	vfx_instance.emitting = true

	var lifetime = vfx_instance.lifetime
	await get_tree().create_timer(lifetime).timeout
	vfx_instance.queue_free()
