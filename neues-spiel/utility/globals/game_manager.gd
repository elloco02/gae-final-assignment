extends Node

@onready var player_death_scene: PackedScene = preload("res://death_screen/death_screen.tscn")

var difficulty : float = 1.0 : 
	set(value): 
		difficulty = value
		change_difficulty.emit(value)

signal change_difficulty(float)

func end_game():
	await SceneManager.change_scene_to(player_death_scene)
