extends "./base_shell.gd"

@export_range(0.1, 2.8, 0.1) var speed_mult := 1.0
@export_range(0.1, 2.8, 0.1) var damage_mult := 1.0
@export_range(0.1, 2.8, 0.1) var pierce_depth_mult := 1.0

var pierce_depth := 0.15

func _ready() -> void:
	super()
	distance = 700.0 * distance_mult
	speed = 700.0 * speed_mult
	damage = 50.0 * damage_mult
	pierce_depth *= pierce_depth_mult

func _physics_process(delta: float) -> void:
	super(delta)
	if has_overlapping_bodies() and not overlaps_body(self):
		pierce_depth -= delta
		if pierce_depth <= 0:
			queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body == _enemy:
		body.call_deferred("apply_damage", damage)
		call_deferred("queue_free")
