class_name EnemyAttackProjectile

extends Area2D

@export var attack: Attack = Attack.new()
@export var projectile_speed: float = 400.0
@export var projectile_lifetime: float = 3.0
@export var direction: Vector2 = Vector2.RIGHT

var velocity: Vector2 = Vector2.ZERO
var remaining_time: float = 0.0

func _init() -> void:
    self.area_entered.connect(_on_area_entered)


func _ready() -> void:
    velocity = direction.normalized() * projectile_speed
    remaining_time = projectile_lifetime


func _physics_process(delta: float) -> void:
    position += velocity * delta
    remaining_time -= delta
    if remaining_time <= 0.0:
        queue_free()


func _on_area_entered(area: Area2D) -> void:
    if area is HitboxComponent:
        area.damage(attack)

    queue_free()