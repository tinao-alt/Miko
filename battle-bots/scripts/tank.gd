extends CharacterBody2D

@export_range(1, 2) var player := 1
@export_range(0.1, 2.8, 0.1) var speed_mult := 1.0
@export_range(0.1, 2.8, 0.1) var rotation_speed_mult := 1.0
@export_range(0.1, 2.8, 0.1) var health_mult := 1.0

@export var _health_bar: ProgressBar
@warning_ignore("unused_private_class_variable")
@export var _enemy: CharacterBody2D

const Explosion = preload("../scenes/explosion.tscn")

var speed := 200.0
var rotation_speed := 2.0
var health := 100.0
var acceleration := 0.5
var friction := 0.6
var direction := Vector2(0, -1)
var thrust := 0.0
var yaw := 0.0
var state := "idle"

func _ready() -> void:
	speed *= speed_mult
	rotation_speed *= rotation_speed_mult
	health *= health_mult
	if _health_bar:
		_health_bar.max_value = health
		_health_bar.value = health

func apply_damage(damage):
	health -= damage
	if _health_bar:
		_health_bar.value = health
	
	if health <= 0:
		var explosion = Explosion.instantiate()
		explosion.global_position = global_position
		explosion.scale = 2 * scale
		explosion.damage = 20.0
		$"..".add_child(explosion)
		queue_free()

func change_state() -> void:
	thrust = Input.get_axis("p1_backward", "p1_forward") if player == 1 else Input.get_axis("p2_backward", "p2_forward")
	yaw = Input.get_axis("p1_left", "p1_right") if player == 1 else Input.get_axis("p2_left", "p2_right")
	
	match state:
		"idle":
			if thrust or yaw:
				state = "move"
		"move":
			if not (thrust or yaw):
				state = "idle"
		_:
			pass

func move(delta: float) -> void:
	match state:
		"idle":
			velocity = velocity.lerp(Vector2.ZERO, friction)
		"move":
			direction = direction.rotated(yaw * rotation_speed * delta)
			rotation = direction.rotated(PI/2).angle()
			velocity = velocity.lerp(direction * thrust * speed, acceleration)
	
	move_and_slide()

func _physics_process(delta: float) -> void:
	change_state()
	move(delta)
