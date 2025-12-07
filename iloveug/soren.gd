extends CharacterBody2D

@export var speed = 150
@onready var animation_player = $AnimationPlayer
@onready var sprite = $"Kai-sheet"

var is_attacking = false

func _physics_process(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")

	if not is_attacking:
		velocity = input_direction * speed
		move_and_slide()
		update_animation(input_direction)
	else:
		velocity = Vector2.ZERO
		move_and_slide() 

	if Input.is_action_just_pressed("attack") and not is_attacking:
		is_attacking = true
		animation_player.play("attack_b")

func update_animation(input_direction):
	if input_direction.x > 0:
		animation_player.play("walk r")
		sprite.flip_h = false
	elif input_direction.x < 0:
		animation_player.play("walk r")
		sprite.flip_h = true
	elif input_direction.y < 0:
		animation_player.play("walk b")
	elif input_direction.y > 0:
		animation_player.play("walk f")
	else:
		animation_player.play("new_animation")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "attack_b":
		is_attacking = false

		var input_direction = Input.get_vector("left", "right", "up", "down")
		update_animation(input_direction)
