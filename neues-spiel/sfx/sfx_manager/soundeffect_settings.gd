extends Resource
class_name SoundEffectSettings

enum SOUND_EFFECT_TYPE {
	UI_BUTTON_PRESSED,
	BAT_ATTACK,
	MUMIE_ATTCK,
	SCORPION_ATTACK,
	PLAYER_HEAL,
	PLAYER_ATTACK,
	PLAYER_TAKE_DAMAGE,
	PLAYER_DIES,
	PLAYER_RELOAD,
	COLLECT_ITEM,
	BACKGROUND_MUSIC_IN_GAME,
	BACKGROUND_MUSIC_IN_MENU,
	PLAYER_SHIELDING,
	PLAYER_SLOWMOTION_LINE,
	NONE
}

@export var type: SOUND_EFFECT_TYPE
@export var sound_effect: AudioStream
@export_range(-50, 50) var volume = 0
@export var bus: String = "Master"
