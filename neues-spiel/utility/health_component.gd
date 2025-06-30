class_name HealthComponent
extends Node2D

@export var max_health: float = 100.0
@export var health_regeneration: float = 2.0

signal health_changed(current_health: float, max_health: float)
const MAIN_MENU_PATH := "res://main_menu/main_menu.tscn"

var health: float

func _ready() -> void:
	health = max_health
	_emit_if_player()

func damage(attack: Attack) -> void:
	if get_parent() is Player:
		AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.PLAYER_TAKE_DAMAGE)
	
	health = max(health - attack.attack_damage, 0.0)
	_emit_if_player()

	if health <= 0.0:
		_die()

func heal(amount: float) -> void:
	health = min(health + amount, max_health)
	_emit_if_player()

func regenerate() -> void:
	health = min(health + health_regeneration, max_health)
	_emit_if_player()

func _emit_if_player() -> void:
	if get_parent() is Player:
		emit_signal("health_changed", health, max_health)

func _die() -> void:
	if get_parent() is Player:
		AudioManager.create_2d_audio_at_location(global_position ,SoundEffectSettings.SOUND_EFFECT_TYPE.PLAYER_DIES)
		GameManager.end_game()	
	else:
		#TODO hier dann die particels abspielen lassen
		get_parent().queue_free()
