class_name MainMenu
extends Control

@onready var start_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/StartButton
@onready var game_level: PackedScene = preload("res://utility/level.tscn")

func _ready() -> void:
	start_button.pressed.connect(_on_start_button_pressed)

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(game_level)
