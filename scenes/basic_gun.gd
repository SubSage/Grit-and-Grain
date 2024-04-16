extends Node2D

class_name BASIC_GUN

@export var bullet_speed = 400
@export var fire_rate = 2.0
@export var angle_degree = 90
@export var friendly = false

var cooldown = 0

@onready var BULLET_CLASS = preload("res://scenes/bullet.tscn")
@onready var bullet_holding_node : Node = get_tree().root.find_child("BULLETS", true, false)
var window_size = Vector2(1920, 1080)


func _process(delta: float) -> void:
	cooldown -= delta
	cooldown = clamp(cooldown, -1, 100)
	if Input.is_action_pressed("fire_weapon") and cooldown <= 0:
		var bullet = BULLET_CLASS.instantiate()
		bullet.speed = bullet_speed
		bullet.global_position = global_position
		bullet.global_rotation = global_rotation
		bullet.rotation = rotation
		bullet.angle_radian = (global_rotation) - deg_to_rad(90)
		bullet_holding_node.add_child(bullet)
		if friendly:
			bullet.set_friendly()
		else:
			bullet.set_hostile()
		cooldown = 1.0/(fire_rate)
