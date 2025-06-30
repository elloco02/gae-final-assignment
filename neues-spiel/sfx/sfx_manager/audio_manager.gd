extends Node

var sound_effect_dict = {}
var current_music_type: SoundEffectSettings.SOUND_EFFECT_TYPE = SoundEffectSettings.SOUND_EFFECT_TYPE.BACKGROUND_MUSIC_IN_MENU

@export var sound_effect_settings: Array[SoundEffectSettings]

func _ready() -> void:
	for sound_effect_setting: SoundEffectSettings in sound_effect_settings:
		sound_effect_dict[sound_effect_setting.type] = sound_effect_setting
	create_2d_audio_at_location(Vector2(0, 0), SoundEffectSettings.SOUND_EFFECT_TYPE.BACKGROUND_MUSIC_IN_MENU)


func create_2d_audio_at_location(location: Vector2, type: SoundEffectSettings.SOUND_EFFECT_TYPE):
	if sound_effect_dict.has(type) and not type == SoundEffectSettings.SOUND_EFFECT_TYPE.NONE:
		# Background Music
		if type == SoundEffectSettings.SOUND_EFFECT_TYPE.BACKGROUND_MUSIC_IN_MENU:
			stop_music(SoundEffectSettings.SOUND_EFFECT_TYPE.BACKGROUND_MUSIC_IN_GAME)
			current_music_type = SoundEffectSettings.SOUND_EFFECT_TYPE.BACKGROUND_MUSIC_IN_MENU

		elif type == SoundEffectSettings.SOUND_EFFECT_TYPE.BACKGROUND_MUSIC_IN_GAME:
			stop_music(SoundEffectSettings.SOUND_EFFECT_TYPE.BACKGROUND_MUSIC_IN_MENU)
			current_music_type = SoundEffectSettings.SOUND_EFFECT_TYPE.BACKGROUND_MUSIC_IN_GAME

		var sound_effect_setting: SoundEffectSettings = sound_effect_dict[type]
		var new_2D_audio = AudioStreamPlayer2D.new()
		add_child(new_2D_audio)

		new_2D_audio.name = str(sound_effect_setting.type)
		new_2D_audio.position = location
		new_2D_audio.stream = sound_effect_setting.sound_effect
		new_2D_audio.volume_db = sound_effect_setting.volume
		new_2D_audio.finished.connect(new_2D_audio.queue_free)
		new_2D_audio.bus = sound_effect_setting.bus

		new_2D_audio.play()
	elif type != SoundEffectSettings.SOUND_EFFECT_TYPE.NONE:
		push_error("Audio Manager Failed to find setting for type: ", type)


func stop_music(type: SoundEffectSettings.SOUND_EFFECT_TYPE):
	for child: AudioStreamPlayer2D in get_children():
		if child.name == str(type):
			child.stop()
			child.queue_free()


func get_current_music_type():
	return current_music_type
