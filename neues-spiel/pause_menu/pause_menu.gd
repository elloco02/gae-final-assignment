extends Control

# @onready var game_level: PackedScene = preload("res://utility/level.tscn")

func _ready() -> void:
	%ResumeButton.pressed.connect(resume)
	%MainMenu.pressed.connect(main_menu)
# resume game
func resume() -> void:
	get_tree().paused = false
	self.visible = not self.visible


func main_menu() -> void:
	ScoreManager.reset_score()
	get_tree().paused = false
	self.visible = false
	var main_menu_scene = load("res://main_menu/main_menu.tscn")
	SceneManager.change_scene_to(main_menu_scene)
