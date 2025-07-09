class_name Bullet
extends Area2D

@export var weapon_attack: WeaponAttack
var current_pierce_count: int = 0


func _ready():
	self.area_entered.connect(_on_area_entered)
	print("Bullet speed: ", weapon_attack.speed)


# move bullet in shooting direction and check collisions
func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	var velocity = direction * weapon_attack.speed
	position += velocity * delta


# when Enemy is hit
func _on_area_entered(area: Area2D):
	if not area is HitboxComponent:
		return
		
	var hitbox: HitboxComponent = area as HitboxComponent
	hitbox.damage(weapon_attack)
	
	current_pierce_count += 1
	if current_pierce_count >= weapon_attack.max_pierce:
		queue_free()
