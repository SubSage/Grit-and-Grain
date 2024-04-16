extends UNIT
class_name PLAYER

@export var turn_rate = 20


func _process(delta: float) -> void:
	var movement_input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	position += movement_input * speed * delta
	if movement_input.length() > .1:
		rotation = lerp_angle(rotation, movement_input.angle() - deg_to_rad(-90), turn_rate * delta)
	
