extends Control

@onready var score_label: Label = $ScoreLabel
@onready var username_input: LineEdit = $MarginContainer/VBoxContainer/UsernameInput
@onready var main_menu_scene: PackedScene = preload("res://main_menu/main_menu.tscn")
@onready var score_board_scene: PackedScene = preload("res://score_board/scoreboard.tscn")


func _ready() -> void:
	score_label.text = "Your score: " + str(ScoreManager.score)


func _on_main_menu_button_pressed() -> void:
	SceneManager.change_scene_to(main_menu_scene)


func _on_submit_button_pressed() -> void:
	var username = username_input.text
	ScoreManager.save_highscore(username)
	ScoreManager.reset_score()
	SceneManager.change_scene_to(score_board_scene)
