extends CharacterBody2D

@onready var animation_player = $AnimationPlayer

func _ready():
	# Set the animation to loop and play it
	animation_player.get_animation("idlesam").loop = true
	animation_player.play("idlesam")
