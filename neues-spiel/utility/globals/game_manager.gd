extends Node

@onready var player_death_scene: PackedScene = preload("res://death_screen/death_screen.tscn")

func end_game():
	await SceneManager.change_scene_to(player_death_scene)
