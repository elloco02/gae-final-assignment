extends Control

@export var player: Player
@export var wave_manager: WaveManager
@onready var gun: Gun = player.gun


func _process(_delta: float) -> void:
	# toggle stats menu with TAB key
	if Input.is_action_just_pressed("toggle stats window"):
		self.visible = not self.visible


func _ready() -> void:
	player.health_component.health_changed.connect(update_health_stat)
	wave_manager.start_of_wave.connect(update_all_stats)
	wave_manager.update_enemy_count.connect(update_enemy_count)


func update_health_stat(current_health: float, max_health: float) -> void:
	%Health.text = "Health: %d/%d" % [current_health, max_health]

func update_enemy_count() -> void:
	%EnemiesToKill.text = "Enemies to kill: %d" % [wave_manager.spawned_enemies]
	

func update_all_stats(_wave) -> void:
	%Wave.text = "Current wave: %d" % [wave_manager.wave]
	%EnemiesToKill.text = "Enemies to kill: %d" % [wave_manager.spawned_enemies]
	%Health.text = "Health: %d/%d" % [player.health_component.health, player.health_component.max_health]
	%HealthRegeneration.text = "Health Regeneration: %dHP/%dsec" % [player.health_component.health_regeneration, player.health_regeneration_time]
	%MovementSpeed.text = "Movement Speed: %d" % [player.speed]
	%BulletDamage.text = "Bullet Damage: %d" % [gun.weapon_attack.damage]
	%ReloadTime.text = "Reload Time: %dsec" % [gun.weapon_attack.reload_time]
