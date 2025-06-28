class_name Bullet
extends CharacterBody2D

@export var hitbox_component: HitboxComponent
var current_pierce_count: int = 0
var damage: float
var max_pierce: int
var speed: float
var weapon_attack: WeaponAttack

func _ready():
	if hitbox_component:
		hitbox_component.hit_enemy.connect(on_enemy_hit)
	# get bullet stats
	damage = weapon_attack.damage
	max_pierce = weapon_attack.max_pierce
	speed = weapon_attack.speed
	print("Bullet speed: ", speed)

# move bullet in shooting direction and check collisions
func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	velocity = direction * speed
	var collider = move_and_collide(velocity * delta)
	# collision with Enemy
	if collider and collider is Enemy:
		on_enemy_hit()

# when Enemy is hit
func on_enemy_hit():
	# increase current_pierce_count
	current_pierce_count += 1
	# destroy bullet when max_piece reached
	if current_pierce_count >= max_pierce:
		queue_free()
