class_name Gun
extends Node2D

@export var current_ammo: int = 0:
	set(amount):
		current_ammo = amount
		ammo_label.text = str(amount)
@export var max_ammo: int = 10
@export var fire_rate: float = 0.0
@export var maximum_fire_rate: float = 1.0
@export var reload_time: float = 1.0
@onready var ammo_label: Label = $AmmoLabel
@onready var muzzle: Marker2D = $Marker2D
@onready var player: Player = get_parent()
@onready var reload_timer: Timer = $ReloadTimer
@onready var shoot_timer: Timer = $ShootTimer

var bullet = preload("res://weapon/bullet.tscn")
var bullet_upgrades: Array[BaseBulletUpgrade] = []

func _ready() -> void:
	# connect reload_timer signal to refill_ammo function, also call it at the start
	reload_timer.timeout.connect(refill_ammo)
	refill_ammo()

func _physics_process(_delta: float) -> void:
	# rotate gun towards mouse position
	look_at(get_global_mouse_position())
	# flip sprite when looking to the left of the character
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1

	# check inputs
	# do nothing when currently reloading
	if reload_timer.time_left > 0:
		return

	# shoot a bullet if current_ammo is greater than 0
	if Input.is_action_just_pressed("shoot"):
		print("current_ammo:", current_ammo)
		if current_ammo > 0:
			print("Shoot")
			shoot_bullet()
	# reload weapon if not shooting and current_ammo is not equal to max_ammo
	elif Input.is_action_just_pressed("reload") and current_ammo < max_ammo:
		print("Reload")
		reload_ammo()

# shoot a bullet if gun is ready to fire again
func shoot_bullet() -> void:
	# do nothing if shoot_timer is running
	if shoot_timer.time_left > 0:
		return
		
	var shoot_direction = Vector2.RIGHT.rotated(rotation)
	player.play_shoot_animation(shoot_direction)
	
	# shoot bullet with all of its upgrades
	current_ammo -= 1
	var bullet_instance: Bullet = bullet.instantiate()
	get_tree().root.add_child(bullet_instance)
	bullet_instance.global_position = self.muzzle.global_position
	bullet_instance.rotation = self.rotation
	# loop over all bullet upgrades and apply
	for upgrade in bullet_upgrades:
		upgrade.apply_upgrade(bullet_instance)
	# start timer for fire rate, the higher the fire_rate, the faster it shoots
	shoot_timer.start(maximum_fire_rate - fire_rate)

# reload the ammo visually
func reload_ammo() -> void:
	# start reload timer
	reload_timer.start(reload_time)
	# TODO: add some animation for the reload process

# fills the current_ammo after reload_timer finishes and sends a signal
func refill_ammo() -> void:
	current_ammo = max_ammo
