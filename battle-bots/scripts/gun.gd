extends Node2D

@onready var _tank := $".."
@onready var player: int = _tank.get("player")
@onready var _cooldown_timer := $"Cooldown Timer"
@onready var _flash: AnimatedSprite2D = $Flash
@onready var _enemy: CharacterBody2D = $".."._enemy

@export_range(0.1, 2.8, 0.1) var rotation_speed_mult := 1.0
@export_range(0.1, 2.8, 0.1) var reload_speed_mult := 1.0
@export_range(0.1, 2.8, 0.1) var distance_mult := 1.0
@export_enum("Armour Piercing", "Guided Missile", "High Explosive") var shell_type := 0

const ArmourPiercing = preload("../scenes/armour_piercing.tscn")
const GuidedMissile = preload("../scenes/guided_missile.tscn")
const HighExplosive = preload("../scenes/high_explosive.tscn")
const shell_types = [ArmourPiercing, GuidedMissile, HighExplosive]

var rotation_speed := 2.0
var direction := Vector2(1, 0)
var yaw := 0.0

func _ready() -> void:
	rotation_speed *= rotation_speed_mult
	_cooldown_timer.wait_time /= reload_speed_mult

func can_fire() -> bool:
	if _tank.state == "dead":
		return false
	
	if _cooldown_timer.is_stopped() and ((Input.get_action_raw_strength("p1_fire") and player == 1) or (Input.get_action_raw_strength("p2_fire") and player == 2)):
		return true
	return false

func _physics_process(delta: float) -> void:
	yaw = Input.get_axis("p1_aim_left", "p1_aim_right") if player == 1 else Input.get_axis("p2_aim_left", "p2_aim_right")
	direction = direction.rotated(yaw * rotation_speed * delta)
	rotation = direction.angle() - get_parent().rotation
	
	if can_fire():
		_cooldown_timer.start()
		_flash.play("flash")
		var shell = shell_types[shell_type].instantiate()
		shell.global_position = global_position + Vector2(0, -80).rotated(global_rotation)
		shell.global_rotation = global_rotation
		shell.scale = 1.5 * _tank.scale
		shell.distance_mult = distance_mult
		shell.rotation -= PI/2
		if _enemy:
			shell._enemy = _enemy
		$"../..".add_child(shell)
