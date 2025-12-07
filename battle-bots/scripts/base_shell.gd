class_name BaseShell
extends Area2D

var speed: float
var damage: float
var distance: float
var distance_mult: float
var org_position: Vector2
var _enemy: CharacterBody2D

func _ready() -> void:
	org_position = global_position

func _physics_process(delta: float) -> void:
	if org_position.distance_to(global_position) > distance:
		queue_free()
	
	position += speed * Vector2(1, 0).rotated(global_rotation) * delta

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if body == _enemy:
			body.call_deferred("apply_damage", damage)
			queue_free()
	else:
		queue_free()
