extends UNIT
class_name PLAYER

@export var turn_rate = 20
var dead = false

var mode = 0

func _process(delta: float) -> void:
	if dead:
		return
	var movement_input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	position += movement_input * speed * delta
	if movement_input.length() > .1:
		rotation = lerp_angle(rotation, movement_input.angle() - deg_to_rad(-90), turn_rate * delta)
	
	if Input.is_action_just_pressed("next_mode"):
		for gun in $WEAPONS.get_child(mode).get_children():
			gun.stop()
			gun.enabled = false
			
		$WEAPONS.get_child(mode).visible = false
		mode += 1
		mode = wrap(mode, 0, $WEAPONS.get_child_count())
		$WEAPONS.get_child(mode).visible = true
		
		for gun in $WEAPONS.get_child(mode).get_children():
			gun.enabled = true
		

func _on_area_2d_area_entered(area: Area2D) -> void:
	var dmg = 1
	if area.owner.is_in_group("kill_wall"):
		die()
	take_hit(1)

func die():
	dead = true
	visible = false
