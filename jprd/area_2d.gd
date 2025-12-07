extends Area2D

var bend_speed = 1.5
var back_speed = 30.0
@export var skewvalue = 18.0

func _on_body_entered(body: Node2D) -> void:
	if "Soren" in body.name:
		var direction = global_position.direction_to(body.global_position) 
		var skew1 = -direction.x * skewvalue 
	
		var tween = create_tween() 
		tween.tween_property($"../Sprite2D", "skew", skew1, bend_speed).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
		
		var tween2 = create_tween()
		tween2.tween_property($"../Sprite2D", "skew", 0.0, bend_speed).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
