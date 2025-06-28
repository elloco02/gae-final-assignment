class_name MainMenu
extends Control

@onready var start_button: Button = $CanvasLayer/MarginContainer/HBoxContainer/VBoxContainer/StartButton
@onready var frame: Frame = $CanvasLayer/Frame
@onready var game_level: PackedScene = preload("res://utility/level.tscn")

func _ready() -> void:
	frame.visible = false
	start_button.pressed.connect(_on_start_button_pressed)

func _on_start_button_pressed() -> void:
	ScoreManager.reset_score()
	SceneManager.change_scene_to(game_level)


func _on_scoreboard_button_pressed() -> void:
	var scoreboard_scene = load("res://score_board/scoreboard.tscn")
	SceneManager.change_scene_to(scoreboard_scene)


func _on_credits_button_pressed() -> void:
	frame.visible = true
