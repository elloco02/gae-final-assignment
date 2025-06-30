class_name Enemy

extends CharacterBody2D

@export var speed: int = 200
@export var sound_type: SoundEffectSettings.SOUND_EFFECT_TYPE = SoundEffectSettings.SOUND_EFFECT_TYPE.BAT

func _physics_process(_delta: float) -> void:
	move_and_slide()
