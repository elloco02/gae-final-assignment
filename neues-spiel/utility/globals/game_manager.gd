extends Node

enum GAME_STATES {PAUSEMENU, RUNNING, UPGRADEMENU}

@onready var player_death_scene: PackedScene = preload("res://death_screen/death_screen.tscn")
var game_state: GAME_STATES = GAME_STATES.RUNNING:
	set(value):
		print("game_state: ", value)
		game_state = value
		on_state_change.emit(value)
		if value == GAME_STATES.RUNNING:
			get_tree().paused = false
		else:
			get_tree().paused = true


signal on_state_change(GAME_STATES)

var difficulty : float = 1.0 : 
	set(value): 
		difficulty = value
		change_difficulty.emit(value)

signal change_difficulty(float)

func end_game():
	await SceneManager.change_scene_to(player_death_scene)
