extends Resource
class_name SoundEffectSettings

enum SOUND_EFFECT_TYPE {
	BAT,
	MUMIE,
	SCORPION,
	CACTUS,
	UI_BUTTON_PRESSED,
	PLAYER_HEAL,
	PLAYER_ATTACK,
	PLAYER_TAKE_DAMAGE,
	PLAYER_DIES,
	PLAYER_RELOAD,
	BACKGROUND_MUSIC_IN_GAME,
	BACKGROUND_MUSIC_IN_MENU,
	NONE
}

@export var type: SOUND_EFFECT_TYPE
@export var sound_effect: AudioStream
@export_range(-50, 50) var volume = 0
@export var bus: String = "Master"
