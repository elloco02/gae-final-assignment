extends Control


func _on_close_button_pressed() -> void:
	AudioManager.create_2d_audio_middle(SoundEffectSettings.SOUND_EFFECT_TYPE.UI_BUTTON_PRESSED)
	self.visible = false
