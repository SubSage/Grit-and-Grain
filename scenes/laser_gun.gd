extends Node2D

class_name LASER_GUN

@export var bullet_speed = 400
@export var fire_rate = 2.0
@export var angle_degree = 90
@export var friendly = false
@export var turn_rate = 20
@export var enabled = true
var firing = false

var cooldown = 0

@onready var LASER_CLASS = preload("res://scenes/laser.tscn")
@onready var bullet_holding_node : Node = get_tree().root.find_child("BULLETS", true, false)
@export var player_controlled = false

func _process(delta: float) -> void:
	cooldown -= delta
	cooldown = clamp(cooldown, -1, 100)
	if not enabled:
		return
	if player_controlled:
		var fire_weapon_input = Input.get_vector("fire_left", "fire_right", "fire_up", "fire_down")
		if fire_weapon_input.length() > .1:
			global_rotation = lerp_angle(global_rotation, fire_weapon_input.angle() - deg_to_rad(-90), turn_rate * delta)

	
	if ((Input.is_action_pressed("fire_weapon") and player_controlled) or firing) and $Timer.is_stopped():
		start_laser_visual()
		$Timer.start()
		firing = false
		cooldown = 1.0/(fire_rate)

func fire():
	firing = true

func start_laser_visual():
	$NounKite1122256/NounRipple2343683.scale = Vector2.ONE * 6
	$NounKite1122256/NounMinus2160596.rotation_degrees = 120
	$NounKite1122256/NounMinus2160597.rotation_degrees = 60
	
	$NounKite1122256/NounMinus2160596.self_modulate.a = 0.0
	$NounKite1122256/NounMinus2160597.self_modulate.a = 0.0
	
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property($NounKite1122256/NounRipple2343683, "self_modulate", Color("d9001e"), 2.0)
	tween.tween_property($NounKite1122256/NounRipple2343683, "scale", Vector2(2.0, 2.0), 3.0)
	tween.tween_property($NounKite1122256/NounRipple2343683, "rotation", 4, 3.0)
	tween.tween_property($NounKite1122256/NounMinus2160596, "rotation_degrees", 90, 2.0)
	tween.tween_property($NounKite1122256/NounMinus2160597, "rotation_degrees", 90, 2.0)
	
	tween.tween_property($NounKite1122256/NounIrregularQuadrilateral1117058, "rotation_degrees", 90, 2.0)
	tween.tween_property($NounKite1122256/NounIrregularQuadrilateral1117059, "rotation_degrees", 90, 2.0)
	
	tween.tween_property($NounKite1122256/NounMinus2160596, "self_modulate:a", 1.0, 1.0)
	tween.tween_property($NounKite1122256/NounMinus2160597, "self_modulate:a", 1.0, 1.0)
	
	tween.set_parallel(false)
	tween.tween_property($NounKite1122256/NounRipple2343683, "self_modulate", Color.TRANSPARENT, .3)

	
	


func spawn_laser():
	$NounKite1122256/NounIrregularQuadrilateral1117058.rotation_degrees = 180
	$NounKite1122256/NounIrregularQuadrilateral1117059.rotation_degrees = 0
	$NounKite1122256/NounMinus2160596.self_modulate.a = 0.0
	$NounKite1122256/NounMinus2160597.self_modulate.a = 0.0
	var laser = LASER_CLASS.instantiate()
	laser.speed = bullet_speed
	laser.rotation = rotation
	laser.global_position = $Marker2D.global_position
	laser.global_rotation = global_rotation
	laser.angle_radian = (global_rotation) - deg_to_rad(90)
	if friendly:
		laser.set_friendly()
	else:
		laser.set_hostile()
	bullet_holding_node.add_child(laser)
