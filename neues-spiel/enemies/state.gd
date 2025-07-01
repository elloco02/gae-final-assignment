class_name State

extends Node

@warning_ignore("unused_signal") # it needs to be defined here, but used only in extending classes
signal on_change(calling: State, new_state_name: String)

func enter():
	pass


func exit():
	pass


func _update(_delta: float):
	pass


func _physics_process(_delta: float):
	pass
