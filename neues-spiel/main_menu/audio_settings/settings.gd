extends Control

@onready var main_menu_scene: PackedScene = preload("res://main_menu/main_menu.tscn")


func _on_main_menu_button_pressed() -> void:
	AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.UI_BUTTON_PRESSED) 
	SceneManager.change_scene_to(main_menu_scene)
