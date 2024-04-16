extends UNIT



func _process(delta: float) -> void:
	
	position = position.move_toward(player_node.position, speed * delta)
