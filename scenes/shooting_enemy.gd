extends UNIT

@export var move_to_player_proximity = 250
@export var fire_at_player_proximity = 300

func _process(delta: float) -> void:
	
	if position.distance_to(player_node.position) > move_to_player_proximity:
		position = position.move_toward(player_node.position, speed * delta)
	if position.distance_to(player_node.position) <= fire_at_player_proximity:
		for gun in $WEAPONS.get_children():
			gun.fire()
	look_at(player_node.global_position)
