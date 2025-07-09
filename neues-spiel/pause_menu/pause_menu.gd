extends Control


func _ready() -> void:
	%ResumeButton.pressed.connect(resume)
	%MainMenu.pressed.connect(main_menu)
	GameManager.on_state_change.connect(open_pause_menu)


func open_pause_menu(value: GameManager.GAME_STATES) -> void:
	self.visible = GameManager.GAME_STATES.PAUSEMENU == value


# resume game
func resume() -> void:
	GameManager.game_state = GameManager.GAME_STATES.RUNNING


# go to main menu
func main_menu() -> void:
	ScoreManager.reset_score()
	resume()
	var main_menu_scene = load("res://main_menu/main_menu.tscn")
	SceneManager.change_scene_to(main_menu_scene)
	AudioManager.create_2d_audio_middle(SoundEffectSettings.SOUND_EFFECT_TYPE.BACKGROUND_MUSIC_IN_MENU)
