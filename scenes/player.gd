extends Node2D
class_name PLAYER

@export var health = 5
@export var speed = 400
@export var turn_rate = 20

var window_size = Vector2(1920, 1080)



func _process(delta: float) -> void:
	var movement_input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	#var fire_weapon_input = Input.get_vector("fire_left", "fire_right", "fire_up", "fire_down")
	position += movement_input * speed * delta
	#position.x = clamp(position.x, 0, window_size.x)
	#position.y = clamp(position.y, 0, window_size.y)
	if movement_input.length() > .1:
		rotation = lerp_angle(rotation, movement_input.angle() - deg_to_rad(-90), turn_rate * delta)



func take_hit(damage):
	health -= damage
	if health <= 0:
		queue_free()
