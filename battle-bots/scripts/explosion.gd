extends Area2D

var damage: float

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.call_deferred("apply_damage", damage)

func _on_explode_animation_finished() -> void:
	queue_free()
