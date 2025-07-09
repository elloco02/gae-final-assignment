class_name MainMenu
extends Control

@onready var start_button: Button = $CanvasLayer/MarginContainer/HBoxContainer/VBoxContainer/StartButton
@onready var frame: Frame = $CanvasLayer/Frame
@onready var instructions: Control = $CanvasLayer/Instructions
@onready var game_level: PackedScene = preload("res://main_game/level.tscn")


func _ready() -> void:
	frame.visible = false
	start_button.pressed.connect(_on_start_button_pressed)


func _on_start_button_pressed() -> void:
	AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.UI_BUTTON_PRESSED)
	AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.BACKGROUND_MUSIC_IN_GAME)
	ScoreManager.reset_score()
	SceneManager.change_scene_to(game_level)


func _on_scoreboard_button_pressed() -> void:
	AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.UI_BUTTON_PRESSED) 
	var scoreboard_scene = load("res://score_board/scoreboard.tscn")
	SceneManager.change_scene_to(scoreboard_scene)


func _on_credits_button_pressed() -> void:
	AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.UI_BUTTON_PRESSED) 
	frame.visible = true


func _on_options_button_pressed() -> void:
	AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.UI_BUTTON_PRESSED) 
	var options_scene = load("res://main_menu/audio_settings/settings.tscn")
	SceneManager.change_scene_to(options_scene)


func _on_instructions_button_pressed() -> void:
	AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.UI_BUTTON_PRESSED) 
	instructions.visible = true
