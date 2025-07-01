class_name HealthComponent
extends Node2D

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
	if get_parent() is Player:
		AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.PLAYER_TAKE_DAMAGE)
	health = max(health - attack.attack_damage, 0.0)


func heal(amount: float) -> void:
	if get_parent() is Player:
		AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.PLAYER_HEAL)
	health = min(health + amount, max_health)

func regenerate() -> void:
	heal(health_regeneration)


func _die() -> void:
	on_death.emit()
	if get_parent() is Player:
		AudioManager.create_2d_audio_at_location(global_position ,SoundEffectSettings.SOUND_EFFECT_TYPE.PLAYER_DIES)
		GameManager.end_game()	
	else:
		#TODO hier dann die particels abspielen lassen
		get_parent().queue_free()
