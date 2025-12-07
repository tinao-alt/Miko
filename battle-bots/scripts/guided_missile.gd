extends "./base_shell.gd"

@export_range(0.1, 2.8, 0.1) var speed_mult := 1.0
@export_range(0.1, 2.8, 0.1) var damage_mult := 1.0
@export_range(0.1, 2.8, 0.1) var homing_strength_mult := 1.0

var homing_strength := 1.0
var direction := Vector2(1, 0)

func _ready() -> void:
	super()
	distance = 500.0 * distance_mult
	speed = 300.0 * speed_mult
	damage = 35.0 * damage_mult
	homing_strength *= homing_strength_mult
	direction = direction.rotated(rotation)

func _physics_process(delta: float) -> void:
	if org_position.distance_to(global_position) > distance:
			queue_free()
	
	if _enemy:
		direction = direction.lerp((_enemy.global_position - global_position).normalized(), homing_strength * delta)
		rotation = direction.angle()
	position += speed * direction * delta
