extends "./base_shell.gd"

@export_range(0.1, 2.8, 0.1) var speed_mult := 1.0
@export_range(0.1, 2.8, 0.1) var damage_mult := 1.0
@export_range(0.1, 2.8, 0.1) var explosion_range_mult := 1.0

const Explosion = preload("../scenes/explosion.tscn")

var explosion_range = 1.5

func _ready() -> void:
	super()
	distance = 400.0 * distance_mult
	speed = 400.0 * speed_mult
	damage = 20.0 * damage_mult
	explosion_range *= explosion_range_mult

func explode():
	var explosion = Explosion.instantiate()
	explosion.global_position = global_position
	explosion.scale = explosion_range * explosion_range_mult * scale
	explosion.damage = 30.0 * damage_mult
	$"..".add_child(explosion)
	queue_free()

func _physics_process(delta: float) -> void:
	if org_position.distance_to(global_position) > distance:
		explode()
	
	position += speed * Vector2(1, 0).rotated(rotation) * delta

func _on_body_entered(body: Node2D) -> void:
	if body == _enemy:
		body.apply_damage(damage)
		call_deferred("explode")
	
	if body is not CharacterBody2D:
		call_deferred("explode")
