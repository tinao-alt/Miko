extends Node2D

var rotate_icon = true
var speed = 10

func _process(delta: float) -> void:
	if rotate_icon:
		$Icon.rotate(delta)
	
	if Input.is_action_pressed("move_down"):
		$Icon.position.y += speed
	if Input.is_action_pressed("move_up"):
		$Icon.position.y -= speed

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_rotation"):
		rotate_icon = !rotate_icon
