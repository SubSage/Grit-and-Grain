extends UNIT
class_name PLAYER

@export var turn_rate = 20
var dead = false

func _process(delta: float) -> void:
	if dead:
		return
	var movement_input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	position += movement_input * speed * delta
	if movement_input.length() > .1:
		rotation = lerp_angle(rotation, movement_input.angle() - deg_to_rad(-90), turn_rate * delta)
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	take_hit(1)

func die():
	dead = true
	visible = false
