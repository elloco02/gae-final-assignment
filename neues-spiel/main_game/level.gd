extends Node2D

func _process(_delta: float) -> void:
	# pause game and show pause menu when pressing ESC
	if Input.is_action_just_pressed("pause game") and GameManager.game_state == GameManager.GAME_STATES.RUNNING:
		GameManager.game_state = GameManager.GAME_STATES.PAUSEMENU
