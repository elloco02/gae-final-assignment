extends Node

@export var sound_effect_settings: Array[SoundEffectSettings]
var sound_effect_dict = {}
var middle_audio_player: AudioStreamPlayer2D = null


func _ready() -> void:
	for sound_effect_setting: SoundEffectSettings in sound_effect_settings:
		sound_effect_dict[sound_effect_setting.type] = sound_effect_setting
	create_2d_audio_middle(SoundEffectSettings.SOUND_EFFECT_TYPE.BACKGROUND_MUSIC_IN_MENU)


func play_enemy_attack_sound(enemy: Enemy):
	var effect_type = SoundEffectSettings.SOUND_EFFECT_TYPE.keys()[enemy.type]
	if effect_type != null:
		AudioManager.create_2d_audio_at_location(enemy.global_position, effect_type.key)
	else:
		push_warning("Kein Soundeffekt für Enemy-Typ: %s" % enemy.type)


func create_2d_audio_middle(type: SoundEffectSettings.SOUND_EFFECT_TYPE):
	if middle_audio_player:
		middle_audio_player.queue_free()

	var player = _get_audio_stream_player(type)
	if player == null:
		return

	middle_audio_player = player
	add_child(player)
	player.play()


func create_2d_audio_at_location(location: Vector2, type: SoundEffectSettings.SOUND_EFFECT_TYPE):
	var player = _get_audio_stream_player(type)
	if player == null:
		return

	player.position = location
	add_child(player)
	player.play()


func _get_audio_stream_player(type: SoundEffectSettings.SOUND_EFFECT_TYPE) -> AudioStreamPlayer2D:
	if sound_effect_dict.has(type) and not type == SoundEffectSettings.SOUND_EFFECT_TYPE.NONE:
		var new_2D_audio = AudioStreamPlayer2D.new()

		# Background Music
		if type == SoundEffectSettings.SOUND_EFFECT_TYPE.BACKGROUND_MUSIC_IN_MENU || type == SoundEffectSettings.SOUND_EFFECT_TYPE.BACKGROUND_MUSIC_IN_GAME:
			stop_music(SoundEffectSettings.SOUND_EFFECT_TYPE.BACKGROUND_MUSIC_IN_GAME)
			stop_music(SoundEffectSettings.SOUND_EFFECT_TYPE.BACKGROUND_MUSIC_IN_MENU)

		var sound_effect_setting: SoundEffectSettings = sound_effect_dict[type]

		new_2D_audio.name = str(sound_effect_setting.type).to_lower()
		new_2D_audio.stream = sound_effect_setting.sound_effect
		new_2D_audio.volume_db = sound_effect_setting.volume
		new_2D_audio.bus = sound_effect_setting.bus
		new_2D_audio.finished.connect(handle_finish(new_2D_audio, type))

		return new_2D_audio

	elif type != SoundEffectSettings.SOUND_EFFECT_TYPE.NONE:
		push_error("Audio Manager Failed to find setting for type: ", type)

	return null


func handle_finish(audio: AudioStreamPlayer2D, type: SoundEffectSettings.SOUND_EFFECT_TYPE):
	return func handler():
		if type == SoundEffectSettings.SOUND_EFFECT_TYPE.BACKGROUND_MUSIC_IN_GAME || type == SoundEffectSettings.SOUND_EFFECT_TYPE.BACKGROUND_MUSIC_IN_MENU:
			audio.play()
		else:
			audio.queue_free()


func stop_music(type: SoundEffectSettings.SOUND_EFFECT_TYPE):
	for child: AudioStreamPlayer2D in get_children():
		if child.name.to_lower() == str(type).to_lower():
			child.stop()
			child.queue_free()


func _process(_delta: float) -> void:
	if middle_audio_player:
		var camera = get_viewport().get_camera_2d()
		if camera:
			middle_audio_player.global_position = camera.global_position
		else:
			middle_audio_player.global_position = get_viewport().get_visible_rect().position + (get_viewport().get_visible_rect().size / 2)
