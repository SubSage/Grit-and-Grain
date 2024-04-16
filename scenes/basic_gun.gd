extends Node2D

class_name BASIC_GUN

@export var bullet_speed = 400
@export var fire_rate = 2.0
@export var angle_degree = 90
@export var friendly = false
@export var turn_rate = 20

var cooldown = 0

@onready var BULLET_CLASS = preload("res://scenes/bullet.tscn")
@onready var bullet_holding_node : Node = get_tree().root.find_child("BULLETS", true, false)
var window_size = Vector2(1920, 1080)


func _process(delta: float) -> void:
	cooldown -= delta
	cooldown = clamp(cooldown, -1, 100)
	
	var fire_weapon_input = Input.get_vector("fire_left", "fire_right", "fire_up", "fire_down")
	if fire_weapon_input.length() > .1:
		global_rotation = lerp_angle(global_rotation, fire_weapon_input.angle() - deg_to_rad(-90), turn_rate * delta)

	
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
