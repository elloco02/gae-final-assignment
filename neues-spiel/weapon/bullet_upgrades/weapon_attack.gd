class_name WeaponAttack
extends Resource

@export var current_ammo: int = 0:
	set(amount):
		current_ammo = amount
		ammo_change.emit(str(amount))


@export var damage: float = 1.0
@export var fire_rate: float = 0.0
@export var max_ammo: int = 10
@export var maximum_fire_rate: float = 1.0
@export var max_pierce: int = 1
@export var reload_time: float = 1.0
@export var speed: float = 300.0

signal ammo_change(String)
